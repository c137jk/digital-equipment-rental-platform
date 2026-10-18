# 部署指南

## 开发环境部署

### 前置要求
- JDK 1.8+
- MySQL 5.7+
- Redis 3.0+
- Node.js 20.19.0+
- Maven 3.6+

### 步骤1: 数据库部署
```bash
# 1. 创建数据库（默认库名 rent，需与 application-druid.yml 保持一致）
mysql -u root -p
CREATE DATABASE rent DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
exit;

# 2. 导入表结构与演示数据
#    rent.sql 已包含租赁业务表、若依基础表与菜单权限数据，一次导入即可
cd sql
mysql -u root -p rent < rent.sql
```

### 步骤2: 后端部署
```bash
# 1. 修改数据库配置
# 编辑 ruoyi-admin/src/main/resources/application-druid.yml
# 修改 username 和 password

# 2. 启动Redis
redis-server

# 3. 编译项目
mvn clean install

# 4. 启动后端
cd ruoyi-admin
mvn spring-boot:run

# 验证: 访问 http://localhost:8080
```

### 步骤3: 用户端部署
```bash
cd vue-portal

# 1. 安装依赖
npm install

# 2. 启动开发服务器
npm run dev

# 访问: http://localhost:25642
```

### 步骤4: 管理端部署
```bash
cd ruoyi-ui

# 1. 安装依赖
npm install

# 2. 启动开发服务器
npm run dev

# 访问: http://localhost:80
# 登录: admin / admin123
```

---

## 生产环境部署

### 后端生产部署

#### 方式1: JAR包部署
```bash
# 1. 打包
mvn clean package -Dmaven.test.skip=true

# 2. 运行
cd ruoyi-admin/target
java -jar ruoyi-admin.jar

# 3. 后台运行
nohup java -jar ruoyi-admin.jar > server.log 2>&1 &
```

#### 方式2: Docker部署
```dockerfile
# Dockerfile
FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY ruoyi-admin/target/ruoyi-admin.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

# 构建镜像
docker build -t rental-backend .

# 运行容器
docker run -d -p 8080:8080 --name rental-backend rental-backend
```

### 前端生产部署

#### 用户端
```bash
cd vue-portal

# 1. 构建
npm run build

# 2. 部署到Nginx
# 将 dist 目录内容复制到 /usr/share/nginx/html/portal
```

#### 管理端
```bash
cd ruoyi-ui

# 1. 构建
npm run build:prod

# 2. 部署到Nginx
# 将 dist 目录内容复制到 /usr/share/nginx/html/admin
```

### Nginx配置示例
```nginx
# 用户端
server {
    listen 80;
    server_name portal.example.com;
    
    location / {
        root /usr/share/nginx/html/portal;
        try_files $uri $uri/ /index.html;
    }
    
    location /dev-api/ {
        proxy_pass http://localhost:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}

# 管理端
server {
    listen 80;
    server_name admin.example.com;
    
    location / {
        root /usr/share/nginx/html/admin;
        try_files $uri $uri/ /index.html;
    }
    
    location /prod-api/ {
        proxy_pass http://localhost:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

---

## 性能优化

### 后端优化
1. **Redis缓存**: 缓存热点数据
2. **数据库索引**: 已创建必要索引
3. **连接池**: 使用Druid连接池
4. **异步处理**: 使用@Async处理耗时操作

### 前端优化
1. **路由懒加载**: 已实现
2. **代码分割**: Vite自动处理
3. **Gzip压缩**: Nginx配置
4. **CDN加速**: 静态资源使用CDN

---

## 安全配置

### 1. 修改默认密码
```sql
-- 修改admin密码
UPDATE sys_user SET password = '$2a$10$新的加密密码' WHERE user_name = 'admin';
```

### 2. 配置HTTPS
```nginx
server {
    listen 443 ssl;
    server_name example.com;
    
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    
    # 其他配置...
}
```

### 3. 防火墙配置
```bash
# 只开放必要端口
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable
```

---

## 监控与维护

### 日志查看
```bash
# 后端日志
tail -f ruoyi-admin/logs/sys-info.log

# Nginx日志
tail -f /var/log/nginx/access.log
```

### 数据库备份
```bash
# 备份
mysqldump -u root -p ry > backup_$(date +%Y%m%d).sql

# 恢复
mysql -u root -p ry < backup_20260103.sql
```

---

## 故障排查

### 后端无法启动
1. 检查MySQL是否运行
2. 检查Redis是否运行
3. 检查端口8080是否被占用
4. 查看日志文件

### 前端无法访问
1. 检查后端API是否正常
2. 检查Nginx配置
3. 查看浏览器控制台错误
4. 检查代理配置

### 数据库连接失败
1. 检查数据库配置
2. 检查防火墙设置
3. 验证用户名密码
4. 检查数据库是否启动

---

## 常见问题

**Q: 前端请求跨域?**  
A: 开发环境使用Vite代理,生产环境使用Nginx反向代理

**Q: 图片无法上传?**  
A: 配置文件上传路径,确保目录有写权限

**Q: Redis连接失败?**  
A: 检查Redis是否启动,配置是否正确

**Q: 权限不足?**  
A: 检查用户角色权限配置,确保菜单SQL已执行

