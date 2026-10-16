<template>
  <MainLayout>
    <div class="order-list-container">
      <h2 class="page-title">我的订单</h2>

      <el-card>
        <el-tabs v-model="activeTab" @tab-change="handleTabChange">
          <el-tab-pane label="全部订单" name="all" />
          <el-tab-pane label="待支付" name="0" />
          <el-tab-pane label="已支付" name="1" />
          <el-tab-pane label="租赁中" name="2" />
          <el-tab-pane label="归还中" name="3" />
          <el-tab-pane label="已归还" name="4" />
          <el-tab-pane label="已取消" name="5" />
        </el-tabs>

        <div v-loading="loading">
          <div v-for="order in orderList" :key="order.orderId" class="order-item">
            <div class="order-header">
              <span>订单号: {{ order.orderNo }}</span>
              <span>{{ order.createTime }}</span>
              <el-tag :type="getStatusType(order.status)">{{ getStatusText(order.status) }}</el-tag>
            </div>

            <div class="order-content">
              <div class="equipment-info">
                <div class="equipment-name">{{ order.equipmentName }}</div>
                <div class="order-details">
                  <span>数量: {{ order.quantity }}</span>
                  <span>租期: {{ getRentalPeriod(order) }}</span>
                </div>
              </div>

              <div class="order-price">
                <div class="price-item">
                  <span>租金:</span>
                  <span class="price">¥{{ order.rentalAmount }}</span>
                </div>
                <div class="price-item">
                  <span>押金:</span>
                  <span class="price">¥{{ order.depositAmount }}</span>
                </div>
                <div class="price-item total">
                  <span>总计:</span>
                  <span class="price">¥{{ order.totalAmount }}</span>
                </div>
              </div>

              <div class="order-actions">
                <el-button size="small" @click="handleViewDetail(order.orderId)">查看详情</el-button>
                <el-button
                  v-if="order.status === '0'"
                  type="primary"
                  size="small"
                  @click="handlePay(order.orderId)"
                >
                  立即支付
                </el-button>
                <el-button
                  v-if="order.status === '0'"
                  type="danger"
                  size="small"
                  @click="handleCancel(order.orderId)"
                >
                  取消订单
                </el-button>
                <el-button
                  v-if="order.status === '2'"
                  type="success"
                  size="small"
                  @click="handleReturn(order.orderId)"
                >
                  申请归还
                </el-button>
                <el-button
                  v-if="order.status === '2' && (!order.extendStatus || order.extendStatus === '2')"
                  type="info"
                  size="small"
                  @click="handleExtend(order)"
                >
                  申请延期
                </el-button>
                <el-tag v-if="order.extendStatus === '0'" type="warning" size="small">延期待审批</el-tag>
                <el-tag v-if="order.extendStatus === '1'" type="success" size="small">延期已批准</el-tag>
                <el-tag v-if="order.isDamaged === '1'" type="danger" size="small">设备损坏</el-tag>
                <el-button
                  v-if="order.status === '4' && !order.reviewed"
                  type="warning"
                  size="small"
                  @click="handleReview(order)"
                >
                  去评价
                </el-button>
                <el-tag v-if="order.status === '4' && order.reviewed" type="success" size="small">已评价</el-tag>
              </div>
            </div>
          </div>

          <el-empty v-if="orderList.length === 0" description="暂无订单" />

          <div class="pagination" v-if="pagination.total > 0">
            <el-pagination
              v-model:current-page="pagination.pageNum"
              v-model:page-size="pagination.pageSize"
              :total="pagination.total"
              layout="total, prev, pager, next"
              @current-change="loadOrders"
            />
          </div>
        </div>
      </el-card>

      <!-- 归还弹窗 -->
      <el-dialog v-model="showReturnDialog" title="申请归还" width="500px">
        <el-form :model="returnForm" :rules="returnRules" ref="returnFormRef" label-width="100px">
          <el-form-item label="快递公司" prop="returnExpressCompany">
            <el-select v-model="returnForm.returnExpressCompany" placeholder="请选择快递公司" style="width: 100%">
              <el-option label="顺丰速运" value="顺丰速运" />
              <el-option label="中通快递" value="中通快递" />
              <el-option label="圆通速递" value="圆通速递" />
              <el-option label="申通快递" value="申通快递" />
              <el-option label="韵达快递" value="韵达快递" />
              <el-option label="邮政EMS" value="邮政EMS" />
              <el-option label="京东物流" value="京东物流" />
            </el-select>
          </el-form-item>
          <el-form-item label="快递单号" prop="returnExpressNo">
            <el-input v-model="returnForm.returnExpressNo" placeholder="请输入快递单号" />
          </el-form-item>
          <el-alert
            title="温馨提示"
            type="info"
            :closable="false"
            show-icon
          >
            <p>请将设备妥善包装后寄回,并填写正确的快递单号</p>
            <p>管理员确认收货后将退还押金</p>
          </el-alert>
        </el-form>
        <template #footer>
          <el-button @click="showReturnDialog = false">取消</el-button>
          <el-button type="primary" @click="submitReturn" :loading="returning">确认归还</el-button>
        </template>
      </el-dialog>

      <!-- 评价弹窗 -->
      <el-dialog v-model="showReviewDialog" title="设备评价" width="500px">
        <el-form :model="reviewForm" ref="reviewFormRef" label-width="80px">
          <el-form-item label="评分">
            <el-rate v-model="reviewForm.rating" show-text :texts="['很差', '差', '一般', '好', '很好']" />
          </el-form-item>
          <el-form-item label="评价内容">
            <el-input v-model="reviewForm.content" type="textarea" :rows="4" placeholder="请输入您的评价" />
          </el-form-item>
        </el-form>
        <template #footer>
          <el-button @click="showReviewDialog = false">取消</el-button>
          <el-button type="primary" @click="submitReview" :loading="reviewing">提交评价</el-button>
        </template>
      </el-dialog>

      <!-- 延期弹窗 -->
      <el-dialog v-model="showExtendDialog" title="申请延期" width="450px">
        <el-form label-width="100px">
          <el-form-item label="延期天数">
            <el-input-number v-model="extendDays" :min="1" :max="30" />
          </el-form-item>
          <el-form-item label="预估费用">
            <span style="font-size: 18px; color: #f56c6c; font-weight: bold">
              ¥{{ estimateExtendFee }}
            </span>
          </el-form-item>
          <el-alert title="延期费用 = 日租金 × 延期天数，审批通过后生效" type="info" :closable="false" />
        </el-form>
        <template #footer>
          <el-button @click="showExtendDialog = false">取消</el-button>
          <el-button type="primary" @click="submitExtend" :loading="extending">提交申请</el-button>
        </template>
      </el-dialog>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import MainLayout from '@/components/Layout/MainLayout.vue'
