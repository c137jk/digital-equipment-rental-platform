<template>
  <MainLayout>
    <div class="equipment-list-container">
      <el-row :gutter="20">
        <!-- 筛选侧边栏 -->
        <el-col :xs="24" :sm="6">
          <el-card class="filter-card">
            <template #header>
              <div class="filter-header">
                <span>筛选条件</span>
                <el-button text @click="resetFilters">重置</el-button>
              </div>
            </template>

            <div class="filter-section">
              <h4>分类</h4>
              <el-radio-group v-model="filters.parentCategoryId" @change="handleParentCategoryChange">
                <el-radio :label="null">全部</el-radio>
                <el-radio v-for="cat in parentCategories" :key="cat.categoryId" :label="cat.categoryId">{{ cat.categoryName }}</el-radio>
              </el-radio-group>
            </div>

            <el-divider />

            <div class="filter-section">
              <h4>价格区间</h4>
              <el-slider
                v-model="priceRange"
                range
                :min="0"
                :max="100"
                :step="10"
                @change="handlePriceChange"
              />
              <div class="price-range-text">
                ¥{{ priceRange[0] }} - ¥{{ priceRange[1] }}
              </div>
            </div>

            <el-divider />

            <div class="filter-section" v-if="childCategories.length > 0">
              <h4>子分类</h4>
              <el-radio-group v-model="filters.categoryId" @change="handleFilterChange">
                <el-radio :label="null">全部</el-radio>
                <el-radio v-for="cat in childCategories" :key="cat.categoryId" :label="cat.categoryId">{{ cat.categoryName }}</el-radio>
              </el-radio-group>
            </div>
          </el-card>
        </el-col>

        <!-- 设备列表 -->
        <el-col :xs="24" :sm="18">
          <div class="list-header">
            <el-input
              v-model="searchKeyword"
              placeholder="搜索设备名称"
              :prefix-icon="Search"
              clearable
              @change="handleSearch"
              style="width: 300px"
            />
            <el-select v-model="sortBy" @change="handleFilterChange" style="width: 150px">
              <el-option label="默认排序" value="" />
              <el-option label="价格从低到高" value="price_asc" />
              <el-option label="价格从高到低" value="price_desc" />
            </el-select>
          </div>

          <!-- 品牌标签 -->
          <div class="brand-bar" v-if="availableBrands.length > 0">
            <span class="brand-label">品牌：</span>
            <el-radio-group v-model="filters.brand" @change="handleFilterChange" size="small">
              <el-radio-button :label="null">全部</el-radio-button>
              <el-radio-button v-for="brand in availableBrands" :key="brand" :label="brand">{{ brand }}</el-radio-button>
            </el-radio-group>
          </div>

          <el-row :gutter="20" v-loading="loading">
            <el-col :xs="24" :sm="12" :md="8" v-for="item in equipmentList" :key="item.equipmentId">
              <EquipmentCard :equipment="item" />
            </el-col>
          </el-row>

          <el-empty v-if="!loading && equipmentList.length === 0" description="暂无设备" />

          <div class="pagination">
            <el-pagination
              v-model:current-page="pagination.pageNum"
              v-model:page-size="pagination.pageSize"
              :total="pagination.total"
              :page-sizes="[12, 24, 36, 48]"
              layout="total, sizes, prev, pager, next, jumper"
              @size-change="handleSizeChange"
              @current-change="handleCurrentChange"
            />
          </div>
        </el-col>
      </el-row>
    </div>
  </MainLayout>
</template>

<script setup>
import { ref, reactive, computed, onMounted, watch, nextTick } from 'vue'
import { useRoute } from 'vue-router'
import { Search } from '@element-plus/icons-vue'
import MainLayout from '@/components/Layout/MainLayout.vue'
import EquipmentCard from '@/components/EquipmentCard.vue'
import { listEquipment } from '@/api/equipment'
import { listCategory } from '@/api/category'

const route = useRoute()
const loading = ref(false)
const equipmentList = ref([])
const allCategories = ref([])
const searchKeyword = ref('')
const sortBy = ref('')
const priceRange = ref([0, 1000])

const filters = reactive({
  parentCategoryId: null,
  categoryId: null,
  brand: null
})

const pagination = reactive({
  pageNum: 1,
  pageSize: 12,
  total: 0
})

// 一级分类（parent_id = 0）
const parentCategories = computed(() => {
  return allCategories.value.filter(c => c.parentId === 0)
})

// 当前选中一级分类下的二级分类
const childCategories = computed(() => {
  if (!filters.parentCategoryId) return []
  return allCategories.value.filter(c => c.parentId === filters.parentCategoryId)
})

// 从设备数据中提取品牌
const availableBrands = computed(() => {
  const brands = [...new Set(equipmentList.value.map(e => e.brand).filter(Boolean))]
  return brands
})

