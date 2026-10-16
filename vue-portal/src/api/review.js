import request from '@/utils/request'

// 查询设备评价列表
export function listReview(equipmentId) {
    return request({
        url: '/rental/review/list/' + equipmentId,
        method: 'get'
    })
}

// 提交评价
export function addReview(data) {
    return request({
        url: '/rental/review',
        method: 'post',
        data: data
    })
}

// 检查是否已评价
export function checkReview(orderId) {
    return request({
        url: '/rental/review/check/' + orderId,
        method: 'get'
    })
}