import { myOrderList, payOrder, cancelOrder, applyReturn, applyExtend } from '@/api/order'
import { addReview, checkReview } from '@/api/review'

const router = useRouter()
const loading = ref(false)
const activeTab = ref('all')
const orderList = ref([])
const showReturnDialog = ref(false)
const returning = ref(false)
const returnFormRef = ref(null)
const currentOrderId = ref(null)
const showReviewDialog = ref(false)
const reviewing = ref(false)
const reviewFormRef = ref(null)
const currentReviewOrder = ref(null)
const reviewForm = ref({ rating: 5, content: '' })
const showExtendDialog = ref(false)
const extending = ref(false)
const extendDays = ref(3)
const currentExtendOrder = ref(null)

const estimateExtendFee = computed(() => {
  if (currentExtendOrder.value && currentExtendOrder.value.unitPrice) {
    return (currentExtendOrder.value.unitPrice * extendDays.value).toFixed(2)
  }
  return '0.00'
})

// 归还表单
const returnForm = ref({
  returnExpressCompany: '',
  returnExpressNo: ''
})

// 归还表单验证
const returnRules = {
  returnExpressCompany: [
    { required: true, message: '请选择快递公司', trigger: 'change' }
  ],
  returnExpressNo: [
    { required: true, message: '请输入快递单号', trigger: 'blur' },
    { min: 8, message: '快递单号至少8位', trigger: 'blur' }
  ]
}

const pagination = reactive({
  pageNum: 1,
  pageSize: 10,
  total: 0
})

const getStatusType = (status) => {
  const types = {
    '0': 'warning',
    '1': 'info',
    '2': 'primary',
    '3': 'success',
    '4': 'danger',
    '5': 'info'
  }
  return types[status] || 'info'
}

const getStatusText = (status) => {
  const texts = {
    '0': '待支付',
    '1': '已支付',
    '2': '租赁中',
    '3': '归还中',
    '4': '已归还',
    '5': '已取消'
  }
  return texts[status] || '未知'
}

