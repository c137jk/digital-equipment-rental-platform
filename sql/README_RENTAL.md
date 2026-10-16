# 数据库执行说明

## 数据库配置

根据 `application.yml` 配置,若依框架使用的数据库配置在 `application-druid.yml` 中。

## 执行SQL脚本

### 方式一: 使用MySQL客户端工具

1. 打开MySQL客户端(Navicat/MySQL Workbench/phpMyAdmin等)
2. 连接到若依数据库(通常是 `ry` 或 `ry-vue`)
3. 打开 `sql/rental_system.sql` 文件
4. 执行整个SQL脚本

### 方式二: 使用命令行

```bash
# 进入sql目录
cd e:\RuoYi-Vue-master\sql

# 执行SQL脚本(请根据实际情况修改数据库名、用户名和密码)
mysql -u root -p ry < rental_system.sql
