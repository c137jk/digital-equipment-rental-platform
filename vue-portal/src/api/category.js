import request from '@/utils/request'

// 查询分类列表
export function listCategory() {
    return request({
        url: '/rental/category/list',
        method: 'get'
    })
}
