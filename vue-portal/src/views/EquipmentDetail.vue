<template>
  <MainLayout>
    <div class="equipment-detail-container" v-loading="loading">
      <!-- 返回按钮 -->
      <el-button 
        type="text" 
        :icon="ArrowLeft" 
        @click="$router.back()" 
        class="back-button"
      >
        返回
      </el-button>

      <el-row :gutter="40" v-if="equipment">
        <!-- 左侧图片 -->
        <el-col :xs="24" :md="12">
          <div class="image-gallery">
            <img :src="imageUrl" :alt="equipment.equipmentName" class="main-image" />
          </div>
        </el-col>

        <!-- 右侧信息 -->
        <el-col :xs="24" :md="12">
          <div class="equipment-info">
            <h1 class="equipment-title">{{ equipment.equipmentName }}</h1>
            <p class="equipment-brand">{{ equipment.brand }} {{ equipment.model }}</p>

            <el-divider />

            <div class="price-section">
              <div class="price-item">
                <span class="price-label">日租:</span>
                <span class="price-value">¥{{ equipment.dailyPrice }}</span>
                <span class="price-unit">/天</span>
              </div>
              <div class="price-item">
                <span class="price-label">周租:</span>
                <span class="price-value">¥{{ equipment.weeklyPrice }}</span>
                <span class="price-unit">/周</span>
              </div>
              <div class="price-item">
                <span class="price-label">月租:</span>
                <span class="price-value">¥{{ equipment.monthlyPrice }}</span>
                <span class="price-unit">/月</span>
              </div>
            </div>

            <div class="deposit-section">
              <span class="deposit-label">押金:</span>
              <span class="deposit-value">¥{{ equipment.deposit }}</span>
            </div>

            <el-divider />

            <div class="stock-section">
              <span>库存: {{ equipment.stock }} 台</span>
              <el-tag v-if="equipment.stock > 0" type="success">可租赁</el-tag>
              <el-tag v-else type="danger">已租完</el-tag>
            </div>

            <el-divider />

            <!-- 租赁选项 -->
            <div class="rental-options">
              <div class="option-item">
                <span class="option-label">租赁类型:</span>
                <el-radio-group v-model="rentalForm.rentalType">
                  <el-radio label="1">日租</el-radio>
                  <el-radio label="2">周租</el-radio>
                  <el-radio label="3">月租</el-radio>
                </el-radio-group>
              </div>

              <div class="option-item" v-if="rentalForm.rentalType === '1'">
                <span class="option-label">租赁天数:</span>
                <el-input-number v-model="rentalForm.rentalDays" :min="1" :max="30" />
              </div>

              <div class="option-item">
                <span class="option-label">数量:</span>
                <el-input-number v-model="rentalForm.quantity" :min="1" :max="equipment.stock" />
              </div>

              <div class="total-price">
                <span>预计费用:</span>
                <span class="total-value">¥{{ calculateTotal }}</span>
              </div>
            </div>

            <div class="action-buttons">
              <el-button
                type="primary"
                size="large"
                :icon="ShoppingCart"
                @click="handleAddToCart"
                :disabled="equipment.stock <= 0"
              >
                加入购物车
              </el-button>
              <el-button
                type="success"
                size="large"
                @click="handleRentNow"
                :disabled="equipment.stock <= 0"
              >
                立即租赁
              </el-button>
              <el-button
                size="large"
                :icon="isFavorite ? StarFilled : Star"
                @click="handleFavorite"
              >
                {{ isFavorite ? '已收藏' : '收藏' }}
              </el-button>
            </div>
          </div>
        </el-col>
      </el-row>

      <!-- 设备详情 -->
      <el-card class="detail-card" v-if="equipment">
        <template #header>
          <h3>设备详情</h3>
        </template>
        <div class="description">
          <p>{{ equipment.description }}</p>
        </div>
        <el-divider />
        <div class="rental-notes">
          <h4>租赁说明</h4>
          <p style="white-space: pre-line">{{ equipment.rentalNotes }}</p>
        </div>
      </el-card>

      <!-- 用户评价 -->
      <el-card class="review-section" v-if="reviewList.length > 0">
        <template #header>
          <div class="review-header">
            <span>用户评价 ({{ reviewList.length }})</span>
            <span class="avg-rating">平均评分: {{ avgRating }}⭐</span>
          </div>
        </template>
        <div v-for="review in reviewList" :key="review.reviewId" class="review-item">
          <div class="review-user">
            <span class="user-name">{{ review.nickName || '匿名用户' }}</span>
            <el-rate v-model="review.rating" disabled :size="'small'" />
          </div>
          <p class="review-content">{{ review.content }}</p>
          <span class="review-time">{{ review.createTime }}</span>
        </div>
      </el-card>

      <!-- 同类推荐 -->
      <div class="recommend-section" v-if="recommendList.length > 0">
        <h3 class="section-title">同类推荐</h3>
        <el-row :gutter="20">
          <el-col :xs="12" :sm="8" :md="6" v-for="item in recommendList" :key="item.equipmentId">
            <EquipmentCard :equipment="item" />
          </el-col>
        </el-row>
      </div>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ShoppingCart, Star, StarFilled, ArrowLeft } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import MainLayout from '@/components/Layout/MainLayout.vue'