// 切换一级分类时，重置二级分类和品牌并重新加载
const handleParentCategoryChange = () => {
  filters.categoryId = null
  filters.brand = null
  pagination.pageNum = 1
  loadEquipment()
}

const loadEquipment = () => {
  loading.value = true
  const params = {
    pageNum: pagination.pageNum,
    pageSize: pagination.pageSize,
    equipmentName: searchKeyword.value,
    brand: filters.brand || undefined,
    status: '0'
  }

  // 如果选了二级分类，按二级分类筛选
  if (filters.categoryId) {
    params.categoryId = filters.categoryId
  } else if (filters.parentCategoryId) {
    // 如果只选了一级分类，查询该一级分类下所有子分类的设备
    // 后端按 categoryId 查询，这里需要传父分类下的所有子分类ID
    // 为简化，直接传一级分类ID（后端会匹配 category_id）
    // 但一级分类本身不是设备的分类，需要查所有子分类
    const childIds = childCategories.value.map(c => c.categoryId)
    if (childIds.length > 0) {
      // 多个子分类：分别查询后合并
      const allParams = childIds.map(id => ({ ...params, categoryId: id }))
      const promises = allParams.map(p => listEquipment(p))
      
      Promise.all(promises).then(results => {
        const allEquip = []
        const ids = new Set()
        results.forEach(res => {
          if (res.rows) {
            res.rows.forEach(item => {
              if (!ids.has(item.equipmentId)) {
                ids.add(item.equipmentId)
                allEquip.push(item)
              }
            })
          }
        })
        equipmentList.value = allEquip
        pagination.total = allEquip.length
        sortEquipment()
      }).finally(() => {
        loading.value = false
      })
      return
    }
  }

  // 价格筛选
  if (priceRange.value[0] > 0 || priceRange.value[1] < 1000) {
    params['params[minPrice]'] = priceRange.value[0]
    params['params[maxPrice]'] = priceRange.value[1]
  }

  listEquipment(params).then(res => {
    equipmentList.value = res.rows || []
    pagination.total = res.total || 0
    sortEquipment()
  }).finally(() => {
    loading.value = false
  })
}

// 按价格排序
const sortEquipment = () => {
  if (sortBy.value === 'price_asc') {
    equipmentList.value.sort((a, b) => (a.dailyPrice || 0) - (b.dailyPrice || 0))
  } else if (sortBy.value === 'price_desc') {
    equipmentList.value.sort((a, b) => (b.dailyPrice || 0) - (a.dailyPrice || 0))
  }
}

const handleFilterChange = () => {
  pagination.pageNum = 1
  loadEquipment()
}

const handleSearch = () => {
  pagination.pageNum = 1
  loadEquipment()
}

const handlePriceChange = () => {
  pagination.pageNum = 1
  loadEquipment()
}

const handleSizeChange = () => {
  loadEquipment()
}

const handleCurrentChange = () => {
  loadEquipment()
}

const resetFilters = () => {
  filters.parentCategoryId = null
  filters.categoryId = null
  filters.brand = null
  priceRange.value = [0, 1000]
  searchKeyword.value = ''
  sortBy.value = ''
  pagination.pageNum = 1
  loadEquipment()
}



onMounted(() => {
  // 从路由获取分类ID
  if (route.query.categoryId) {
    const catId = parseInt(route.query.categoryId)
    // 先加载分类，然后判断是一级还是二级
    listCategory().then(res => {
      allCategories.value = (res.data || []).filter(c => c.status === '0')
      const cat = allCategories.value.find(c => c.categoryId === catId)
      if (cat) {
        if (cat.parentId === 0) {
          filters.parentCategoryId = catId
        } else {
          filters.parentCategoryId = cat.parentId
          filters.categoryId = catId
        }
      }
      loadEquipment()
    })
  } else {
    listCategory().then(res => {
      allCategories.value = (res.data || []).filter(c => c.status === '0')
    })
    loadEquipment()
  }
})
</script>

<style scoped>
.equipment-list-container {
  max-width: 1200px;
  margin: 0 auto;
}

.filter-card {
  position: sticky;
  top: 84px;
  border-radius: 16px;
  border: 1px solid rgba(0, 0, 0, 0.04);
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
  overflow: hidden;
}

.filter-card :deep(.el-card__header) {
  background: linear-gradient(135deg, #f8f9fd, #f0f2f8);
  border-bottom: 1px solid rgba(0, 0, 0, 0.04);
  padding: 16px 20px;
}

.filter-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: 700;
  color: #1a1a2e;
}

.filter-section {
  margin-bottom: 20px;
}

.filter-section h4 {
  margin-bottom: 14px;
  font-size: 14px;
  font-weight: 700;
  color: #1a1a2e;
  letter-spacing: 0.5px;
}

.filter-section :deep(.el-radio),
.filter-section :deep(.el-checkbox) {
  display: block;
  margin-bottom: 10px;
  height: auto;
  line-height: 1.6;
}

