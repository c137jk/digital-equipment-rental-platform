import request from '@/utils/request'

// 查询收藏列表
export function listFavorite() {
    return request({
        url: '/rental/favorite/list',
        method: 'get'
    })
}

// 检查是否已收藏
export function checkFavorite(equipmentId) {
    return request({
        url: '/rental/favorite/check/' + equipmentId,
        method: 'get'
    })
}

// 添加收藏
export function addFavorite(data) {
    return request({
        url: '/rental/favorite',
        method: 'post',
        data: data
    })
}

// 取消收藏
export function delFavorite(equipmentId) {
    return request({
        url: '/rental/favorite/' + equipmentId,
        method: 'delete'
    })
}
