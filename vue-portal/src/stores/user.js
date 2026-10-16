import { defineStore } from 'pinia'
import { ref } from 'vue'
import { login, getInfo, logout } from '@/api/auth'
import { getToken, setToken, removeToken, setUserInfo, removeUserInfo } from '@/utils/auth'

export const useUserStore = defineStore('user', () => {
    const token = ref(getToken())
    const userInfo = ref(null)
    const roles = ref([])
    const permissions = ref([])

    // 登录
    function userLogin(loginForm) {
        return new Promise((resolve, reject) => {
            login(loginForm).then(res => {
                setToken(res.token)
                token.value = res.token
                resolve()
            }).catch(error => {
                reject(error)
            })
        })
    }

    // 获取用户信息
    function getUserInfo() {
        return new Promise((resolve, reject) => {
            getInfo().then(res => {
                userInfo.value = res.user
                roles.value = res.roles
                permissions.value = res.permissions
                setUserInfo(res.user)
                resolve(res)
            }).catch(error => {
                reject(error)
            })
        })
    }

    // 退出登录
    function userLogout() {
        return new Promise((resolve, reject) => {
            logout().then(() => {
                token.value = ''
                userInfo.value = null
                roles.value = []
                permissions.value = []
                removeToken()
                removeUserInfo()
                resolve()
            }).catch(error => {
                reject(error)
            })
        })
    }

    return {
        token,
        userInfo,
        roles,
        permissions,
        userLogin,
        getUserInfo,
        userLogout
    }
}, {
    persist: true
})
