<template>
  <div class="layout">
    <el-container>
      <el-header class="header">
        <div class="header-content">
          <div class="logo" @click="$router.push('/')">
            <el-icon><Monitor /></el-icon>
            <span>数码租赁平台</span>
          </div>
          
          <el-menu
            mode="horizontal"
            :default-active="activeMenu"
            class="nav-menu"
            @select="handleMenuSelect"
          >
            <el-menu-item index="/">首页</el-menu-item>
            <el-menu-item index="/equipment">设备列表</el-menu-item>
            <el-menu-item index="ai-chat" @click="showAiDialog = true">
              <el-icon><ChatLineRound /></el-icon>
              <span>AI 导购</span>
            </el-menu-item>
          </el-menu>

          <div class="header-actions">
            <el-badge :value="unreadCount" :hidden="unreadCount === 0" class="action-badge" v-if="userInfo">
              <el-button :icon="Bell" circle @click="router.push('/user/messages')" />
            </el-badge>
            <el-badge :value="cartCount" :hidden="cartCount === 0" class="action-badge">
              <el-button :icon="ShoppingCart" @click="handleCartClick">购物车</el-button>
            </el-badge>
            
            <template v-if="userInfo">
              <el-dropdown @command="handleCommand">
                <span class="user-dropdown">
                  <el-avatar :size="34" class="user-avatar">{{ userInfo.nickName?.charAt(0) }}</el-avatar>
                  <span class="user-name">{{ userInfo.nickName }}</span>
                </span>
                <template #dropdown>
                  <el-dropdown-menu>
                    <el-dropdown-item command="profile">个人中心</el-dropdown-item>
                    <el-dropdown-item command="orders">我的订单</el-dropdown-item>
                    <el-dropdown-item command="favorites">我的收藏</el-dropdown-item>
                    <el-dropdown-item divided command="logout">退出登录</el-dropdown-item>
                  </el-dropdown-menu>
                </template>
              </el-dropdown>
            </template>
            <template v-else>
              <el-button @click="$router.push('/login')" class="login-btn">登录</el-button>
              <el-button type="primary" @click="$router.push('/register')" class="register-btn">注册</el-button>
            </template>
          </div>
        </div>
      </el-header>

      <el-main class="main-content">
        <slot />
      </el-main>

      <el-footer class="footer">
        <div class="footer-content">
          <div class="footer-brand">
            <el-icon><Monitor /></el-icon>
            <span>数码设备租赁平台</span>
          </div>
          <div class="footer-links">
            <a href="#">关于我们</a>
            <a href="#">服务协议</a>
            <a href="#">隐私政策</a>
            <a href="#">帮助中心</a>
          </div>
          <p class="copyright">&copy; 2025 数码设备租赁平台 · 基于若依框架开发</p>
        </div>
      </el-footer>
    </el-container>

    <!-- 全局 AI 对话浮窗 -->
    <el-dialog
      v-model="showAiDialog"
      title="🤖 AI 专属导购"
      width="50%"
      class="ai-chat-dialog"
      :close-on-click-modal="false"
      destroy-on-close
    >
      <div class="ai-chat-section">
        <div class="ai-chat-body" ref="chatBodyRef">
          <div v-for="(msg, index) in chatList" :key="index" :class="['chat-msg', msg.role === 'user' ? 'msg-user' : 'msg-ai']">
            <div class="msg-avatar">{{ msg.role === 'user' ? '我' : 'AI' }}</div>
            <div class="msg-content" v-html="formatResponse(msg.content)"></div>
          </div>
          <div class="chat-msg msg-ai" v-if="aiLoading">
            <div class="msg-avatar">AI</div>
            <div class="msg-content typing-indicator">
              <span></span><span></span><span></span>
            </div>
          </div>
        </div>
        
        <div class="ai-chat-footer">
          <el-input
            v-model="chatInput"
            placeholder="问问 AI：有什么适合拍 VLOG 的设备？或 50元内有什么电脑？"
            @keyup.enter="handleSendChat"
            :disabled="aiLoading"
          >
            <template #append>
              <el-button type="primary" :loading="aiLoading" @click="handleSendChat">发送</el-button>
            </template>
          </el-input>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import { computed, onMounted, ref, nextTick } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { Monitor, ShoppingCart, Bell, ChatLineRound } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import { useCartStore } from '@/stores/cart'
