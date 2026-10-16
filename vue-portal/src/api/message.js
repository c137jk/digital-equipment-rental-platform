import request from '@/utils/request'

// 获取我的消息列表
export function myMessageList() {
    return request({
        url: '/rental/message/mylist',
        method: 'get'
    })
}

// 获取未读消息数量
export function getUnreadCount() {
    return request({
        url: '/rental/message/unreadCount',
        method: 'get'
    })
}

// 标记消息为已读
export function readMessage(messageId) {
    return request({
        url: '/rental/message/read/' + messageId,
        method: 'put'
    })
}

// 全部标记为已读
export function readAllMessages() {
    return request({
        url: '/rental/message/readAll',
        method: 'put'
    })
}
