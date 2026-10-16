<template>
  <MainLayout>
    <div class="order-detail-container" v-loading="loading">
      <h2 class="page-title">订单详情</h2>

      <el-card v-if="order">
        <div class="order-status">
          <el-result
            :icon="getStatusIcon(order.status)"
            :title="getStatusText(order.status)"
            :sub-title="`订单号: ${order.orderNo}`"
          >
            <template #extra>
              <el-button
                v-if="order.status === '0'"
                type="primary"
                @click="handlePay"
              >
                立即支付
              </el-button>
              <el-button
                v-if="order.status === '0'"
                @click="handleCancel"
              >
                取消订单
              </el-button>
              <el-button
                v-if="order.status === '2'"
                type="warning"
                @click="showReturnDialog = true"
              >
                我要归还
              </el-button>
              <el-button @click="$router.back()">返回</el-button>
            </template>
          </el-result>
        </div>

        <el-descriptions title="订单信息" :column="2" border>
          <el-descriptions-item label="设备名称">{{ order.equipmentName }}</el-descriptions-item>
          <el-descriptions-item label="租赁数量">{{ order.quantity }}</el-descriptions-item>
          <el-descriptions-item label="租赁类型">
            <el-tag v-if="order.rentalType === '1'">日租</el-tag>
            <el-tag v-else-if="order.rentalType === '2'">周租</el-tag>
            <el-tag v-else>月租</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="租赁天数">{{ order.rentalDays || '-' }}</el-descriptions-item>
          <el-descriptions-item label="开始时间">{{ order.startTime || '-' }}</el-descriptions-item>
          <el-descriptions-item label="结束时间">{{ order.endTime || '-' }}</el-descriptions-item>
          <el-descriptions-item label="租金">¥{{ order.rentalAmount }}</el-descriptions-item>
          <el-descriptions-item label="押金">¥{{ order.depositAmount }}</el-descriptions-item>
          <el-descriptions-item label="订单总额">
            <span class="total-price">¥{{ order.totalAmount }}</span>
          </el-descriptions-item>
          <el-descriptions-item label="订单状态">
            <el-tag :type="getStatusType(order.status)">{{ getStatusText(order.status) }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="创建时间">{{ order.createTime }}</el-descriptions-item>
          <el-descriptions-item label="支付时间">{{ order.payTime || '-' }}</el-descriptions-item>
        </el-descriptions>

        <!-- 收货地址 -->
        <el-descriptions v-if="order.receiverName" title="收货地址" :column="2" border style="margin-top: 20px">
          <el-descriptions-item label="收货人">{{ order.receiverName }}</el-descriptions-item>
          <el-descriptions-item label="联系电话">{{ order.receiverPhone }}</el-descriptions-item>
          <el-descriptions-item label="收货地址" :span="2">{{ order.receiverAddress }}</el-descriptions-item>
        </el-descriptions>

        <!-- 归还信息 -->
        <el-descriptions v-if="order.returnExpressNo" title="归还信息" :column="2" border style="margin-top: 20px">
          <el-descriptions-item label="快递公司">{{ order.returnExpressCompany }}</el-descriptions-item>
          <el-descriptions-item label="快递单号">{{ order.returnExpressNo }}</el-descriptions-item>
          <el-descriptions-item label="申请时间" :span="2">{{ order.returnApplyTime }}</el-descriptions-item>
        </el-descriptions>

        <div v-if="order.userRemark" class="remark-section">
          <h4>用户备注</h4>
          <p>{{ order.userRemark }}</p>
        </div>

        <div v-if="order.adminRemark" class="remark-section">
          <h4>管理员备注</h4>
          <p>{{ order.adminRemark }}</p>
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
          <el-button type="primary" @click="handleReturn" :loading="returning">确认归还</el-button>
        </template>
      </el-dialog>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import MainLayout from '@/components/Layout/MainLayout.vue'
import { getOrder, payOrder, cancelOrder, applyReturn } from '@/api/order'

const route = useRoute()
const router = useRouter()
const loading = ref(false)
const order = ref(null)
const showReturnDialog = ref(false)
const returning = ref(false)
const returnFormRef = ref(null)

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

const getStatusIcon = (status) => {
  const icons = {
    '0': 'warning',
    '1': 'info',
    '2': 'success',
    '3': 'success',
    '4': 'success',
    '5': 'info'
  }
  return icons[status] || 'info'
}

const loadOrder = () => {
  loading.value = true
  const orderId = route.params.id
  getOrder(orderId).then(res => {
    order.value = res.data
  }).finally(() => {
    loading.value = false
  })
}

const handlePay = () => {
  ElMessageBox.confirm('确认支付该订单?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'info'
  }).then(() => {
    payOrder(order.value.orderId).then(() => {
      ElMessage.success('支付成功')
      loadOrder()
    })
  })
}

const handleCancel = () => {
  ElMessageBox.confirm('确认取消该订单?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    cancelOrder(order.value.orderId).then(() => {
      ElMessage.success('订单已取消')
      loadOrder()
    })
  })
}

const handleReturn = () => {
  returnFormRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    
    returning.value = true
    const data = {
      orderId: order.value.orderId,
      returnExpressCompany: returnForm.value.returnExpressCompany,
      returnExpressNo: returnForm.value.returnExpressNo
    }
    
    applyReturn(data).then(() => {
      ElMessage.success('归还申请已提交,请等待管理员确认收货')
      showReturnDialog.value = false
      loadOrder()
    }).finally(() => {
      returning.value = false
    })
  })
}

onMounted(() => {
  loadOrder()
})
</script>

<style scoped>
.order-detail-container {
  max-width: 900px;
  margin: 0 auto;
}

.page-title {
  font-size: 24px;
  margin-bottom: 20px;
}

.order-status {
  margin-bottom: 30px;
}

.total-price {
  font-size: 18px;
  font-weight: bold;
  color: #f56c6c;
}

.remark-section {
  margin-top: 20px;
  padding: 15px;
  background: #f5f5f5;
  border-radius: 4px;
}

.remark-section h4 {
  margin-bottom: 10px;
  color: #333;
}

.remark-section p {
  color: #666;
  line-height: 1.6;
}
</style>
