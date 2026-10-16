<template>
  <div class="profile-container">
    <!-- 返回按钮 -->
    <el-button 
      type="text" 
      icon="el-icon-arrow-left" 
      @click="$router.push('/')" 
      class="back-button"
    >
      返回主页
    </el-button>

    <h2>个人资料</h2>
    
    <el-row :gutter="20">
      <!-- 左侧:用户信息卡片 -->
      <el-col :xs="24" :md="16">
        <el-card class="profile-card">
          <template #header>
            <div class="card-header">
              <span>基本信息</span>
            </div>
          </template>
          
          <el-form :model="userForm" label-width="100px" class="profile-form">
            <el-form-item label="用户名">
              <el-input v-model="userForm.userName" disabled />
            </el-form-item>
            
            <el-form-item label="昵称">
              <el-input v-model="userForm.nickName" />
            </el-form-item>
            
            <el-form-item label="手机号">
              <el-input v-model="userForm.phonenumber" />
            </el-form-item>
            
            <el-form-item label="邮箱">
              <el-input v-model="userForm.email" />
            </el-form-item>
            
            <el-form-item>
              <el-button type="primary" @click="handleSave">保存修改</el-button>
              <el-button @click="$router.back()">取消</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>

      <!-- 右侧:统计信息卡片 -->
      <el-col :xs="24" :md="8">
        <el-card class="stats-card">
          <template #header>
            <div class="card-header">
              <span>我的统计</span>
            </div>
          </template>
          
          <div class="stat-item">
            <div class="stat-icon">
              <el-icon :size="24" color="#409EFF"><ShoppingCart /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-label">租赁中</div>
              <div class="stat-value">{{ stats.renting }}</div>
            </div>
          </div>

          <el-divider />

          <div class="stat-item">
            <div class="stat-icon">
              <el-icon :size="24" color="#67C23A"><CircleCheck /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-label">已完成</div>
              <div class="stat-value">{{ stats.completed }}</div>
            </div>
          </div>

          <el-divider />

          <div class="stat-item">
            <div class="stat-icon">
              <el-icon :size="24" color="#F56C6C"><Star /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-label">我的收藏</div>
              <div class="stat-value">{{ stats.favorites }}</div>
            </div>
          </div>

          <el-divider />

          <div class="stat-item">
            <div class="stat-icon">
              <el-icon :size="24" color="#E6A23C"><Money /></el-icon>
            </div>
            <div class="stat-info">
              <div class="stat-label">累计消费</div>
              <div class="stat-value" style="font-size: 20px; color: #f56c6c">¥{{ stats.totalSpent }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { ShoppingCart, CircleCheck, Star, Money } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import { myOrderList } from '@/api/order'
import { listFavorite } from '@/api/favorite'

const userStore = useUserStore()
const userForm = ref({
  userName: '',
  nickName: '',
  phonenumber: '',
  email: ''
})

const stats = ref({
  renting: 0,
  completed: 0,
  favorites: 0,
  totalSpent: '0.00'
})

const handleSave = () => {
  ElMessage.success('保存成功')
}

// 加载真实统计数据
const loadStats = async () => {
  try {
    // 获取订单数据
    const orderRes = await myOrderList({})
    if (orderRes.rows) {
      // 租赁中: 状态为 1(已支付) 或 2(租赁中) 或 3(归还中)
      stats.value.renting = orderRes.rows.filter(o => ['1', '2', '3'].includes(o.status)).length
      // 已完成: 状态为 4(已归还)
      stats.value.completed = orderRes.rows.filter(o => o.status === '4').length
      // 累计消费
      const total = orderRes.rows
        .filter(o => o.status !== '5') // 排除已取消
        .reduce((sum, o) => sum + (parseFloat(o.totalAmount) || 0), 0)
      stats.value.totalSpent = total.toFixed(2)
    }
    
    // 获取收藏数据
    const favRes = await listFavorite({})
    if (favRes.rows) {
      stats.value.favorites = favRes.rows.length
    } else if (favRes.total !== undefined) {
      stats.value.favorites = favRes.total
    }
  } catch (error) {
    console.error('加载统计数据失败:', error)
  }
}

onMounted(() => {
  if (userStore.userInfo) {
    userForm.value = { ...userStore.userInfo }
  }
  // 加载真实统计数据
  loadStats()
})
</script>

<style scoped>
.back-button {
  margin-bottom: 20px;
  font-size: 16px;
}

.profile-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.profile-card,
.stats-card,
.quick-links-card {
  margin-bottom: 20px;
}

.card-header {
  font-weight: bold;
  font-size: 16px;
}

.profile-form {
  padding: 10px 0;
}

.stat-item {
  display: flex;
  align-items: center;
  padding: 10px 0;
}

.stat-icon {
  margin-right: 15px;
}

.stat-info {
  flex: 1;
}

.stat-label {
  font-size: 14px;
  color: #666;
  margin-bottom: 5px;
}

.stat-value {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

@media (max-width: 768px) {
  .stats-card,
  .quick-links-card {
    margin-top: 20px;
  }
}
</style>
