<template>
  <MainLayout>
    <div class="checkout-container">
      <!-- 返回按钮 -->
      <el-button
        type="text"
        icon="el-icon-arrow-left"
        @click="$router.back()"
        class="back-button"
      >
        返回购物车
      </el-button>

      <h2 class="page-title">确认订单</h2>

      <el-card class="order-items">
        <template #header>
          <h3>租赁设备</h3>
        </template>
        
        <el-table :data="checkoutItems" style="width: 100%">
          <el-table-column label="设备信息" min-width="250">
            <template #default="{ row }">
              <div class="equipment-info">
                <img :src="getImageUrl(row.equipment.mainImage)" class="equipment-image" @error="handleImageError" />
                <div>
                  <div class="equipment-name">{{ row.equipment.equipmentName }}</div>
                  <div class="equipment-brand">{{ row.equipment.brand }}</div>
                </div>
              </div>
            </template>
          </el-table-column>

          <el-table-column label="租赁类型" width="100">
            <template #default="{ row }">
              <el-tag v-if="row.rentalType === '1'">日租</el-tag>
              <el-tag v-else-if="row.rentalType === '2'">周租</el-tag>
              <el-tag v-else>月租</el-tag>
            </template>
          </el-table-column>

          <el-table-column label="租期" width="100">
            <template #default="{ row }">
              {{ row.rentalType === '1' ? row.rentalDays + '天' : (row.rentalType === '2' ? '1周' : '1月') }}
            </template>
          </el-table-column>

          <el-table-column label="数量" prop="quantity" width="80" />

          <el-table-column label="押金" width="120">
            <template #default="{ row }">
              <span class="price">¥{{ row.equipment.deposit * row.quantity }}</span>
            </template>
          </el-table-column>

          <el-table-column label="租金" width="120">
            <template #default="{ row }">
              <span class="price">¥{{ calculateRental(row) }}</span>
            </template>
          </el-table-column>
        </el-table>
      </el-card>

      <!-- 收货地址 -->
      <el-card class="address-card">
        <template #header>
          <h3>收货地址</h3>
        </template>
        
        <el-form :model="addressForm" :rules="addressRules" ref="addressFormRef" label-width="100px">
          <el-form-item label="收货人" prop="receiverName">
            <el-input v-model="addressForm.receiverName" placeholder="请输入收货人姓名" />
          </el-form-item>
          <el-form-item label="联系电话" prop="receiverPhone">
            <el-input v-model="addressForm.receiverPhone" placeholder="请输入联系电话" />
          </el-form-item>
          <el-form-item label="收货地址" prop="receiverAddress">
            <el-input
              v-model="addressForm.receiverAddress"
              type="textarea"
              :rows="3"
              placeholder="请输入详细地址（省市区+街道门牌号）"
            />
          </el-form-item>
        </el-form>
      </el-card>

      <!-- 优惠码 -->
      <el-card class="coupon-card">
        <template #header>
          <h3>优惠码</h3>
        </template>
        <div style="display: flex; gap: 10px; align-items: center">
          <el-input v-model="couponCode" placeholder="请输入优惠码" style="flex: 1" :disabled="couponApplied" />
          <el-button v-if="!couponApplied" type="primary" @click="handleApplyCoupon" :loading="validatingCoupon">验证</el-button>
          <el-button v-else type="danger" @click="handleRemoveCoupon">取消</el-button>
        </div>
        <div v-if="couponApplied" style="margin-top: 10px; color: #67c23a">
          ✅ {{ couponInfo.couponName }} - 优惠 ¥{{ discountAmount }}
        </div>
      </el-card>

      <el-card class="order-summary">
        <template #header>
          <h3>订单汇总</h3>
        </template>

        <div class="summary-item">
          <span>租金合计:</span>
          <span class="price">¥{{ totalRental }}</span>
        </div>
        <div class="summary-item">
          <span>押金合计:</span>
          <span class="price">¥{{ totalDeposit }}</span>
        </div>
        <div class="summary-item" v-if="couponApplied">
          <span>优惠折扣:</span>
          <span style="color: #67c23a">-¥{{ discountAmount }}</span>
        </div>
        <el-divider />
        <div class="summary-item total">
          <span>应付总额:</span>
          <span class="total-price">¥{{ totalAmount }}</span>
        </div>

        <div class="checkout-actions">
          <el-button size="large" @click="$router.back()">返回购物车</el-button>
          <el-button
            type="primary"
            size="large"
            :loading="submitting"
            @click="handleSubmit"
          >
            提交订单
          </el-button>
        </div>
      </el-card>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import MainLayout from '@/components/Layout/MainLayout.vue'
import { useCartStore } from '@/stores/cart'
import { createOrder, validateCoupon } from '@/api/order'

const route = useRoute()
const router = useRouter()
const cartStore = useCartStore()

const checkoutItems = ref([])
const submitting = ref(false)
const addressFormRef = ref(null)
const couponCode = ref('')
const couponApplied = ref(false)
const couponInfo = ref(null)
const discountAmount = ref('0.00')
const validatingCoupon = ref(false)

// 收货地址表单
const addressForm = ref({
  receiverName: '',
  receiverPhone: '',
  receiverAddress: ''
})

