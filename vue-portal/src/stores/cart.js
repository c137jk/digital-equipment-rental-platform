import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { listCart, addCart, updateCart, delCart, clearCart } from '@/api/cart'

export const useCartStore = defineStore('cart', () => {
    const cartList = ref([])
    const loading = ref(false)

    // 购物车数量
    const cartCount = computed(() => cartList.value.length)

    // 购物车总金额
    const totalAmount = computed(() => {
        return cartList.value.reduce((total, item) => {
            const equipment = item.equipment
            let price = 0

            // 根据租赁类型计算价格
            if (item.rentalType === '1') {
                price = equipment.dailyPrice * item.rentalDays
            } else if (item.rentalType === '2') {
                price = equipment.weeklyPrice
            } else if (item.rentalType === '3') {
                price = equipment.monthlyPrice
            }

            return total + (price * item.quantity)
        }, 0)
    })

    // 获取购物车列表
    function getCartList() {
        loading.value = true
        return listCart().then(res => {
            cartList.value = res.data || []
            return res
        }).finally(() => {
            loading.value = false
        })
    }

    // 添加到购物车
    function addToCart(data) {
        return addCart(data).then(res => {
            getCartList()
            return res
        })
    }

    // 更新购物车
    function updateCartItem(data) {
        return updateCart(data).then(res => {
            getCartList()
            return res
        })
    }

    // 删除购物车项
    function deleteCartItem(cartIds) {
        return delCart(cartIds).then(res => {
            getCartList()
            return res
        })
    }

    // 清空购物车
    function clearCartList() {
        return clearCart().then(res => {
            cartList.value = []
            return res
        })
    }

    return {
        cartList,
        loading,
        cartCount,
        totalAmount,
        getCartList,
        addToCart,
        updateCartItem,
        deleteCartItem,
        clearCartList
    }
}, {
    persist: true
})
