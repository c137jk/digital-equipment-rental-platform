<template>
  <div class="favorites-container">
    <h2>我的收藏</h2>
    
    <el-row :gutter="20" v-loading="loading">
      <el-col :xs="24" :sm="12" :md="8" v-for="item in favoriteList" :key="item.favoriteId">
        <el-card class="favorite-card">
          <div class="equipment-image" @click="handleView(item.equipment.equipmentId)">
            <img :src="getImageUrl(item.equipment.mainImage)" :alt="item.equipment.equipmentName" />
          </div>
          <div class="equipment-info">
            <h3>{{ item.equipment.equipmentName }}</h3>
            <p class="brand">{{ item.equipment.brand }}</p>
            <div class="price">
              <span class="label">日租:</span>
              <span class="value">¥{{ item.equipment.dailyPrice }}</span>
            </div>
            <div class="actions">
              <el-button type="primary" size="small" @click="handleView(item.equipment.equipmentId)">
                查看详情
              </el-button>
              <el-button type="danger" size="small" @click="handleRemove(item)">
                取消收藏
              </el-button>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    
    <el-empty v-if="!loading && favoriteList.length === 0" description="暂无收藏" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { listFavorite, delFavorite } from '@/api/favorite'

const router = useRouter()
const loading = ref(false)
const favoriteList = ref([])

// 获取图片完整URL
const getImageUrl = (imagePath) => {
  if (!imagePath) return '/placeholder.jpg'
  if (imagePath.startsWith('http')) return imagePath
  return `http://localhost:8080${imagePath}`
}

const loadFavorites = () => {
  loading.value = true
  listFavorite().then(res => {
    favoriteList.value = res.data || []
  }).finally(() => {
    loading.value = false
  })
}

const handleView = (equipmentId) => {
  router.push(`/equipment/${equipmentId}`)
}

const handleRemove = (item) => {
  ElMessageBox.confirm('确定要取消收藏吗?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    delFavorite(item.equipmentId).then(() => {
      ElMessage.success('取消收藏成功')
      loadFavorites()
    })
  })
}

onMounted(() => {
  loadFavorites()
})
</script>

<style scoped>
.favorites-container {
  padding: 20px;
}

.favorite-card {
  margin-bottom: 20px;
  cursor: pointer;
  transition: all 0.3s;
}

.favorite-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.equipment-image {
  width: 100%;
  height: 200px;
  overflow: hidden;
  border-radius: 4px;
  background: #f5f5f5;
}

.equipment-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.equipment-info {
  padding: 15px 0;
}

.equipment-info h3 {
  font-size: 16px;
  margin-bottom: 8px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.brand {
  font-size: 14px;
  color: #999;
  margin-bottom: 12px;
}

.price {
  margin-bottom: 15px;
}

.price .label {
  font-size: 14px;
  color: #666;
}

.price .value {
  font-size: 18px;
  font-weight: bold;
  color: #f56c6c;
  margin-left: 5px;
}

.actions {
  display: flex;
  gap: 10px;
}

.actions .el-button {
  flex: 1;
}
</style>
