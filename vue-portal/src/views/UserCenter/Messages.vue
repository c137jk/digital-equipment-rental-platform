<template>
  <div class="messages-container">
    <el-button type="text" icon="el-icon-arrow-left" @click="$router.push('/user/profile')" class="back-button">
      返回个人资料
    </el-button>
    <div class="messages-header">
      <h2>消息通知</h2>
      <el-button type="primary" size="small" @click="handleReadAll" :disabled="unreadCount === 0">
        全部已读
      </el-button>
    </div>

    <div v-loading="loading">
      <div v-for="msg in messageList" :key="msg.messageId" 
           class="message-item" 
           :class="{ 'unread': msg.isRead === '0' }"
           @click="handleRead(msg)">
        <div class="message-icon">
          <el-icon :size="20" :color="msg.isRead === '0' ? '#409eff' : '#c0c4cc'">
            <Bell v-if="msg.type === 'order'" />
            <Notification v-else />
          </el-icon>
        </div>
        <div class="message-content">
          <div class="message-title">
            <span>{{ msg.title }}</span>
            <el-tag v-if="msg.isRead === '0'" type="danger" size="small" effect="dark">新</el-tag>
          </div>
          <p class="message-text">{{ msg.content }}</p>
          <span class="message-time">{{ msg.createTime }}</span>
        </div>
      </div>

      <el-empty v-if="!loading && messageList.length === 0" description="暂无消息" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Bell, Notification } from '@element-plus/icons-vue'
import { myMessageList, readMessage, readAllMessages, getUnreadCount } from '@/api/message'

const loading = ref(false)
const messageList = ref([])
const unreadCount = ref(0)

const loadMessages = () => {
  loading.value = true
  myMessageList().then(res => {
    messageList.value = res.data || []
    unreadCount.value = messageList.value.filter(m => m.isRead === '0').length
  }).finally(() => {
    loading.value = false
  })
}

const handleRead = (msg) => {
  if (msg.isRead === '0') {
    readMessage(msg.messageId).then(() => {
      msg.isRead = '1'
      unreadCount.value = Math.max(0, unreadCount.value - 1)
    })
  }
}

const handleReadAll = () => {
  readAllMessages().then(() => {
    messageList.value.forEach(msg => msg.isRead = '1')
    unreadCount.value = 0
    ElMessage.success('已全部标记为已读')
  })
}

onMounted(() => {
  loadMessages()
})
</script>

<style scoped>
.messages-container {
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
}

.back-button {
  margin-bottom: 20px;
  font-size: 16px;
}

.messages-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.message-item {
  display: flex;
  padding: 16px;
  border: 1px solid #ebeef5;
  border-radius: 8px;
  margin-bottom: 12px;
  cursor: pointer;
  transition: all 0.3s;
}

.message-item:hover {
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.message-item.unread {
  background: #ecf5ff;
  border-color: #b3d8ff;
}

.message-icon {
  margin-right: 15px;
  padding-top: 3px;
}

.message-content {
  flex: 1;
}

.message-title {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 16px;
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
}

.message-text {
  font-size: 14px;
  color: #666;
  line-height: 1.6;
  margin-bottom: 8px;
}

.message-time {
  font-size: 12px;
  color: #999;
}
</style>
