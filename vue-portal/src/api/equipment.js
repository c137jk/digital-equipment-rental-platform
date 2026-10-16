import request from '@/utils/request'

// 查询设备列表
export function listEquipment(query) {
    return request({
        url: '/rental/equipment/list',
        method: 'get',
        params: query
    })
}

// 查询设备详情
export function getEquipment(equipmentId) {
    return request({
        url: '/rental/equipment/' + equipmentId,
        method: 'get'
    })
}

// 新增设备
export function addEquipment(data) {
    return request({
        url: '/rental/equipment',
        method: 'post',
        data: data
    })
}

// 修改设备
export function updateEquipment(data) {
    return request({
        url: '/rental/equipment',
        method: 'put',
        data: data
    })
}

// 删除设备
export function delEquipment(equipmentId) {
    return request({
        url: '/rental/equipment/' + equipmentId,
        method: 'delete'
    })
}

// 热门设备
export function hotEquipment() {
    return request({
        url: '/rental/equipment/hot',
        method: 'get'
    })
}

// 同类推荐
export function recommendEquipment(equipmentId) {
    return request({
        url: '/rental/equipment/recommend/' + equipmentId,
        method: 'get'
    })
}