import { ElMessage } from 'element-plus'
import { getUnreadCount } from '@/api/message'
import { sendAiMessage } from '@/api/ai'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()
const cartStore = useCartStore()

const userInfo = computed(() => userStore.userInfo)
const cartCount = computed(() => cartStore.cartCount)
const activeMenu = computed(() => route.path)
const unreadCount = ref(0)


// 加载未读消息数
const loadUnreadCount = () => {
  if (userStore.token) {
    getUnreadCount().then(res => {
      unreadCount.value = res.data || 0
    }).catch(() => {})
  }
}

onMounted(() => {
  loadUnreadCount()
  setInterval(loadUnreadCount, 60000)
})

const handleMenuSelect = (index) => {
  if (index !== 'ai-chat') {
    router.push(index)
  }
}

const handleCommand = (command) => {
  switch (command) {
    case 'profile':
      router.push('/user/profile')
      break
    case 'orders':
      router.push('/user/orders')
      break
    case 'favorites':
      router.push('/user/favorites')
      break
    case 'logout':
      userStore.userLogout().then(() => {
        ElMessage.success('退出登录成功')
        router.push('/login')
      })
      break
  }
}

const handleCartClick = () => {
  if (!userStore.token) {
    ElMessage.warning('请先登录')
    router.push({ path: '/login', query: { redirect: '/cart' } })
    return
  }
  router.push('/cart')
}

// AI Chat 逻辑
const showAiDialog = ref(false)
const chatInput = ref('')
const chatList = ref([
  { role: 'ai', content: '您好！我是您的智能数码设备导购。您可以问我任何关于设备推荐、库存或价格的问题。' }
])
const aiLoading = ref(false)
const chatBodyRef = ref(null)

const scrollToBottom = async () => {
  await nextTick()
  if (chatBodyRef.value) {
    chatBodyRef.value.scrollTop = chatBodyRef.value.scrollHeight
  }
}

const handleSendChat = () => {
  if (!chatInput.value.trim() || aiLoading.value) return
  
  const msg = chatInput.value.trim()
  chatList.value.push({ role: 'user', content: msg })
  chatInput.value = ''
  aiLoading.value = true
  scrollToBottom()
  
  sendAiMessage(msg).then(res => {
    chatList.value.push({ role: 'ai', content: res.data || res.msg || '抱歉，暂时无法回答您的问题。' })
  }).catch(() => {
    chatList.value.push({ role: 'ai', content: '网络异常，请稍后再试。' })
  }).finally(() => {
    aiLoading.value = false
    scrollToBottom()
  })
}

const formatResponse = (text) => {
  if (!text) return ''
  return text.replace(/\n/g, '<br/>')
}
</script>

<style scoped>
.layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.header {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  box-shadow: 0 1px 10px rgba(0, 0, 0, 0.06);
  padding: 0;
  height: 64px !important;
  position: sticky;
  top: 0;
  z-index: 100;
  border-bottom: 1px solid rgba(0, 0, 0, 0.04);
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}

