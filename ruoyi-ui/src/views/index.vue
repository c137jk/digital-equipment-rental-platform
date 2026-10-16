<template>
  <div class="dashboard-container">
    <!-- 顶部欢迎横幅 -->
    <div class="welcome-banner">
      <div class="welcome-content">
        <div class="welcome-text">
          <h1>数码设备租赁管理系统</h1>
          <p>欢迎回来，{{ nickName }}！今天是 {{ currentDate }}</p>
        </div>
        <div class="welcome-version">
          <el-tag effect="dark" round>v1.0.0</el-tag>
        </div>
      </div>
      <div class="welcome-deco">
        <div class="deco-circle deco-1"></div>
        <div class="deco-circle deco-2"></div>
      </div>
    </div>

    <!-- 数据统计卡片 -->
    <el-row :gutter="20" class="stat-row">
      <el-col :xs="12" :sm="6">
        <div class="stat-card stat-blue" @click="goToEquipment">
          <div class="stat-icon">
            <i class="el-icon-s-goods"></i>
          </div>
          <div class="stat-info">
            <span class="stat-num">{{ stats.equipmentCount }}</span>
            <span class="stat-label">设备总数</span>
          </div>
        </div>
      </el-col>
      <el-col :xs="12" :sm="6">
        <div class="stat-card stat-green" @click="goToOrder">
          <div class="stat-icon">
            <i class="el-icon-s-order"></i>
          </div>
          <div class="stat-info">
            <span class="stat-num">{{ stats.orderCount }}</span>
            <span class="stat-label">订单总数</span>
          </div>
        </div>
      </el-col>
      <el-col :xs="12" :sm="6">
        <div class="stat-card stat-orange">
          <div class="stat-icon">
            <i class="el-icon-user-solid"></i>
          </div>
          <div class="stat-info">
            <span class="stat-num">7</span>
            <span class="stat-label">用户数量</span>
          </div>
        </div>
      </el-col>
      <el-col :xs="12" :sm="6">
        <div class="stat-card stat-purple" @click="goToCategory">
          <div class="stat-icon">
            <i class="el-icon-menu"></i>
          </div>
          <div class="stat-info">
            <span class="stat-num">{{ stats.categoryCount }}</span>
            <span class="stat-label">设备分类</span>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 功能模块 -->
    <el-row :gutter="20" class="content-row">
      <el-col :xs="24" :sm="24" :md="8">
        <div class="info-card">
          <div class="card-header">
            <span class="card-icon card-icon-blue"><i class="el-icon-s-tools"></i></span>
            <h3>系统功能</h3>
          </div>
          <div class="card-body">
            <div class="feature-item">
              <span class="feature-dot dot-blue"></span>
              <span>设备管理：设备信息维护、库存管理、分类管理</span>
            </div>
            <div class="feature-item">
              <span class="feature-dot dot-green"></span>
              <span>订单管理：订单处理、发货确认、归还管理</span>
            </div>
            <div class="feature-item">
              <span class="feature-dot dot-orange"></span>
              <span>用户管理：用户信息、权限控制、角色管理</span>
            </div>
            <div class="feature-item">
              <span class="feature-dot dot-purple"></span>
              <span>数据统计：租赁概况、设备统计、订单分析</span>
            </div>
          </div>
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :md="8">
        <div class="info-card">
          <div class="card-header">
            <span class="card-icon card-icon-green"><i class="el-icon-star-on"></i></span>
            <h3>核心特性</h3>
          </div>
          <div class="card-body">
            <div class="feature-item" v-for="(item, i) in features" :key="i">
              <i class="el-icon-circle-check" style="color:#52c41a;font-size:16px;"></i>
              <span>{{ item }}</span>
            </div>
          </div>
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :md="8">
        <div class="info-card">
          <div class="card-header">
            <span class="card-icon card-icon-orange"><i class="el-icon-guide"></i></span>
            <h3>快捷操作</h3>
          </div>
          <div class="card-body">
            <div class="quick-actions">
              <div class="action-btn" @click="goToEquipment">
                <i class="el-icon-s-goods"></i>
                <span>设备管理</span>
              </div>
              <div class="action-btn" @click="goToOrder">
                <i class="el-icon-s-order"></i>
                <span>订单管理</span>
              </div>
              <div class="action-btn" @click="goToCategory">
                <i class="el-icon-menu"></i>
                <span>分类管理</span>
              </div>
              <div class="action-btn" @click="goToCoupon">
                <i class="el-icon-present"></i>
                <span>优惠券</span>
              </div>
              <div class="action-btn" @click="goToStats">
                <i class="el-icon-s-data"></i>
                <span>数据统计</span>
              </div>
              <div class="action-btn" @click="goToUser">
                <i class="el-icon-user"></i>
                <span>用户管理</span>
              </div>
            </div>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 技术架构 -->
    <el-row :gutter="20" class="content-row">
      <el-col :span="24">
        <div class="info-card tech-card">
          <div class="card-header">
            <span class="card-icon card-icon-purple"><i class="el-icon-cpu"></i></span>
            <h3>技术架构</h3>
          </div>
          <div class="card-body">
            <el-row :gutter="40">
              <el-col :xs="24" :sm="12">
                <h4 class="tech-title">后端技术</h4>
                <div class="tech-tags">
                  <el-tag v-for="tech in backendTechs" :key="tech" effect="plain" round>{{ tech }}</el-tag>
                </div>
              </el-col>
              <el-col :xs="24" :sm="12">
                <h4 class="tech-title">前端技术</h4>
                <div class="tech-tags">
                  <el-tag v-for="tech in frontendTechs" :key="tech" type="success" effect="plain" round>{{ tech }}</el-tag>
                </div>
              </el-col>
            </el-row>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { listEquipment } from "@/api/rental/equipment"
