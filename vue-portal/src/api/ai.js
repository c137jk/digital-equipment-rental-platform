import request from '@/utils/request'

// 发送 AI 聊天消息
export function sendAiMessage(message) {
    return request({
        url: '/rental/ai/chat',
        method: 'post',
        data: { message }
    })
}
