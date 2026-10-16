<template>
  <div class="rental-history-container">
    <!-- 返回按钮 -->
    <el-button 
      type="text" 
      icon="el-icon-arrow-left" 
      @click="$router.push('/')" 
      class="back-button"
    >
      返回主页
    </el-button>

    <h2>租赁记录</h2>
    
    <el-table :data="orderList" v-loading="loading" style="width: 100%">
      <el-table-column prop="orderNo" label="订单号" width="180" />
      <el-table-column prop="equipmentName" label="设备名称" />
      <el-table-column label="租赁时间" width="180">
        <template #default="{ row }">
          {{ row.startTime }} ~ {{ row.endTime }}
        </template>
      </el-table-column>
      <el-table-column prop="totalAmount" label="金额" width="120">
        <template #default="{ row }">
          ¥{{ row.totalAmount }}
        </template>
      </el-table-column>
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="getStatusType(row.status)">
            {{ getStatusText(row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="120">
        <template #default="{ row }">
          <el-button text @click="$router.push(`/orders/${row.orderId}`)">
            查看详情
          </el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { myOrderList } from '@/api/order'

const loading = ref(false)
const orderList = ref([])

const getStatusType = (status) => {
  const types = { '0': 'warning', '1': 'info', '2': 'primary', '3': 'warning', '4': 'success', '5': 'danger' }
  return types[status] || 'info'
}

const getStatusText = (status) => {
  const texts = { '0': '待支付', '1': '已支付', '2': '租赁中', '3': '归还中', '4': '已归还', '5': '已取消' }
  return texts[status] || '未知'
}

onMounted(() => {
  loading.value = true
  myOrderList({ pageNum: 1, pageSize: 100 }).then(res => {
    orderList.value = res.rows || []
  }).finally(() => {
    loading.value = false
  })
})
</script>

<style scoped>
.back-button {
  margin-bottom: 20px;
  font-size: 16px;
}

.rental-history-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}
</style>
