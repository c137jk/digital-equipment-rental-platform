<template>
  <MainLayout>
    <div class="cart-container">
      <h2 class="page-title">购物车</h2>

      <el-card v-loading="cartStore.loading">
        <el-table
          :data="cartStore.cartList"
          style="width: 100%"
          @selection-change="handleSelectionChange"
        >
          <el-table-column type="selection" width="55" />
          
          <el-table-column label="设备信息" min-width="300">
            <template #default="{ row }">
              <div class="equipment-info">
                <img :src="getImageUrl(row.equipment.mainImage)" class="equipment-image" />
                <div class="equipment-details">
                  <div class="equipment-name">{{ row.equipment.equipmentName }}</div>
                  <div class="equipment-brand">{{ row.equipment.brand }}</div>
                </div>
              </div>
            </template>
          </el-table-column>

          <el-table-column label="租赁类型" width="120">
            <template #default="{ row }">
              <el-tag v-if="row.rentalType === '1'" type="success">日租</el-tag>
              <el-tag v-else-if="row.rentalType === '2'" type="warning">周租</el-tag>
              <el-tag v-else type="danger">月租</el-tag>
            </template>
          </el-table-column>

          <el-table-column label="租期" width="100">
            <template #default="{ row }">
              <span v-if="row.rentalType === '1'">{{ row.rentalDays }}天</span>
              <span v-else-if="row.rentalType === '2'">1周</span>
              <span v-else>1月</span>
            </template>
          </el-table-column>

          <el-table-column label="单价" width="120">
            <template #default="{ row }">
              <span class="price">¥{{ getUnitPrice(row) }}</span>
            </template>
          </el-table-column>

          <el-table-column label="数量" width="150">
            <template #default="{ row }">
              <el-input-number
                v-model="row.quantity"
                :min="1"
                :max="row.equipment.stock"
                @change="handleQuantityChange(row)"
              />
            </template>
          </el-table-column>

          <el-table-column label="小计" width="120">
            <template #default="{ row }">
              <span class="price total">¥{{ getItemTotal(row) }}</span>
            </template>
          </el-table-column>

          <el-table-column label="操作" width="100">
            <template #default="{ row }">
              <el-button type="danger" text @click="handleDelete(row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>

        <el-empty v-if="cartStore.cartList.length === 0" description="购物车是空的" />

        <div class="cart-footer" v-if="cartStore.cartList.length > 0">
          <div class="footer-left">
            <el-checkbox v-model="selectAll" @change="handleSelectAll">全选</el-checkbox>
            <el-button text type="danger" @click="handleDeleteSelected">删除选中</el-button>
            <el-button text @click="handleClearCart">清空购物车</el-button>
          </div>

          <div class="footer-right">
            <div class="total-info">
              <span>已选 {{ selectedItems.length }} 件</span>
              <span class="total-label">合计:</span>
              <span class="total-price">¥{{ selectedTotal }}</span>
            </div>
            <el-button
              type="primary"
              size="large"
              :disabled="selectedItems.length === 0"
              @click="handleCheckout"
            >
              去结算
            </el-button>
          </div>
        </div>
      </el-card>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import MainLayout from '@/components/Layout/MainLayout.vue'
import { useCartStore } from '@/stores/cart'

const router = useRouter()
const cartStore = useCartStore()

const selectedItems = ref([])
const selectAll = ref(false)

const selectedTotal = computed(() => {
  return selectedItems.value.reduce((total, item) => {
    return total + parseFloat(getItemTotal(item))
  }, 0).toFixed(2)
})

// 获取图片完整URL
const getImageUrl = (imagePath) => {
  if (!imagePath) return '/placeholder.jpg'
  if (imagePath.startsWith('http')) return imagePath
  return `http://localhost:8080${imagePath}`
}

const getUnitPrice = (item) => {
  const equipment = item.equipment
  if (item.rentalType === '1') {
    return equipment.dailyPrice
  } else if (item.rentalType === '2') {
    return equipment.weeklyPrice
  } else {
    return equipment.monthlyPrice
  }
}

const getItemTotal = (item) => {
  let price = getUnitPrice(item)
  if (item.rentalType === '1') {
    price = price * item.rentalDays
  }
  return (price * item.quantity).toFixed(2)
}

const handleSelectionChange = (selection) => {
  selectedItems.value = selection
  selectAll.value = selection.length === cartStore.cartList.length
}

const handleSelectAll = (val) => {
  // 这里需要通过ref访问table组件来全选/取消全选
  // 简化处理
  if (val) {
    selectedItems.value = [...cartStore.cartList]
  } else {
    selectedItems.value = []
  }
}

const handleQuantityChange = (item) => {
  cartStore.updateCartItem({
    cartId: item.cartId,
    quantity: item.quantity
  })
}

const handleDelete = (item) => {
  ElMessageBox.confirm('确定要删除该商品吗?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    cartStore.deleteCartItem(item.cartId).then(() => {
      ElMessage.success('删除成功')
    })
  })
}

const handleDeleteSelected = () => {
  if (selectedItems.value.length === 0) {
    ElMessage.warning('请选择要删除的商品')
    return
  }

  ElMessageBox.confirm(`确定要删除选中的 ${selectedItems.value.length} 件商品吗?`, '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    const cartIds = selectedItems.value.map(item => item.cartId).join(',')
    cartStore.deleteCartItem(cartIds).then(() => {
      ElMessage.success('删除成功')
      selectedItems.value = []
    })
  })
}

const handleClearCart = () => {
  ElMessageBox.confirm('确定要清空购物车吗?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    cartStore.clearCartList().then(() => {
      ElMessage.success('购物车已清空')
      selectedItems.value = []
    })
  })
}

const handleCheckout = () => {
  if (selectedItems.value.length === 0) {
    ElMessage.warning('请选择要结算的商品')
    return
  }
  // 将选中的商品传递到结算页面
  router.push({
    path: '/checkout',
    query: { items: JSON.stringify(selectedItems.value.map(item => item.cartId)) }
  })
}

onMounted(() => {
  cartStore.getCartList()
})
</script>

<style scoped>
.cart-container {
  max-width: 1200px;
  margin: 0 auto;
}

.page-title {
  font-size: 24px;
  margin-bottom: 20px;
}

.equipment-info {
  display: flex;
  align-items: center;
  gap: 15px;
}

.equipment-image {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 4px;
}

.equipment-details {
  flex: 1;
}

.equipment-name {
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 5px;
}

.equipment-brand {
  font-size: 14px;
  color: #999;
}

.price {
  color: #f56c6c;
  font-weight: bold;
}

.price.total {
  font-size: 18px;
}

.cart-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px solid #e8e8e8;
}

.footer-left {
  display: flex;
  align-items: center;
  gap: 20px;
}

.footer-right {
  display: flex;
  align-items: center;
  gap: 30px;
}

.total-info {
  display: flex;
  align-items: center;
  gap: 20px;
  font-size: 16px;
}

.total-label {
  color: #666;
}

.total-price {
  font-size: 24px;
  font-weight: bold;
  color: #f56c6c;
}
</style>
