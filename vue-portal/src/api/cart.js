import request from '@/utils/request'

// 查询购物车列表
export function listCart() {
    return request({
        url: '/rental/cart/list',
        method: 'get'
    })
}

// 添加到购物车
export function addCart(data) {
    return request({
        url: '/rental/cart',
        method: 'post',
        data: data
    })
}

// 更新购物车
export function updateCart(data) {
    return request({
        url: '/rental/cart',
        method: 'put',
        data: data
    })
}

// 删除购物车
export function delCart(cartIds) {
    return request({
        url: '/rental/cart/' + cartIds,
        method: 'delete'
    })
}

// 清空购物车
export function clearCart() {
    return request({
        url: '/rental/cart/clear',
        method: 'delete'
    })
}
