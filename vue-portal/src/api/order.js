import request from '@/utils/request'

// 查询订单列表
export function listOrder(query) {
    return request({
        url: '/rental/order/list',
        method: 'get',
        params: query
    })
}

// 查询我的订单
export function myOrderList(query) {
    return request({
        url: '/rental/order/mylist',
        method: 'get',
        params: query
    })
}

// 查询订单详情
export function getOrder(orderId) {
    return request({
        url: '/rental/order/' + orderId,
        method: 'get'
    })
}

// 创建订单
export function createOrder(data) {
    return request({
        url: '/rental/order',
        method: 'post',
        data: data
    })
}

// 支付订单
export function payOrder(orderId) {
    return request({
        url: '/rental/order/pay/' + orderId,
        method: 'put'
    })
}

// 取消订单
export function cancelOrder(orderId) {
    return request({
        url: '/rental/order/cancel/' + orderId,
        method: 'put'
    })
}

// 归还设备
export function returnOrder(orderId) {
    return request({
        url: '/rental/order/return/' + orderId,
        method: 'put'
    })
}

// 申请归还(上传快递单号)
export function applyReturn(data) {
    return request({
        url: '/rental/order/applyReturn',
        method: 'put',
        data: data
    })
}

// 申请延期
export function applyExtend(orderId, extendDays) {
    return request({
        url: '/rental/order/applyExtend/' + orderId,
        method: 'put',
        params: { extendDays }
    })
}

// 验证优惠码
export function validateCoupon(couponCode, orderAmount) {
    return request({
        url: '/rental/coupon/validate',
        method: 'get',
        params: { couponCode, orderAmount }
    })
}
