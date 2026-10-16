<template>
  <div class="equipment-card" @click="handleClick">
    <div class="card-image-wrap">
      <img :src="imageUrl" :alt="equipment.equipmentName" class="card-image" />
      <div class="card-badge" v-if="equipment.stock <= 0">
        <span>已租完</span>
      </div>
      <div class="card-overlay">
        <el-button type="primary" round :disabled="equipment.stock <= 0">查看详情</el-button>
      </div>
    </div>
    
    <div class="card-body">
      <h3 class="card-title">{{ equipment.equipmentName }}</h3>
      <p class="card-subtitle">{{ equipment.brand }} {{ equipment.model }}</p>
      
      <div class="card-bottom">
        <div class="card-price">
          <span class="price-symbol">¥</span>
          <span class="price-value">{{ equipment.dailyPrice }}</span>
          <span class="price-unit">/天</span>
        </div>
        <div class="card-stock" :class="{ 'low-stock': equipment.stock > 0 && equipment.stock <= 2 }">
          <el-icon><Box /></el-icon>
          <span>{{ equipment.stock > 0 ? '库存 ' + equipment.stock : '暂无库存' }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { Box } from '@element-plus/icons-vue'

const props = defineProps({
  equipment: {
    type: Object,
    required: true
  }
})

const router = useRouter()

const imageUrl = computed(() => {
  if (!props.equipment.mainImage) {
    return '/placeholder.jpg'
  }
  if (props.equipment.mainImage.startsWith('http')) {
    return props.equipment.mainImage
  }
  return `http://localhost:8080${props.equipment.mainImage}`
})

const handleClick = () => {
  router.push(`/equipment/${props.equipment.equipmentId}`)
}
</script>

<style scoped>
.equipment-card {
  background: #fff;
  border-radius: 16px;
  overflow: hidden;
  cursor: pointer;
  transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
  margin-bottom: 24px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
  border: 1px solid rgba(0, 0, 0, 0.04);
}

.equipment-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 20px 40px rgba(79, 142, 247, 0.15);
  border-color: rgba(79, 142, 247, 0.1);
}

.card-image-wrap {
  position: relative;
  width: 100%;
  height: 220px;
  overflow: hidden;
  background: linear-gradient(135deg, #f6f8fc 0%, #eef1f7 100%);
}

.card-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s cubic-bezier(0.25, 0.8, 0.25, 1);
}

.equipment-card:hover .card-image {
  transform: scale(1.08);
}

.card-badge {
  position: absolute;
  top: 12px;
  right: 12px;
  z-index: 2;
}

.card-badge span {
  background: linear-gradient(135deg, #ff6b6b, #ee5a24);
  color: #fff;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 600;
  box-shadow: 0 2px 8px rgba(238, 90, 36, 0.3);
}

.card-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  padding: 20px;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.5));
  display: flex;
  justify-content: center;
  opacity: 0;
  transform: translateY(10px);
  transition: all 0.3s;
}

.equipment-card:hover .card-overlay {
  opacity: 1;
  transform: translateY(0);
}

.card-body {
  padding: 18px 20px 20px;
}

.card-title {
  font-size: 16px;
  font-weight: 700;
  color: #1a1a2e;
  margin: 0 0 6px 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  letter-spacing: -0.3px;
}

.card-subtitle {
  font-size: 13px;
  color: #8892a4;
  margin: 0 0 16px 0;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.card-bottom {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
}

.card-price {
  display: flex;
  align-items: baseline;
}

.price-symbol {
  font-size: 14px;
  font-weight: 700;
  color: #ff6348;
}

.price-value {
  font-size: 24px;
  font-weight: 800;
  color: #ff6348;
  line-height: 1;
  margin: 0 2px;
}

.price-unit {
  font-size: 12px;
  color: #8892a4;
}

.card-stock {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 13px;
  color: #8892a4;
}

.card-stock.low-stock {
  color: #e67e22;
}
</style>