import { getEquipment, recommendEquipment } from '@/api/equipment'
import { checkFavorite, addFavorite, delFavorite } from '@/api/favorite'
import { listReview } from '@/api/review'
import { useCartStore } from '@/stores/cart'
import { useUserStore } from '@/stores/user'
import EquipmentCard from '@/components/EquipmentCard.vue'

const route = useRoute()
const router = useRouter()
const cartStore = useCartStore()
const userStore = useUserStore()

const loading = ref(false)
const equipment = ref(null)
const isFavorite = ref(false)
const recommendList = ref([])
const reviewList = ref([])
const avgRating = ref('0.0')

// 构建完整的图片URL
const imageUrl = computed(() => {
  if (!equipment.value || !equipment.value.mainImage) {
    return '/placeholder.jpg'
  }
  // 如果是完整URL,直接返回
  if (equipment.value.mainImage.startsWith('http')) {
    return equipment.value.mainImage
  }
  // 否则加上后端API前缀
  return `http://localhost:8080${equipment.value.mainImage}`
})

const rentalForm = reactive({
  rentalType: '1',
  rentalDays: 1,
  quantity: 1
})

const calculateTotal = computed(() => {
  if (!equipment.value) return 0
  
  let price = 0
  if (rentalForm.rentalType === '1') {
    price = equipment.value.dailyPrice * rentalForm.rentalDays
  } else if (rentalForm.rentalType === '2') {
    price = equipment.value.weeklyPrice
  } else if (rentalForm.rentalType === '3') {
    price = equipment.value.monthlyPrice
  }
  
  return (price * rentalForm.quantity).toFixed(2)
})

const loadEquipment = () => {
  loading.value = true
  const equipmentId = route.params.id
  getEquipment(equipmentId).then(res => {
    equipment.value = res.data
    // 检查是否已收藏
    if (userStore.token) {
      checkFavoriteStatus()
    }
    // 加载同类推荐
    loadRecommend()
    // 加载评价
    loadReviews()
  }).finally(() => {
    loading.value = false
  })
}

const loadRecommend = () => {
  const equipmentId = route.params.id
  recommendEquipment(equipmentId).then(res => {
    recommendList.value = res.data || []
  })
}

const loadReviews = () => {
  const equipmentId = route.params.id
  listReview(equipmentId).then(res => {
    reviewList.value = res.data || []
    if (reviewList.value.length > 0) {
      const sum = reviewList.value.reduce((acc, r) => acc + r.rating, 0)
      avgRating.value = (sum / reviewList.value.length).toFixed(1)
    }
  })
}

const checkFavoriteStatus = () => {
  const equipmentId = route.params.id
  checkFavorite(equipmentId).then(res => {
    isFavorite.value = res.data
  })
}

