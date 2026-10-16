<template>
  <MainLayout>
    <div class="home-container">
      <!-- Hero Banner -->
      <div class="hero-banner">
        <div class="hero-bg"></div>
        <div class="hero-content">
          <h1 class="hero-title">
            <span class="hero-title-line">数码设备</span>
            <span class="hero-title-accent">租赁平台</span>
          </h1>
          <p class="hero-subtitle">专业 · 便捷 · 实惠的数码设备租赁服务</p>
          <div class="hero-stats">
            <div class="stat-item">
              <span class="stat-num">1000+</span>
              <span class="stat-label">设备可选</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
              <span class="stat-num">5000+</span>
              <span class="stat-label">用户信赖</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
              <span class="stat-num">99%</span>
              <span class="stat-label">好评率</span>
            </div>
          </div>
          <el-button type="primary" size="large" round class="hero-btn" @click="$router.push('/equipment')">
            立即租赁
            <el-icon class="el-icon--right"><ArrowRight /></el-icon>
          </el-button>
        </div>
        <div class="hero-decoration">
          <div class="deco-circle deco-1"></div>
          <div class="deco-circle deco-2"></div>
          <div class="deco-circle deco-3"></div>
        </div>
      </div>

      <!-- 分类导航 -->
      <div class="categories-section">
        <div class="section-header">
          <h2 class="section-title">设备分类</h2>
          <p class="section-desc">丰富的数码设备品类，满足你的各种需求</p>
        </div>
        <div class="category-grid">
          <div
            v-for="(category, index) in categories"
            :key="category.categoryId"
            class="category-card"
            :class="'category-theme-' + (index % 6)"
            @click="handleCategoryClick(category.categoryId)"
          >
            <div class="category-icon-wrap">
              <el-icon :size="32"><component :is="getCategoryIcon(category.categoryName)" /></el-icon>
            </div>
            <h3>{{ category.categoryName }}</h3>
          </div>
        </div>
      </div>

      <!-- 热门推荐 -->
      <div class="equipment-section">
        <div class="section-header">
          <h2 class="section-title">🔥 热门推荐</h2>
          <p class="section-desc">最受用户喜爱的热门设备</p>
        </div>
        <el-row :gutter="24" v-loading="hotLoading">
          <el-col :xs="24" :sm="12" :md="8" :lg="6" v-for="item in hotList" :key="item.equipmentId">
            <EquipmentCard :equipment="item" />
          </el-col>
        </el-row>
      </div>

      <!-- 最新上架 -->
      <div class="equipment-section">
        <div class="section-header">
          <h2 class="section-title">🆕 最新上架</h2>
          <p class="section-desc">刚刚上线的全新设备</p>
        </div>
        <el-row :gutter="24" v-loading="loading">
          <el-col :xs="24" :sm="12" :md="8" :lg="6" v-for="item in equipmentList" :key="item.equipmentId">
            <EquipmentCard :equipment="item" />
          </el-col>
        </el-row>
      </div>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Monitor, Camera, Printer, VideoCamera, Iphone, Watch, Mouse, Headset, ArrowRight } from '@element-plus/icons-vue'
import MainLayout from '@/components/Layout/MainLayout.vue'
import EquipmentCard from '@/components/EquipmentCard.vue'
import { listEquipment, hotEquipment } from '@/api/equipment'
import { listCategory } from '@/api/category'

const router = useRouter()
const loading = ref(false)
const equipmentList = ref([])
const hotList = ref([])
const hotLoading = ref(false)

const categories = ref([])

const iconMap = {
  '电脑': 'Monitor', '便携设备': 'Iphone', '穿戴设备': 'Watch',
  '摄影设备': 'Camera', '办公设备': 'Printer', '游戏设备': 'VideoCamera',
  '电脑设备': 'Monitor', '手机': 'Iphone'
}
const getCategoryIcon = (name) => {
  return iconMap[name] || 'Monitor'
}

const handleCategoryClick = (categoryId) => {
  router.push({ path: '/equipment', query: { categoryId } })
}

const loadEquipment = () => {
  loading.value = true
  listEquipment({ pageNum: 1, pageSize: 8, status: '0' }).then(res => {
    equipmentList.value = res.rows || []
  }).finally(() => {
    loading.value = false
  })
}

const loadHotEquipment = () => {
  hotLoading.value = true
  hotEquipment().then(res => {
    hotList.value = res.data || []
  }).finally(() => {
    hotLoading.value = false
  })
}

onMounted(() => {
  loadEquipment()
  loadHotEquipment()
  listCategory().then(res => {
    categories.value = (res.data || []).filter(c => c.parentId === 0 && c.status === '0')
  })
})
</script>

<style scoped>
.home-container {
  max-width: 1200px;
  margin: 0 auto;
}

