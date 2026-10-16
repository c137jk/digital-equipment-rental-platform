# 数码设备租赁平台
## Digital Equipment Rental Platform

面向校园与个人用户的数码设备租赁一站式服务平台 —— 本科毕业设计
基于 SpringBoot 和 Vue.js 的数码租赁平台的设计与实现

覆盖 **用户 / 商家 / 管理员** 三类角色，构建「选品 — 下单 — 租赁 — 归还 — 结算」一体化闭环：
设备浏览 · 购物车 · 在线下单 · 优惠券 · 订单管理 · 评价互动 · AI 智能客服。

![Java](https://img.shields.io/badge/Java-11+-orange?logo=openjdk&logoColor=white)
![SpringBoot](https://img.shields.io/badge/SpringBoot-2.x-6DB33F?logo=springboot&logoColor=white)
![Vue](https://img.shields.io/badge/Vue-3-4FC08D?logo=vuedotjs&logoColor=white)
![Element Plus](https://img.shields.io/badge/Element%20Plus-2.x-409EFF?logo=elementplus&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql&logoColor=white)
![MyBatis-Plus](https://img.shields.io/badge/MyBatis--Plus-3.x-000000?logo=mybatis&logoColor=white)

---

## 目录

- [项目背景](#项目背景)
- [功能概览](#功能概览)
- [技术栈](#技术栈)
- [系统架构](#系统架构)
- [快速开始](#快速开始)
- [配置说明](#配置说明)
- [接口约定](#接口约定)
- [技术亮点](#技术亮点)
- [项目结构](#项目结构)
- [说明与声明](#说明与声明)

---

## 项目背景

随着消费升级与共享经济的发展，数码设备更新迭代速度加快，学生与年轻群体对高性能笔记本、相机、无人机等设备的
**短期使用需求**日益增长，但直接购买成本高、闲置周期长，传统线下租赁又存在流程不透明、押金风险大等问题。

本项目设计并实现一个面向校园场景的数码设备租赁平台，以
「设备浏览 → 选品下单 → 在线支付 → 租期管理 → 归还结算」为主线，
用一套系统把普通用户、入驻商家、平台管理员三类角色的业务流程串联起来。

---

## 功能概览

### 用户端（门户前台）

| 模块 | 说明 |
|------|------|
| 首页 | 轮播推荐、热门设备分类、新品上架、公告通知 |
| 设备浏览 | 按分类 / 品牌 / 价格区间筛选，卡片式展示设备信息 |
| 设备详情 | 高清图片、参数规格、租赁价格、库存、用户评价 |
| 购物车 | 加入购物车、数量调整、批量结算 |
| 订单中心 | 待付款 / 待发货 / 租赁中 / 已完成 / 已取消 全流程状态跟踪 |
| 优惠券 | 可领取优惠券、下单自动抵扣、券包管理 |
| 我的收藏 | 收藏感兴趣的设备，随时查看 |
| 评价互动 | 已完成订单可评价打分，上传图片，查看他人评价 |
| 消息中心 | 订单通知、优惠活动、系统消息，已读 / 未读管理 |
| AI 智能客服 | 接入大语言模型，根据设备库存自动解答用户咨询 |
| 个人中心 | 资料维护、收货地址、修改密码、租赁历史 |

### 商家端

| 模块 | 说明 |
|------|------|
| 商品管理 | 设备上下架、库存管理、价格调整、分类管理 |
| 订单管理 | 接单 / 发货 / 确认归还，订单状态跟踪 |
| 数据统计 | 销量统计、营收报表、热门设备排行 |

### 管理端（后台）

| 模块 | 说明 |
|------|------|
| 数据看板 | 用户注册趋势、订单量、交易额、活跃用户统计 |
| 用户管理 | 用户列表、状态管理、权限分配 |
| 商品管理 | 全平台设备审核、分类管理、品牌管理 |
| 订单管理 | 全平台订单监控、异常订单处理 |
| 商家管理 | 入驻商家审核、商家列表、状态管理 |
| 优惠券管理 | 优惠券创建、发放、核销统计 |
| 系统管理 | 角色权限、菜单管理、操作日志、参数配置 |

---

## 技术栈

### 后端
- Java 11 · SpringBoot 2.x
- MyBatis-Plus（持久层）· MySQL 8.0
- JWT（认证）· Spring AOP（方法级权限校验）
- Druid（数据库连接池）
- Quartz（定时任务）
- DeepSeek API（AI 智能客服，OpenAI 兼容接口）

### 前端
- Vue 3（组合式 API）· Vite
- Element Plus · Vue Router · Pinia
- ECharts（数据可视化）
- Axios（HTTP 请求）

---

## 系统架构

```
┌─────────────────────────────────────────────────────────────┐
│                      浏览器（用户 / 商家 / 管理）              │
│   Vue 3 + Vite + Element Plus + Pinia + Vue Router         │
│   ECharts 可视化 │ 响应式布局 │ 权限路由守卫                   │
└───────────────────────────┬─────────────────────────────────┘
                            │  HTTP / JSON（/api/**，Vite 代理）
                            │  Authorization: Bearer <JWT>
┌───────────────────────────▼─────────────────────────────────┐
│                    SpringBoot 应用层                         │
│  Controller ─ Service ─ Mapper（MyBatis-Plus）              │
│  ├─ AuthInterceptor  统一登录校验（白名单放行）                │
│  ├─ @RequireRole 三级角色权限校验（AOP 切面）                 │
│  ├─ GlobalExceptionHandler + 统一返回体 {code,msg,data}       │
│  └─ AiService  限流 / 内容安全 / 三级降级                      │
└───────────┬─────────────────────────────┬───────────────────┘
            │                             │
    ┌───────▼──────┐              ┌───────▼──────────┐
    │   MySQL 8.0   │              │  DeepSeek 大模型   │
    │   20+ 业务表  │              │  （AI 智能客服）    │
    └───────────────┘              └──────────────────┘
```

---

## 快速开始

### 环境要求

| 依赖 | 版本 |
|------|------|
| JDK | 11+ |
| Maven | 3.6+ |
| Node.js | 16+（推荐 18/20） |
| MySQL | 8.0 |

### 1. 初始化数据库

```bash
# 创建数据库并导入表结构与演示数据
mysql -u root -p < sql/rent.sql
```

### 2. 配置并启动后端

```bash
# 修改数据库配置
# 编辑 ruoyi-admin/src/main/resources/application-druid.yml
# 填入数据库用户名 / 密码

# 启动后端
mvn spring-boot:run
```

后端启动于 http://127.0.0.1:8080。

### 3. 启动前端（后台管理端）

```bash
cd ruoyi-ui
npm install
npm run dev
```

后台管理端启动于 http://127.0.0.1:8080。

### 4. 启动前端（用户门户端）

```bash
cd vue-portal
npm install
npm run dev
```

用户门户端启动于 http://127.0.0.1:5173。

### 5. 登录演示

演示账号（密码均为 123456，仅用于本地演示）：

| 角色 | 账号 |
|------|------|
| 管理员 | admin |
| 商家 | merchant01 |
| 用户 | user01 |

---

## 配置说明

| 配置项 | 配置文件 | 说明 |
|--------|----------|------|
| 数据库地址 | application-druid.yml | 默认 jdbc:mysql://127.0.0.1:3306/rent |
| 数据库账号 | application-druid.yml | 默认 root |
| 数据库密码 | application-druid.yml | 必须自行配置 |
| JWT 密钥 | application.yml | 必须自行配置 |
| DeepSeek API Key | AiChatController.java | 管理端动态配置，不落库前端 |

### 安全约定

- 仓库内 **不包含** 任何真实数据库密码或第三方 API Key；
- `application-local.yml`、`.env` 均已加入 `.gitignore`；
- 大模型 API Key 仅由后端持有，查询接口脱敏后不下发前端。

---

## 接口约定

统一前缀 `/api`，除登录 / 注册接口外均需携带 `Authorization: Bearer <token>`；

统一响应体：
```json
{
  "code": 0,
  "msg": "success",
  "data": {}
}
```

| 业务码 | 含义 |
|--------|------|
| 0 | 成功 |
| 401 | 未登录 / token 失效 |
| 403 | 无权限访问该资源 |
| 1001 | 参数校验失败 |
| 1002 | 用户名或密码错误 |
| 1101 | AI 服务未配置（管理端未填 API Key） |
| 1102 | AI 请求过于频繁（触发限流） |
| 1103 | 大模型密钥无效或已过期 |
| 1104 | 大模型账户余额不足 |
| 1105 | 被上游限流 |
| 1201 | 输入内容不合规（直接拒绝） |

---

## 技术亮点

### 1. 三级 RBAC 权限模型
AuthInterceptor 负责「是否登录」，自定义注解 `@RequireRole` + AOP 切面负责「是否有权访问该方法 / 该类」，
配合 UserContext 传递当前登录用户，实现方法级与类级双重校验。
前端请求层统一处理凭证：401 才清除 token 并跳登录，403 仅提示，避免越权提示误伤登录态。

### 2. AI 智能客服工程化封装
- **限流**：按 userId 维度的每分钟固定窗口限流器，超限抛出业务异常；
- **内容安全**：输入侧合规检测 + 生成内容的前置过滤，全量交互日志记录；
- **三级降级**：网络异常 / 超时 / 非 200 状态码统一捕获，降级返回预设文案；
- **密钥安全**：API Key 仅后端持有，管理端读取时脱敏。

### 3. 订单状态机闭环
订单从创建到完成的全生命周期状态流转：
`待付款 → 待发货 → 租赁中 → 已完成 → 已取消`
每个状态变更都有对应的业务校验，防止非法跳转，形成可信的订单闭环。

### 4. 优惠券抵扣引擎
- 满减券 / 折扣券 / 无门槛券三种类型；
- 下单自动匹配最优优惠券，支持手动切换；
- 退款自动退回优惠券，幂等设计防止重复抵扣。

### 5. 双端架构设计
- **后台管理端**：基于 RuoYi 框架，功能完整，适合运营人员使用；
- **用户门户端**：独立 Vue 3 项目，面向 C 端用户，体验更轻量化；
- 两端共享同一套后端 API，通过 JWT 统一认证。

### 6. 数据可视化看板
管理端首页集成 ECharts 数据大屏：
- 用户注册趋势折线图
- 订单量 / 交易额柱状图
- 热门设备分类饼图
- 实时活跃用户数

---

## 项目结构

```
.
├── ruoyi-admin/                # 后台主服务
│   ├── src/main/java/com/ruoyi/
│   │   ├── controller/          # Controller 层
│   │   └── RuoYiApplication.java
│   └── src/main/resources/
│       ├── application.yml       # 主配置
│       └── application-druid.yml # 数据源配置
├── ruoyi-common/               # 通用工具模块
│   └── src/main/java/com/ruoyi/common/
│       ├── core/               # 核心类（统一返回体、异常）
│       ├── annotation/           # 自定义注解
│       ├── utils/               # 工具类
│       └── enums/              # 枚举定义
├── ruoyi-framework/            # 框架核心模块
│   └── src/main/java/com/ruoyi/framework/
│       ├── config/             # 配置类
│       ├── security/          # 安全 / JWT / 拦截器
│       └── aspectj/            # AOP 切面（权限校验）
├── ruoyi-system/               # 业务模块
│   └── src/main/java/com/ruoyi/
│       ├── rental/            # 租赁业务核心
│       │   ├── domain/         # 实体类
│       │   ├── mapper/         # Mapper 接口
│       │   └── service/         # 业务逻辑
│       └── system/             # 系统管理业务
├── ruoyi-generator/            # 代码生成器
├── ruoyi-quartz/               # 定时任务模块
├── ruoyi-ui/                   # 后台管理前端（Vue 3 + Element Plus）
│   └── src/
│       ├── api/                # 接口请求
│       ├── views/              # 页面视图
│       ├── components/          # 通用组件
│       └── router/             # 路由配置
├── vue-portal/                 # 用户门户前端（Vue 3）
│   └── src/
│       ├── api/                # 接口请求
│       ├── views/              # 页面视图
│       ├── stores/              # Pinia 状态管理
│       └── router/             # 路由配置
├── sql/                        # 数据库脚本
│   └── rent.sql                # 建表 + 演示数据
├── pom.xml                     # Maven 父级依赖
└── README.md
```

---

## 说明与声明

本项目为 **温州商学院本科毕业设计**，用于学习与技术交流，作者保留著作权；

项目中的品牌标识、图片素材等第三方资源 不随仓库分发，如需本地演示请自行放置；

演示账号与演示数据仅用于本地功能验证，部署到公网前请务必删除或修改。

---

**License**
MIT