const handleAddToCart = () => {
  if (!userStore.token) {
    ElMessage.warning('请先登录')
    router.push({ path: '/login', query: { redirect: route.fullPath } })
    return
  }

  const cartData = {
    equipmentId: equipment.value.equipmentId,
    quantity: rentalForm.quantity,
    rentalType: rentalForm.rentalType,
    rentalDays: rentalForm.rentalDays
  }
  
  cartStore.addToCart(cartData).then(() => {
    ElMessage.success('已加入购物车')
  })
}

const handleRentNow = () => {
  if (!userStore.token) {
    ElMessage.warning('请先登录')
    router.push({ path: '/login', query: { redirect: route.fullPath } })
    return
  }

  handleAddToCart()
  setTimeout(() => {
    router.push('/cart')
  }, 500)
}

const handleFavorite = () => {
  if (!userStore.token) {
    ElMessage.warning('请先登录')
    router.push('/login')
    return
  }

  const equipmentId = equipment.value.equipmentId
  
  if (isFavorite.value) {
    // 取消收藏
    delFavorite(equipmentId).then(() => {
      isFavorite.value = false
      ElMessage.success('取消收藏成功')
    })
  } else {
    // 添加收藏
    addFavorite({ equipmentId }).then(() => {
      isFavorite.value = true
      ElMessage.success('收藏成功')
    })
  }
}

onMounted(() => {
  loadEquipment()
})
</script>

<style scoped>
.back-button {
  margin-bottom: 20px;
  font-size: 16px;
}

.equipment-detail-container {
  max-width: 1200px;
  margin: 0 auto;
}

.image-gallery {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
}

.main-image {
  width: 100%;
  border-radius: 8px;
}

.equipment-info {
  background: #fff;
  padding: 30px;
  border-radius: 8px;
}

.equipment-title {
  font-size: 28px;
  margin-bottom: 10px;
}

.equipment-brand {
  font-size: 16px;
  color: #999;
}

.price-section {
  display: flex;
  gap: 30px;
  margin: 20px 0;
}

.price-item {
  display: flex;
  align-items: baseline;
  gap: 5px;
}

.price-label {
  font-size: 14px;
  color: #666;
}

.price-value {
  font-size: 24px;
  font-weight: bold;
  color: #f56c6c;
}

.price-unit {
  font-size: 14px;
  color: #999;
}

.deposit-section {
  font-size: 16px;
  color: #666;
}

.deposit-value {
  font-size: 20px;
  font-weight: bold;
  color: #409eff;
  margin-left: 10px;
}

.stock-section {
  display: flex;
  align-items: center;
  gap: 15px;
  font-size: 16px;
}

.rental-options {
  margin: 20px 0;
}

.option-item {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.option-label {
  width: 100px;
  font-size: 14px;
  color: #666;
}

.total-price {
  margin-top: 20px;
  padding: 15px;
  background: #f5f5f5;
  border-radius: 4px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 18px;
}

.total-value {
  font-size: 28px;
  font-weight: bold;
  color: #f56c6c;
}

.action-buttons {
  display: flex;
  gap: 15px;
  margin-top: 30px;
}

.action-buttons .el-button {
  flex: 1;
}

.detail-card {
  margin-top: 30px;
}

.description {
  line-height: 1.8;
  color: #666;
}

.rental-notes h4 {
  margin-bottom: 10px;
  color: #333;
}

.rental-notes p {
  line-height: 1.8;
  color: #666;
}

.recommend-section {
  margin-top: 30px;
}

.section-title {
  font-size: 20px;
  margin-bottom: 20px;
  color: #333;
}

.review-section {
  margin-top: 30px;
}

.review-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.avg-rating {
  color: #e6a23c;
  font-weight: bold;
}

.review-item {
  padding: 15px 0;
  border-bottom: 1px solid #f0f0f0;
}

.review-item:last-child {
  border-bottom: none;
}

.review-user {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 8px;
}

.user-name {
  font-weight: bold;
  color: #333;
}

.review-content {
  color: #666;
  line-height: 1.6;
  margin-bottom: 8px;
}

.review-time {
  font-size: 12px;
  color: #999;
}
</style>
