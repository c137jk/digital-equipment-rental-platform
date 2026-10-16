<template>
  <div class="user-center">
    <el-container>
      <el-aside width="200px">
        <el-menu
          :default-active="$route.path"
          router
          class="user-menu"
        >
          <el-menu-item index="/user/profile">
            <el-icon><User /></el-icon>
            <span>个人资料</span>
          </el-menu-item>
          <el-menu-item index="/user/orders">
            <el-icon><Document /></el-icon>
            <span>租赁记录</span>
          </el-menu-item>
          <el-menu-item index="/user/favorites">
            <el-icon><Star /></el-icon>
            <span>我的收藏</span>
          </el-menu-item>
          <el-menu-item index="/user/messages">
            <el-icon><Bell /></el-icon>
            <span>消息通知</span>
          </el-menu-item>
          <el-menu-item index="/user/password">
            <el-icon><Lock /></el-icon>
            <span>修改密码</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
      
      <el-main>
        <router-view />
      </el-main>
    </el-container>
  </div>
</template>

<script setup>
import { User, Document, Star, Bell, Lock } from '@element-plus/icons-vue'
</script>

<style scoped>
.user-center {
  max-width: 1200px;
  margin: 0 auto;
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
}

.user-menu {
  height: 100%;
  border-right: 1px solid #e8e8e8;
}
</style>
