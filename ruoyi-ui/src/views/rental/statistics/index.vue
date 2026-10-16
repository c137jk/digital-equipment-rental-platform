<template>
  <div class="app-container">
    <el-row :gutter="20" v-loading="loading">
      <el-col :span="6">
        <el-card class="stat-card">
          <div slot="header" class="card-header">
            <el-icon class="header-icon" :size="24" color="#409eff"><Laptop /></el-icon>
            <span>设备统计</span>
          </div>
          <div class="stat-item">
            <div class="stat-label">总设备数</div>
            <div class="stat-value">{{ statistics.equipment.total }}</div>
          </div>
          <div class="stat-item">
            <div class="stat-label">可租设备</div>
            <div class="stat-value" style="color: #67c23a">{{ statistics.equipment.available }}</div>
          </div>
          <div class="stat-item">
            <div class="stat-label">已租设备</div>
            <div class="stat-value" style="color: #e6a23c">{{ statistics.equipment.rented }}</div>
          </div>
        </el-card>
      </el-col>

      <el-col :span="6">
        <el-card class="stat-card">
          <div slot="header" class="card-header">
            <el-icon class="header-icon" :size="24" color="#67c23a"><Document /></el-icon>
            <span>订单统计</span>
          </div>
          <div class="stat-item">
            <div class="stat-label">总订单数</div>
            <div class="stat-value">{{ statistics.order.total }}</div>
          </div>
          <div class="stat-item">
            <div class="stat-label">进行中</div>
            <div class="stat-value" style="color: #409eff">{{ statistics.order.active }}</div>
          </div>
          <div class="stat-item">
            <div class="stat-label">已完成</div>
            <div class="stat-value" style="color: #67c23a">{{ statistics.order.completed }}</div>
          </div>
        </el-card>
      </el-col>

      <el-col :span="6">
        <el-card class="stat-card">
          <div slot="header" class="card-header">
            <el-icon class="header-icon" :size="24" color="#f56c6c"><Money /></el-icon>
            <span>收入统计</span>
          </div>
          <div class="stat-item">
            <div class="stat-label">总收入</div>
            <div class="stat-value" style="color: #f56c6c">¥{{ statistics.revenue.total }}</div>
          </div>
          <div class="stat-item">
            <div class="stat-label">本月收入</div>
            <div class="stat-value" style="color: #409eff">¥{{ statistics.revenue.month }}</div>
          </div>
          <div class="stat-item">
            <div class="stat-label">今日收入</div>
            <div class="stat-value" style="color: #67c23a">¥{{ statistics.revenue.today }}</div>
          </div>
        </el-card>
      </el-col>

      <el-col :span="6">
        <el-card class="stat-card">
          <div slot="header" class="card-header">
            <el-icon class="header-icon" :size="24" color="#e6a23c"><User /></el-icon>
            <span>用户统计</span>
          </div>
          <div class="stat-item">
            <div class="stat-label">总用户数</div>
            <div class="stat-value">{{ statistics.user.total }}</div>
          </div>
          <div class="stat-item">
            <div class="stat-label">活跃用户</div>
            <div class="stat-value" style="color: #67c23a">{{ statistics.user.active }}</div>
          </div>
          <div class="stat-item">
            <div class="stat-label">新增用户</div>
            <div class="stat-value" style="color: #409eff">{{ statistics.user.new }}</div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 图表区域 -->
    <el-row :gutter="20" style="margin-top: 20px">
      <el-col :span="12">
        <el-card>
          <div slot="header"><span>近7天订单趋势</span></div>
          <div ref="orderTrendChart" style="height: 350px"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <div slot="header"><span>近7天收入趋势</span></div>
          <div ref="revenueTrendChart" style="height: 350px"></div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px">
      <el-col :span="12">
        <el-card>
          <div slot="header"><span>设备租赁排行 Top5</span></div>
          <div ref="equipmentRankChart" style="height: 350px"></div>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <div slot="header"><span>订单状态分布</span></div>
          <div ref="orderStatusChart" style="height: 350px"></div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px">
      <el-col :span="24">
        <el-card>
          <div slot="header">
            <span>快速操作</span>
          </div>
          <div class="quick-actions">
            <el-button type="primary" icon="el-icon-plus" @click="goToPage('/rental/equipment')">
              添加设备
            </el-button>
            <el-button type="success" icon="el-icon-view" @click="goToPage('/rental/order')">
              查看订单
            </el-button>
            <el-button type="warning" icon="el-icon-folder" @click="goToPage('/rental/category')">
              管理分类
            </el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import * as echarts from 'echarts';
import { getStatisticsOverview, getOrderTrend, getRevenueTrend, getEquipmentRank } from "@/api/rental/statistics";

