import request from '@/utils/request'

// 获取统计概览
export function getStatisticsOverview() {
    return request({
        url: '/rental/statistics/overview',
        method: 'get'
    })
}

// 获取近7天订单趋势
export function getOrderTrend() {
    return request({
        url: '/rental/statistics/orderTrend',
        method: 'get'
    })
}

// 获取近7天收入趋势
export function getRevenueTrend() {
    return request({
        url: '/rental/statistics/revenueTrend',
        method: 'get'
    })
}

// 获取设备租赁排行
export function getEquipmentRank() {
    return request({
        url: '/rental/statistics/equipmentRank',
        method: 'get'
    })
}