const getRentalPeriod = (order) => {
  if (order.rentalType === '1') {
    return `${order.rentalDays}天`
  } else if (order.rentalType === '2') {
    return '1周'
  } else {
    return '1月'
  }
}

const loadOrders = () => {
  loading.value = true
  const params = {
    pageNum: pagination.pageNum,
    pageSize: pagination.pageSize
  }
  
  if (activeTab.value !== 'all') {
    params.status = activeTab.value
  }

  myOrderList(params).then(res => {
    orderList.value = res.rows || []
    pagination.total = res.total || 0
    checkOrderReviews()
  }).finally(() => {
    loading.value = false
  })
}

const handleTabChange = () => {
  pagination.pageNum = 1
  loadOrders()
}

const handleViewDetail = (orderId) => {
  router.push(`/orders/${orderId}`)
}

const handlePay = (orderId) => {
  ElMessageBox.confirm('确认支付该订单?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'info'
  }).then(() => {
    payOrder(orderId).then(() => {
      ElMessage.success('支付成功')
      loadOrders()
    })
  })
}

const handleCancel = (orderId) => {
  ElMessageBox.confirm('确认取消该订单?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    cancelOrder(orderId).then(() => {
      ElMessage.success('订单已取消')
      loadOrders()
    })
  })
}

const handleReturn = (orderId) => {
  currentOrderId.value = orderId
  returnForm.value = {
    returnExpressCompany: '',
    returnExpressNo: ''
  }
  showReturnDialog.value = true
}

const submitReturn = () => {
  returnFormRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    
    returning.value = true
    const data = {
      orderId: currentOrderId.value,
      returnExpressCompany: returnForm.value.returnExpressCompany,
      returnExpressNo: returnForm.value.returnExpressNo
    }
    
    applyReturn(data).then(() => {
      ElMessage.success('归还申请已提交,请等待管理员确认收货')
      showReturnDialog.value = false
      loadOrders()
    }).finally(() => {
      returning.value = false
    })
  })
}

const handleReview = (order) => {
  currentReviewOrder.value = order
  reviewForm.value = { rating: 5, content: '' }
  showReviewDialog.value = true
}

const submitReview = () => {
  reviewing.value = true
  const data = {
    orderId: currentReviewOrder.value.orderId,
    equipmentId: currentReviewOrder.value.equipmentId,
    rating: reviewForm.value.rating,
    content: reviewForm.value.content
  }
  addReview(data).then(() => {
    ElMessage.success('评价成功')
    showReviewDialog.value = false
    currentReviewOrder.value.reviewed = true
  }).finally(() => {
    reviewing.value = false
  })
}

const handleExtend = (order) => {
  currentExtendOrder.value = order
  extendDays.value = 3
  showExtendDialog.value = true
}

const submitExtend = () => {
  extending.value = true
  applyExtend(currentExtendOrder.value.orderId, extendDays.value).then(() => {
    ElMessage.success('延期申请已提交，请等待审批')
    showExtendDialog.value = false
    loadOrders()
  }).finally(() => {
    extending.value = false
  })
}

// 检查订单评价状态
const checkOrderReviews = async () => {
  const returnedOrders = orderList.value.filter(o => o.status === '4')
  for (const order of returnedOrders) {
    try {
      const res = await checkReview(order.orderId)
      order.reviewed = res.data === true
    } catch (e) {
      order.reviewed = false
    }
  }
}

onMounted(() => {
  loadOrders()
})
</script>

<style scoped>
.order-list-container {
  max-width: 1000px;
  margin: 0 auto;
}

.page-title {
  font-size: 24px;
  margin-bottom: 20px;
}

.order-item {
  border: 1px solid #e8e8e8;
  border-radius: 4px;
  margin-bottom: 15px;
  overflow: hidden;
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 20px;
  background: #f5f5f5;
  font-size: 14px;
  color: #666;
}

.order-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  gap: 20px;
}

.equipment-info {
  flex: 1;
}

.equipment-name {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 10px;
}

.order-details {
  display: flex;
  gap: 20px;
  font-size: 14px;
  color: #666;
}

.order-price {
  min-width: 150px;
}

.price-item {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
  font-size: 14px;
}

.price-item.total {
  font-size: 16px;
  font-weight: bold;
  margin-top: 10px;
  padding-top: 10px;
  border-top: 1px solid #e8e8e8;
}

.price {
  color: #f56c6c;
}

.order-actions {
  display: flex;
  flex-direction: column;
  gap: 10px;
  min-width: 120px;
}

.pagination {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}
</style>
