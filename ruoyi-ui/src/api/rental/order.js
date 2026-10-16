import request from '@/utils/request'

// 查询订单列表
export function listOrder(query) {
    return request({
        url: '/rental/order/list',
        method: 'get',
        params: query
    })
}

// 查询订单详细
export function getOrder(orderId) {
    return request({
        url: '/rental/order/' + orderId,
        method: 'get'
    })
}

// 确认归还
export function returnOrder(orderId) {
    return request({
        url: '/rental/order/return/' + orderId,
        method: 'put'
    })
}

// 确认发货(管理员)
export function shipOrder(orderId) {
    return request({
        url: '/rental/order/ship/' + orderId,
        method: 'put'
    })
}

// 确认收货(管理员)
export function confirmReturn(orderId) {
    return request({
        url: '/rental/order/confirmReturn/' + orderId,
        method: 'put'
    })
}

// 确认归还(标记损坏)
export function confirmReturnWithDamage(orderId, deductAmount, deductReason) {
    return request({
        url: '/rental/order/confirmReturnWithDamage/' + orderId,
        method: 'put',
        params: { deductAmount, deductReason }
    })
}

// 审批延期(批准)
export function approveExtend(orderId) {
    return request({
        url: '/rental/order/approveExtend/' + orderId,
        method: 'put'
    })
}

// 审批延期(拒绝)
export function rejectExtend(orderId) {
    return request({
        url: '/rental/order/rejectExtend/' + orderId,
        method: 'put'
    })
}
