import request from '@/utils/request'

// 查询优惠券列表
export function listCoupon(query) {
    return request({
        url: '/rental/coupon/list',
        method: 'get',
        params: query
    })
}

// 新增优惠券
export function addCoupon(data) {
    return request({
        url: '/rental/coupon',
        method: 'post',
        data: data
    })
}

// 修改优惠券
export function updateCoupon(data) {
    return request({
        url: '/rental/coupon',
        method: 'put',
        data: data
    })
}

// 删除优惠券
export function delCoupon(couponIds) {
    return request({
        url: '/rental/coupon/' + couponIds,
        method: 'delete'
    })
}