.filter-section :deep(.el-radio__label) {
  font-size: 14px;
}

.price-range-text {
  text-align: center;
  margin-top: 12px;
  color: #4F8EF7;
  font-size: 14px;
  font-weight: 600;
  background: #f0f4ff;
  padding: 6px 12px;
  border-radius: 8px;
}

.list-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
  flex-wrap: wrap;
  gap: 12px;
}

.list-header :deep(.el-input__wrapper) {
  border-radius: 12px;
  box-shadow: 0 1px 6px rgba(0, 0, 0, 0.06);
}

.list-header :deep(.el-select .el-input__wrapper) {
  border-radius: 12px;
}

.brand-bar {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  padding: 14px 20px;
  background: #fff;
  border-radius: 14px;
  flex-wrap: wrap;
  gap: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  border: 1px solid rgba(0, 0, 0, 0.04);
}

.brand-label {
  font-size: 14px;
  color: #1a1a2e;
  font-weight: 600;
  white-space: nowrap;
  margin-right: 4px;
}

.brand-bar :deep(.el-radio-button__inner) {
  border-radius: 20px !important;
  padding: 6px 18px;
  font-size: 13px;
  border: none !important;
  box-shadow: none !important;
}

.brand-bar :deep(.el-radio-button:first-child .el-radio-button__inner) {
  border-radius: 20px !important;
}

.brand-bar :deep(.el-radio-button:last-child .el-radio-button__inner) {
  border-radius: 20px !important;
}

.brand-bar :deep(.el-radio-button__original-radio:checked + .el-radio-button__inner) {
  background: linear-gradient(135deg, #4F8EF7, #7C5CFC);
  border-color: transparent;
  box-shadow: 0 4px 12px rgba(79, 142, 247, 0.3) !important;
}

.pagination {
  display: flex;
  justify-content: center;
  margin-top: 36px;
  padding-bottom: 20px;
}

/* ===== AI Chat Section ===== */
.ai-chat-section {
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
  border: 1px solid rgba(0, 0, 0, 0.04);
  margin-top: 10px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.ai-chat-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: linear-gradient(135deg, #4F8EF7 0%, #7C5CFC 100%);
  color: #fff;
}

.ai-chat-title {
  display: flex;
  align-items: center;
  gap: 10px;
}

.ai-avatar {
  font-size: 24px;
}

.ai-chat-title h3 {
  margin: 0;
  font-size: 16px;
  font-weight: 700;
}

.ai-status {
  font-size: 13px;
  opacity: 0.9;
}

.ai-chat-body {
  height: 350px;
  overflow-y: auto;
  padding: 20px;
  background: #f8f9fd;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.chat-msg {
  display: flex;
  gap: 12px;
  max-width: 85%;
}

.msg-user {
  align-self: flex-end;
  flex-direction: row-reverse;
}

.msg-ai {
  align-self: flex-start;
}

.msg-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: bold;
  flex-shrink: 0;
}

.msg-user .msg-avatar {
  background: #4F8EF7;
  color: #fff;
}

.msg-ai .msg-avatar {
  background: #fff;
  color: #7C5CFC;
  box-shadow: 0 2px 8px rgba(124, 92, 252, 0.15);
}

.msg-content {
  padding: 12px 16px;
  border-radius: 12px;
  font-size: 14px;
  line-height: 1.6;
  color: #333;
  word-break: break-all;
}

.msg-user .msg-content {
  background: #4F8EF7;
  color: #fff;
  border-top-right-radius: 2px;
}

.msg-ai .msg-content {
  background: #fff;
  border-top-left-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.typing-indicator span {
  display: inline-block;
  width: 6px;
  height: 6px;
  background-color: #7C5CFC;
  border-radius: 50%;
  margin: 0 2px;
  animation: typing 1.4s infinite ease-in-out both;
}

.typing-indicator span:nth-child(1) { animation-delay: -0.32s; }
.typing-indicator span:nth-child(2) { animation-delay: -0.16s; }

@keyframes typing {
  0%, 80%, 100% { transform: scale(0); }
  40% { transform: scale(1); }
}

.ai-chat-footer {
  padding: 16px 20px;
  background: #fff;
  border-top: 1px solid rgba(0, 0, 0, 0.04);
}

.ai-chat-footer :deep(.el-input-group__append) {
  background: #4F8EF7;
  color: #fff;
  border: none;
}

.ai-chat-footer :deep(.el-input__wrapper) {
  box-shadow: 0 0 0 1px #dcdfe6;
}

.ai-chat-footer :deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 0 0 1px #4F8EF7;
}

.ai-chat-footer :deep(.el-button) {
  width: 80px;
  border-radius: 0 4px 4px 0;
  border: none !important;
  color: #fff !important;
  font-weight: 600;
  background-color: transparent !important;
}

.ai-chat-footer :deep(.el-button:hover) {
  background-color: transparent !important;
  opacity: 0.9;
}
</style>
