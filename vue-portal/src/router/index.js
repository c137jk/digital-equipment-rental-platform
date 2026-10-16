import { createRouter, createWebHistory } from 'vue-router'
import { getToken } from '@/utils/auth'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('@/views/Home.vue'),
      meta: { title: '首页' }
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/views/Login.vue'),
      meta: { title: '登录' }
    },
    {
      path: '/register',
      name: 'register',
      component: () => import('@/views/Register.vue'),
      meta: { title: '注册' }
    },
    {
      path: '/equipment',
      name: 'equipment-list',
      component: () => import('@/views/EquipmentList.vue'),
      meta: { title: '设备列表' }
    },
    {
      path: '/equipment/:id',
      name: 'equipment-detail',
      component: () => import('@/views/EquipmentDetail.vue'),
      meta: { title: '设备详情' }
    },
    {
      path: '/cart',
      name: 'cart',
      component: () => import('@/views/Cart.vue'),
      meta: { title: '购物车', requiresAuth: true }
    },
    {
      path: '/checkout',
      name: 'checkout',
      component: () => import('@/views/Checkout.vue'),
      meta: { title: '结算', requiresAuth: true }
    },
    {
      path: '/orders',
      name: 'order-list',
      component: () => import('@/views/OrderList.vue'),
      meta: { title: '我的订单', requiresAuth: true }
    },
    {
      path: '/orders/:id',
      name: 'order-detail',
      component: () => import('@/views/OrderDetail.vue'),
      meta: { title: '订单详情', requiresAuth: true }
    },
    {
      path: '/user',
      name: 'user-center',
      component: () => import('@/views/UserCenter/Index.vue'),
      meta: { title: '个人中心', requiresAuth: true },
      children: [
        {
          path: 'profile',
          name: 'user-profile',
          component: () => import('@/views/UserCenter/Profile.vue'),
          meta: { title: '个人资料', requiresAuth: true }
        },
        {
          path: 'orders',
          name: 'user-orders',
          component: () => import('@/views/UserCenter/RentalHistory.vue'),
          meta: { title: '租赁记录', requiresAuth: true }
        },
        {
          path: 'favorites',
          name: 'user-favorites',
          component: () => import('@/views/UserCenter/Favorites.vue'),
          meta: { title: '我的收藏', requiresAuth: true }
        },
        {
          path: 'password',
          name: 'user-password',
          component: () => import('@/views/UserCenter/ChangePassword.vue'),
          meta: { title: '修改密码', requiresAuth: true }
        },
        {
          path: 'messages',
          name: 'user-messages',
          component: () => import('@/views/UserCenter/Messages.vue'),
          meta: { title: '消息通知', requiresAuth: true }
        }
      ]
    }
  ],
})

// 路由守卫
router.beforeEach((to, from, next) => {
  const token = getToken()

  if (to.meta.requiresAuth && !token) {
    // 需要登录但未登录,跳转到登录页
    next({ path: '/login', query: { redirect: to.fullPath } })
  } else if (to.path === '/login' && token) {
    // 已登录访问登录页,跳转到首页
    next({ path: '/' })
  } else {
    next()
  }
})

export default router