.logo {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 20px;
  font-weight: 700;
  background: linear-gradient(135deg, #4F8EF7, #7C5CFC);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  cursor: pointer;
  transition: opacity 0.3s;
}

.logo:hover {
  opacity: 0.8;
}

.logo .el-icon {
  -webkit-text-fill-color: #4F8EF7;
  font-size: 26px;
}

.nav-menu {
  flex: 1;
  border: none;
  margin: 0 40px;
}

.nav-menu :deep(.el-menu-item) {
  font-size: 15px;
  font-weight: 500;
  transition: all 0.3s;
}

.nav-menu :deep(.el-menu-item.is-active) {
  font-weight: 600;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.action-badge {
  margin-right: 4px;
}

.user-dropdown {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 4px 8px;
  border-radius: 20px;
  transition: background 0.3s;
}

.user-dropdown:hover {
  background: #f0f2f5;
}

.user-avatar {
  background: linear-gradient(135deg, #4F8EF7, #7C5CFC);
  color: #fff;
  font-weight: 600;
}

.user-name {
  font-size: 14px;
  font-weight: 500;
  color: #333;
}

.login-btn {
  border-radius: 20px;
}

.register-btn {
  border-radius: 20px;
  background: linear-gradient(135deg, #4F8EF7, #7C5CFC);
  border: none;
}

.register-btn:hover {
  background: linear-gradient(135deg, #3D7DE5, #6A4AEA);
}

.main-content {
  flex: 1;
  padding: 24px;
  background: linear-gradient(180deg, #F0F2F8 0%, #F8F9FD 100%);
  min-height: calc(100vh - 64px - 140px);
}

.footer {
  background: #1a1a2e;
  height: auto !important;
  padding: 32px 20px;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  text-align: center;
}

.footer-brand {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  font-size: 18px;
  font-weight: 600;
  color: #fff;
  margin-bottom: 16px;
}

.footer-links {
  display: flex;
  justify-content: center;
  gap: 24px;
  margin-bottom: 16px;
}

.footer-links a {
  color: rgba(255, 255, 255, 0.6);
  text-decoration: none;
  font-size: 14px;
  transition: color 0.3s;
}

.footer-links a:hover {
  color: #fff;
}

.copyright {
  color: rgba(255, 255, 255, 0.4);
  font-size: 13px;
  margin: 0;
}

/* ===== AI Chat Dialog Styles ===== */
:deep(.ai-chat-dialog) {
  border-radius: 16px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

:deep(.ai-chat-dialog .el-dialog__header) {
  margin: 0;
  padding: 20px 24px;
  background: linear-gradient(135deg, #4F8EF7, #7C5CFC);
  border-bottom: none;
}

:deep(.ai-chat-dialog .el-dialog__title) {
  color: #fff;
  font-weight: 700;
  font-size: 18px;
}

:deep(.ai-chat-dialog .el-dialog__headerbtn .el-dialog__close) {
  color: #fff;
}

:deep(.ai-chat-dialog .el-dialog__body) {
  padding: 0;
}

.ai-chat-section {
  display: flex;
  flex-direction: column;
  height: 60vh;
  min-height: 400px;
  background: #f8f9fd;
}

.ai-chat-body {
  flex: 1;
  padding: 24px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.chat-msg {
  display: flex;
  gap: 12px;
  max-width: 85%;
}

.msg-ai {
  align-self: flex-start;
}

.msg-user {
  align-self: flex-end;
  flex-direction: row-reverse;
}

.msg-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 600;
  color: #fff;
  flex-shrink: 0;
}

.msg-ai .msg-avatar {
  background: linear-gradient(135deg, #4F8EF7, #7C5CFC);
}

.msg-user .msg-avatar {
  background: #4CAF50;
}

.msg-content {
  padding: 12px 16px;
  border-radius: 16px;
  font-size: 14px;
  line-height: 1.6;
  position: relative;
  word-break: break-all;
}

.msg-ai .msg-content {
  background: #fff;
  color: #333;
  border-top-left-radius: 4px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.msg-user .msg-content {
  background: #4F8EF7;
  color: #fff;
  border-top-right-radius: 4px;
  box-shadow: 0 2px 8px rgba(79, 142, 247, 0.2);
}

.typing-indicator span {
  display: inline-block;
  width: 6px;
  height: 6px;
  background-color: #4F8EF7;
  border-radius: 50%;
  margin: 0 2px;
  animation: typing 1.4s infinite ease-in-out both;
}

.typing-indicator span:nth-child(1) { animation-delay: -0.32s; }
.typing-indicator span:nth-child(2) { animation-delay: -0.16s; }

@keyframes typing {
  0%, 80%, 100% { transform: scale(0); opacity: 0.5; }
  40% { transform: scale(1); opacity: 1; }
}

.ai-chat-footer {
  padding: 20px 24px;
  background: #fff;
  border-top: 1px solid rgba(0, 0, 0, 0.06);
}

.ai-chat-footer :deep(.el-input__wrapper) {
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  background: #f8f9fd;
  border-radius: 20px 0 0 20px;
}

.ai-chat-footer :deep(.el-input-group__append) {
  border-radius: 0 20px 20px 0;
  background: linear-gradient(135deg, #4F8EF7, #7C5CFC);
  color: #fff;
  border: none;
  overflow: hidden;
}

.ai-chat-footer :deep(.el-button) {
  border: none;
  font-weight: 600;
  padding: 0 24px;
}

.ai-chat-footer :deep(.el-input-group__append):hover {
  opacity: 0.9;
}
</style>