export default {
  name: "Statistics",
  data() {
    return {
      loading: false,
      statistics: {
        equipment: { total: 0, available: 0, rented: 0 },
        order: { total: 0, active: 0, completed: 0 },
        revenue: { total: 0, month: 0, today: 0 },
        user: { total: 0, active: 0, new: 0 }
      },
      charts: {
        orderTrend: null,
        revenueTrend: null,
        equipmentRank: null,
        orderStatus: null
      }
    };
  },
  created() {
    this.loadStatistics();
  },
  mounted() {
    this.loadCharts();
    window.addEventListener('resize', this.handleResize);
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.handleResize);
    Object.values(this.charts).forEach(chart => {
      if (chart) chart.dispose();
    });
  },
  methods: {
    loadStatistics() {
      this.loading = true;
      getStatisticsOverview().then(response => {
        this.statistics = response.data;
        this.$nextTick(() => {
          this.initOrderStatusChart();
        });
      }).finally(() => {
        this.loading = false;
      });
    },
    loadCharts() {
      this.loadOrderTrend();
      this.loadRevenueTrend();
      this.loadEquipmentRank();
    },
    loadOrderTrend() {
      getOrderTrend().then(response => {
        const data = response.data;
        this.charts.orderTrend = echarts.init(this.$refs.orderTrendChart);
        this.charts.orderTrend.setOption({
          tooltip: { trigger: 'axis' },
          grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
          xAxis: { type: 'category', data: data.dates, boundaryGap: false },
          yAxis: { type: 'value', minInterval: 1 },
          series: [{
            name: '订单数',
            type: 'line',
            smooth: true,
            areaStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: 'rgba(64, 158, 255, 0.3)' },
                { offset: 1, color: 'rgba(64, 158, 255, 0.05)' }
              ])
            },
            itemStyle: { color: '#409eff' },
            data: data.counts
          }]
        });
      });
    },
    loadRevenueTrend() {
      getRevenueTrend().then(response => {
        const data = response.data;
        this.charts.revenueTrend = echarts.init(this.$refs.revenueTrendChart);
        this.charts.revenueTrend.setOption({
          tooltip: { trigger: 'axis', formatter: '{b}<br/>{a}: ¥{c}' },
          grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
          xAxis: { type: 'category', data: data.dates },
          yAxis: { type: 'value' },
          series: [{
            name: '收入',
            type: 'bar',
            barWidth: '40%',
            itemStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: '#f56c6c' },
                { offset: 1, color: '#f9a7a7' }
              ]),
              borderRadius: [4, 4, 0, 0]
            },
            data: data.amounts
          }]
        });
      });
    },
    loadEquipmentRank() {
      getEquipmentRank().then(response => {
        const data = response.data;
        this.charts.equipmentRank = echarts.init(this.$refs.equipmentRankChart);
        this.charts.equipmentRank.setOption({
          tooltip: { trigger: 'item', formatter: '{b}: {c}次 ({d}%)' },
          legend: { orient: 'vertical', left: 'left', top: 'center' },
          series: [{
            name: '租赁次数',
            type: 'pie',
            radius: ['40%', '70%'],
            center: ['60%', '50%'],
            avoidLabelOverlap: false,
            itemStyle: { borderRadius: 8, borderColor: '#fff', borderWidth: 2 },
            label: { show: false, position: 'center' },
            emphasis: {
              label: { show: true, fontSize: 16, fontWeight: 'bold' }
            },
            labelLine: { show: false },
            data: data
          }]
        });
      });
    },
    initOrderStatusChart() {
      const stats = this.statistics.order;
      const pending = stats.total - stats.active - stats.completed;
      this.charts.orderStatus = echarts.init(this.$refs.orderStatusChart);
      this.charts.orderStatus.setOption({
        tooltip: { trigger: 'item', formatter: '{b}: {c}单 ({d}%)' },
        legend: { orient: 'vertical', left: 'left', top: 'center' },
        color: ['#e6a23c', '#409eff', '#67c23a'],
        series: [{
          name: '订单状态',
          type: 'pie',
          radius: '65%',
          center: ['60%', '50%'],
          data: [
            { value: pending > 0 ? pending : 0, name: '待处理' },
            { value: stats.active, name: '进行中' },
            { value: stats.completed, name: '已完成' }
          ],
          emphasis: {
            itemStyle: { shadowBlur: 10, shadowOffsetX: 0, shadowColor: 'rgba(0, 0, 0, 0.5)' }
          }
        }]
      });
    },
    handleResize() {
      Object.values(this.charts).forEach(chart => {
        if (chart) chart.resize();
      });
    },
    goToPage(path) {
      this.$router.push(path);
    }
  }
};
</script>

<style scoped>
.stat-card {
  height: 100%;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 8px;
}

.header-icon {
  flex-shrink: 0;
}

.stat-item {
  padding: 12px 0;
  border-bottom: 1px solid #f0f0f0;
}

.stat-item:last-child {
  border-bottom: none;
}

.stat-label {
  font-size: 14px;
  color: #666;
  margin-bottom: 8px;
}

.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #333;
}

.quick-actions {
  display: flex;
  gap: 15px;
}
</style>