/* ===== Hero Banner ===== */
.hero-banner {
  position: relative;
  border-radius: 24px;
  overflow: hidden;
  margin-bottom: 60px;
  padding: 80px 60px;
  min-height: 380px;
  display: flex;
  align-items: center;
}

.hero-bg {
  position: absolute;
  inset: 0;
  background: linear-gradient(135deg, #4F8EF7 0%, #7C5CFC 50%, #A855F7 100%);
  z-index: 0;
}

.hero-content {
  position: relative;
  z-index: 2;
  color: #fff;
}

.hero-title {
  font-size: 52px;
  font-weight: 800;
  line-height: 1.2;
  margin: 0 0 16px 0;
  letter-spacing: -1px;
}

.hero-title-line {
  display: block;
}

.hero-title-accent {
  display: block;
  background: linear-gradient(90deg, #fff, rgba(255,255,255,0.7));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-subtitle {
  font-size: 18px;
  opacity: 0.85;
  margin: 0 0 32px 0;
  font-weight: 400;
  letter-spacing: 4px;
}

.hero-stats {
  display: flex;
  align-items: center;
  gap: 0;
  margin-bottom: 36px;
  background: rgba(255, 255, 255, 0.12);
  backdrop-filter: blur(10px);
  border-radius: 16px;
  padding: 20px 32px;
  width: fit-content;
  border: 1px solid rgba(255, 255, 255, 0.15);
}

.stat-item {
  text-align: center;
  padding: 0 24px;
}

.stat-num {
  display: block;
  font-size: 28px;
  font-weight: 800;
  color: #fff;
  line-height: 1.2;
}

.stat-label {
  display: block;
  font-size: 13px;
  opacity: 0.7;
  margin-top: 4px;
}

.stat-divider {
  width: 1px;
  height: 36px;
  background: rgba(255, 255, 255, 0.2);
}

.hero-btn {
  font-size: 16px;
  padding: 14px 36px;
  height: auto;
  background: #fff;
  color: #4F8EF7;
  border: none;
  font-weight: 700;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
  transition: all 0.3s;
}

.hero-btn:hover {
  transform: translateY(-3px);
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.2);
  background: #fff;
  color: #7C5CFC;
}

.hero-decoration {
  position: absolute;
  inset: 0;
  z-index: 1;
  overflow: hidden;
}

.deco-circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.06);
}

.deco-1 {
  width: 400px;
  height: 400px;
  right: -80px;
  top: -80px;
}

.deco-2 {
  width: 250px;
  height: 250px;
  right: 100px;
  bottom: -60px;
}

.deco-3 {
  width: 150px;
  height: 150px;
  right: 350px;
  top: 30px;
  background: rgba(255, 255, 255, 0.08);
}

/* ===== Section Headers ===== */
.section-header {
  text-align: center;
  margin-bottom: 36px;
}

.section-title {
  font-size: 28px;
  font-weight: 800;
  color: #1a1a2e;
  margin: 0 0 8px 0;
  letter-spacing: -0.5px;
}

.section-desc {
  font-size: 15px;
  color: #8892a4;
  margin: 0;
}

/* ===== Categories ===== */
.categories-section {
  margin-bottom: 64px;
}

.category-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(170px, 1fr));
  gap: 16px;
}

.category-card {
  background: #fff;
  padding: 32px 16px;
  border-radius: 16px;
  text-align: center;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
  border: 1px solid rgba(0, 0, 0, 0.04);
}

.category-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 16px 32px rgba(0, 0, 0, 0.1);
}

.category-icon-wrap {
  width: 64px;
  height: 64px;
  border-radius: 18px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 14px;
  transition: transform 0.3s;
}

.category-card:hover .category-icon-wrap {
  transform: scale(1.1);
}

/* Color themes */
.category-theme-0 .category-icon-wrap { background: linear-gradient(135deg, #E8F0FE, #D1E3FF); color: #4F8EF7; }
.category-theme-1 .category-icon-wrap { background: linear-gradient(135deg, #FFF3E0, #FFE0B2); color: #F5A623; }
.category-theme-2 .category-icon-wrap { background: linear-gradient(135deg, #E8F5E9, #C8E6C9); color: #4CAF50; }
.category-theme-3 .category-icon-wrap { background: linear-gradient(135deg, #FCE4EC, #F8BBD0); color: #E91E63; }
.category-theme-4 .category-icon-wrap { background: linear-gradient(135deg, #EDE7F6, #D1C4E9); color: #7C5CFC; }
.category-theme-5 .category-icon-wrap { background: linear-gradient(135deg, #E0F7FA, #B2EBF2); color: #00ACC1; }

.category-card h3 {
  margin: 0;
  font-size: 15px;
  font-weight: 600;
  color: #333;
}

/* ===== Equipment Sections ===== */
.equipment-section {
  margin-bottom: 56px;
}
</style>