// 地址表单验证规则
const addressRules = {
  receiverName: [
    { required: true, message: '请输入收货人姓名', trigger: 'blur' }
  ],
  receiverPhone: [
    { required: true, message: '请输入联系电话', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
  ],
  receiverAddress: [
    { required: true, message: '请输入收货地址', trigger: 'blur' },
    { min: 10, message: '地址至少10个字符', trigger: 'blur' }
  ]
}

const totalRental = computed(() => {
  return checkoutItems.value.reduce((total, item) => {
    return total + parseFloat(calculateRental(item))
  }, 0).toFixed(2)
})

const totalDeposit = computed(() => {
  return checkoutItems.value.reduce((total, item) => {
    return total + (item.equipment.deposit * item.quantity)
  }, 0).toFixed(2)
})

const totalAmount = computed(() => {
  const base = parseFloat(totalRental.value) + parseFloat(totalDeposit.value)
  const discount = couponApplied.value ? parseFloat(discountAmount.value) : 0
  return Math.max(0, base - discount).toFixed(2)
})

const handleApplyCoupon = () => {
  if (!couponCode.value) {
    ElMessage.warning('请输入优惠码')
    return
  }
  validatingCoupon.value = true
  validateCoupon(couponCode.value, totalRental.value).then(res => {
    couponApplied.value = true
    couponInfo.value = res.data
    discountAmount.value = parseFloat(res.data.discountAmount).toFixed(2)
    ElMessage.success('优惠码应用成功')
  }).catch(() => {
    ElMessage.error('优惠码无效或不满足使用条件')
  }).finally(() => {
    validatingCoupon.value = false
  })
}

const handleRemoveCoupon = () => {
  couponApplied.value = false
  couponInfo.value = null
  discountAmount.value = '0.00'
  couponCode.value = ''
}

const calculateRental = (item) => {
  const equipment = item.equipment
  let price = 0
  
  if (item.rentalType === '1') {
    price = equipment.dailyPrice * item.rentalDays
  } else if (item.rentalType === '2') {
    price = equipment.weeklyPrice
  } else {
    price = equipment.monthlyPrice
  }
  
  return (price * item.quantity).toFixed(2)
}

// 获取图片完整URL
const getImageUrl = (imagePath) => {
  if (!imagePath) {
    return '/placeholder.jpg'
  }
  // 如果已经是完整URL，直接返回
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    return imagePath
  }
  // 否则添加后端API地址前缀
  return `http://localhost:8080${imagePath}`
}

// 图片加载失败处理
const handleImageError = (e) => {
  e.target.src = '/placeholder.jpg'
}

const handleSubmit = () => {
  // 先验证地址表单
  addressFormRef.value.validate((valid) => {
    if (!valid) {
      ElMessage.warning('请完善收货地址信息')
      return
    }
    
    submitting.value = true
    
    // 创建订单 - 这里简化处理,实际应该批量创建或者后端支持购物车结算
    const promises = checkoutItems.value.map(item => {
      const orderData = {
        equipmentId: item.equipmentId,
        equipmentName: item.equipment.equipmentName,
        quantity: item.quantity,
        rentalType: item.rentalType,
        rentalDays: item.rentalDays,
        unitPrice: item.rentalType === '1' ? item.equipment.dailyPrice : 
                   (item.rentalType === '2' ? item.equipment.weeklyPrice : item.equipment.monthlyPrice),
        rentalAmount: calculateRental(item),
        depositAmount: item.equipment.deposit * item.quantity,
        totalAmount: parseFloat(calculateRental(item)) + (item.equipment.deposit * item.quantity) - (couponApplied.value ? parseFloat(discountAmount.value) / checkoutItems.value.length : 0),
        // 添加收货地址信息
        receiverName: addressForm.value.receiverName,
        receiverPhone: addressForm.value.receiverPhone,
        receiverAddress: addressForm.value.receiverAddress,
        // 优惠码
        couponCode: couponApplied.value ? couponCode.value : null,
        discountAmount: couponApplied.value ? parseFloat(discountAmount.value) / checkoutItems.value.length : null
      }
      return createOrder(orderData)
    })

    Promise.all(promises).then(() => {
      ElMessage.success('订单提交成功')
      // 清空购物车中已结算的商品
      const cartIds = checkoutItems.value.map(item => item.cartId).join(',')
      cartStore.deleteCartItem(cartIds)
      // 跳转到订单列表
      router.push('/orders')
    }).catch(() => {
      ElMessage.error('订单提交失败')
    }).finally(() => {
      submitting.value = false
    })
  })
}

onMounted(() => {
  // 从购物车获取选中的商品
  const itemIds = JSON.parse(route.query.items || '[]')
  checkoutItems.value = cartStore.cartList.filter(item => itemIds.includes(item.cartId))
  
  if (checkoutItems.value.length === 0) {
    ElMessage.warning('没有选中的商品')
    router.push('/cart')
  }
})
</script>

<style scoped>
.back-button {
  margin-bottom: 20px;
  font-size: 16px;
}

.checkout-container {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
}
.page-title {
  font-size: 24px;
  margin-bottom: 20px;
}

.order-items,
.address-card {
  margin-bottom: 20px;
}

.equipment-info {
  display: flex;
  align-items: center;
  gap: 15px;
}

.equipment-image {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 4px;
  background-color: #f5f5f5;
  display: block;
}

.equipment-name {
  font-size: 14px;
  font-weight: bold;
  margin-bottom: 5px;
}

.equipment-brand {
  font-size: 12px;
  color: #999;
}

.price {
  color: #f56c6c;
  font-weight: bold;
}

.order-summary {
  position: sticky;
  top: 20px;
}

.summary-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
  font-size: 16px;
}

.summary-item.total {
  font-size: 18px;
  font-weight: bold;
}

.total-price {
  font-size: 28px;
  color: #f56c6c;
}

.checkout-actions {
  display: flex;
  gap: 15px;
  margin-top: 30px;
}

.checkout-actions .el-button {
  flex: 1;
}
</style>