import { listCategory } from "@/api/rental/category"
import { listOrder } from "@/api/rental/order"

export default {
  name: "Index",
  data() {
    return {
      nickName: this.$store.getters.name || '管理员',
      stats: {
        equipmentCount: 0,
        orderCount: 0,
        userCount: 0,
        categoryCount: 0
      },
      features: [
        '完整的订单流程管理',
        '智能库存管理与预警',
        '灵活的租赁价格配置',
        '优惠券/折扣系统',
        '设备损坏管理',
        '租赁延期申请'
      ],
      backendTechs: ['Spring Boot', 'Spring Security', 'MyBatis', 'MySQL', 'Redis'],
      frontendTechs: ['Vue ', 'Element UI', 'Element Plus', 'Vite', 'Pinia']
    }
  },
  computed: {
    currentDate() {
      const d = new Date()
      const week = ['日', '一', '二', '三', '四', '五', '六']
      return `${d.getFullYear()}年${d.getMonth() + 1}月${d.getDate()}日 星期${week[d.getDay()]}`
    }
  },
  created() {
    this.loadStats()
  },
  methods: {
    loadStats() {
      listEquipment({ pageNum: 1, pageSize: 1 }).then(res => {
        this.stats.equipmentCount = res.total || 0
      }).catch(() => {})
      listOrder({ pageNum: 1, pageSize: 1 }).then(res => {
        this.stats.orderCount = res.total || 0
      }).catch(() => {})
      listCategory().then(res => {
        this.stats.categoryCount = (res.data || []).length
      }).catch(() => {})
      // 用户数量暂用占位
      this.stats.userCount = '--'
    },
    goToEquipment() {
      this.$router.push("/rental/equipment")
    },
    goToOrder() {
      this.$router.push("/rental/order")
    },
    goToCategory() {
      this.$router.push("/rental/category")
    },
    goToCoupon() {
      this.$router.push("/rental/coupon")
    },
    goToStats() {
      this.$router.push("/rental/stats")
    },
    goToUser() {
      this.$router.push("/system/user")
    }
  }
}
</script>

<style scoped lang="scss">
.dashboard-container {
  padding: 0;
}

/* ===== Welcome Banner ===== */
.welcome-banner {
  position: relative;
  background: linear-gradient(135deg, #4F8EF7 0%, #7C5CFC 50%, #A855F7 100%);
  border-radius: 16px;
  padding: 32px 36px;
  margin-bottom: 24px;
  overflow: hidden;
}

.welcome-content {
  position: relative;
  z-index: 2;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.welcome-text h1 {
  color: #fff;
  font-size: 28px;
  font-weight: 700;
  margin: 0 0 8px 0;
  letter-spacing: -0.5px;
}

.welcome-text p {
  color: rgba(255, 255, 255, 0.8);
  font-size: 14px;
  margin: 0;
}

.welcome-deco {
  position: absolute;
  inset: 0;
  z-index: 1;
}

.deco-circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.06);
}

.deco-1 {
  width: 300px;
  height: 300px;
  right: -60px;
  top: -80px;
}

.deco-2 {
  width: 180px;
  height: 180px;
  right: 160px;
  bottom: -60px;
  background: rgba(255, 255, 255, 0.04);
}

/* ===== Stat Cards ===== */
.stat-row {
  margin-bottom: 24px;
}

.stat-card {
  border-radius: 14px;
  padding: 24px;
  display: flex;
  align-items: center;
  gap: 18px;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
  margin-bottom: 12px;
}

.stat-card:hover {
  transform: translateY(-4px);
}

.stat-blue {
  background: linear-gradient(135deg, #e8f0fe 0%, #d1e3ff 100%);
  .stat-icon { color: #4F8EF7; background: rgba(79, 142, 247, 0.15); }
  &:hover { box-shadow: 0 12px 24px rgba(79, 142, 247, 0.2); }
}

.stat-green {
  background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
  .stat-icon { color: #4CAF50; background: rgba(76, 175, 80, 0.15); }
  &:hover { box-shadow: 0 12px 24px rgba(76, 175, 80, 0.2); }
}

.stat-orange {
  background: linear-gradient(135deg, #fff3e0 0%, #ffe0b2 100%);
  .stat-icon { color: #FF9800; background: rgba(255, 152, 0, 0.15); }
  &:hover { box-shadow: 0 12px 24px rgba(255, 152, 0, 0.2); }
}

.stat-purple {
  background: linear-gradient(135deg, #ede7f6 0%, #d1c4e9 100%);
  .stat-icon { color: #7C5CFC; background: rgba(124, 92, 252, 0.15); }
  &:hover { box-shadow: 0 12px 24px rgba(124, 92, 252, 0.2); }
}

.stat-icon {
  width: 54px;
  height: 54px;
  border-radius: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
  flex-shrink: 0;
}

.stat-info {
  display: flex;
  flex-direction: column;
}

.stat-num {
  font-size: 28px;
  font-weight: 800;
  color: #1a1a2e;
  line-height: 1.2;
}

.stat-label {
  font-size: 13px;
  color: #666;
  margin-top: 2px;
}

/* ===== Info Cards ===== */
.content-row {
  margin-bottom: 20px;
}

.info-card {
  background: #fff;
  border-radius: 14px;
  padding: 0;
  margin-bottom: 16px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
  border: 1px solid rgba(0, 0, 0, 0.04);
  overflow: hidden;
}

.card-header {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 20px 24px 0;
}

.card-header h3 {
  margin: 0;
  font-size: 17px;
  font-weight: 700;
  color: #1a1a2e;
}

.card-icon {
  width: 36px;
  height: 36px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
}

.card-icon-blue { background: #e8f0fe; color: #4F8EF7; }
.card-icon-green { background: #e8f5e9; color: #52c41a; }
.card-icon-orange { background: #fff3e0; color: #FF9800; }
.card-icon-purple { background: #ede7f6; color: #7C5CFC; }

.card-body {
  padding: 20px 24px;
}

/* ===== Features ===== */
.feature-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px 0;
  font-size: 14px;
  color: #444;
  border-bottom: 1px solid #f5f5f5;

  &:last-child { border-bottom: none; }
}

.feature-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  flex-shrink: 0;
}

.dot-blue { background: #4F8EF7; }
.dot-green { background: #52c41a; }
.dot-orange { background: #FF9800; }
.dot-purple { background: #7C5CFC; }

/* ===== Quick Actions ===== */
.quick-actions {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 12px;
}

.action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 20px 12px;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s;
  background: #f8f9fd;
  border: 1px solid transparent;

  i {
    font-size: 24px;
    color: #4F8EF7;
  }

  span {
    font-size: 12px;
    color: #666;
    font-weight: 500;
  }

  &:hover {
    background: #e8f0fe;
    border-color: rgba(79, 142, 247, 0.2);
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(79, 142, 247, 0.15);

    i { color: #3D7DE5; }
    span { color: #4F8EF7; }
  }
}

/* ===== Tech Tags ===== */
.tech-title {
  font-size: 15px;
  font-weight: 600;
  color: #1a1a2e;
  margin: 0 0 12px 0;
}

.tech-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.tech-tags .el-tag {
  font-size: 13px;
  padding: 6px 16px;
  height: auto;
}
</style>
