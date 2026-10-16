/*
 Navicat Premium Dump SQL

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80405 (8.4.5)
 Source Host           : localhost:3306
 Source Schema         : rent

 Target Server Type    : MySQL
 Target Server Version : 80405 (8.4.5)
 File Encoding         : 65001

 Date: 02/04/2026 21:04:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for rental_cart
-- ----------------------------
DROP TABLE IF EXISTS `rental_cart`;
CREATE TABLE `rental_cart`  (
  `cart_id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `equipment_id` bigint NOT NULL COMMENT '设备ID',
  `quantity` int NULL DEFAULT 1 COMMENT '数量',
  `rental_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '租赁类型（1日租 2周租 3月租）',
  `rental_days` int NULL DEFAULT 1 COMMENT '租赁天数',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `selected_specs` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已选规格',
  PRIMARY KEY (`cart_id`) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_equipment`(`equipment_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rental_cart
-- ----------------------------
INSERT INTO `rental_cart` VALUES (2, 101, 1, 1, '1', 5, '2026-01-15 18:33:38', NULL, NULL);
INSERT INTO `rental_cart` VALUES (21, 100, 17, 1, '1', 1, '2026-03-17 12:15:05', NULL, NULL);
INSERT INTO `rental_cart` VALUES (22, 100, 17, 1, '1', 1, '2026-03-17 12:19:11', NULL, NULL);

-- ----------------------------
-- Table structure for rental_category
-- ----------------------------
DROP TABLE IF EXISTS `rental_category`;
CREATE TABLE `rental_category`  (
  `category_id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父分类ID',
  `category_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '分类名称',
  `category_icon` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '分类图标',
  `sort_order` int NULL DEFAULT 0 COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '设备分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rental_category
-- ----------------------------
INSERT INTO `rental_category` VALUES (1, 0, '电脑设备', 'computer', 1, '0', '1', 'admin', '2025-12-31 19:19:01', '', NULL, '电脑相关设备');
INSERT INTO `rental_category` VALUES (2, 1, '笔记本电脑', 'laptop', 1, '0', '1', 'admin', '2025-12-31 19:19:01', '', NULL, '笔记本电脑');
INSERT INTO `rental_category` VALUES (3, 1, '台式电脑', 'desktop', 2, '0', '1', 'admin', '2025-12-31 19:19:01', '', NULL, '台式电脑');
INSERT INTO `rental_category` VALUES (4, 0, '摄影设备', 'camera', 2, '0', '0', 'admin', '2025-12-31 19:19:01', '', NULL, '摄影摄像设备');
INSERT INTO `rental_category` VALUES (5, 4, '单反相机', 'dslr', 1, '0', '0', 'admin', '2025-12-31 19:19:01', '', NULL, '单反相机');
INSERT INTO `rental_category` VALUES (6, 4, '摄像机', 'video', 2, '0', '0', 'admin', '2025-12-31 19:19:01', '', NULL, '摄像机');
INSERT INTO `rental_category` VALUES (7, 0, '办公设备', 'office', 3, '0', '0', 'admin', '2025-12-31 19:19:01', '', NULL, '办公设备');
INSERT INTO `rental_category` VALUES (8, 7, '投影仪', 'projector', 1, '0', '0', 'admin', '2025-12-31 19:19:01', '', NULL, '投影仪');
INSERT INTO `rental_category` VALUES (9, 0, '游戏设备', 'game', 4, '0', '0', 'admin', '2025-12-31 19:19:01', '', NULL, '游戏设备');
INSERT INTO `rental_category` VALUES (10, 9, '游戏主机', 'console', 1, '0', '0', 'admin', '2025-12-31 19:19:01', '', NULL, '游戏主机');
INSERT INTO `rental_category` VALUES (11, 0, '测试', NULL, 0, '0', '1', '', '2026-03-08 21:11:47', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (12, 9, '游戏手柄', NULL, 0, '0', '0', '', '2026-03-08 21:15:29', '', '2026-03-08 21:35:37', NULL);
INSERT INTO `rental_category` VALUES (13, 0, '便携设备', NULL, 0, '0', '0', '', '2026-03-08 21:16:43', '', '2026-03-08 21:29:38', NULL);
INSERT INTO `rental_category` VALUES (14, 0, '平板', NULL, 0, '0', '1', '', '2026-03-08 21:17:14', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (15, 0, '笔记本', NULL, 0, '0', '1', '', '2026-03-08 21:17:46', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (16, 13, '11111', NULL, 0, '0', '1', '', '2026-03-08 21:27:45', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (17, 13, '手机', NULL, 0, '0', '0', '', '2026-03-08 21:29:57', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (18, 13, '平板', NULL, 0, '0', '0', '', '2026-03-08 21:30:04', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (19, 0, '穿戴设备', NULL, 0, '0', '0', '', '2026-03-08 21:30:21', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (20, 19, '手表', NULL, 0, '0', '0', '', '2026-03-08 21:30:38', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (21, 0, '电脑', NULL, 0, '0', '0', '', '2026-03-08 21:32:29', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (22, 21, '笔记本', NULL, 0, '0', '0', '', '2026-03-08 21:32:51', '', '2026-03-08 21:34:14', NULL);
INSERT INTO `rental_category` VALUES (23, 21, '台式机', NULL, 0, '0', '0', '', '2026-03-08 21:33:47', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (24, 9, '游戏掌机', NULL, 0, '0', '0', '', '2026-03-08 21:34:59', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (25, 4, '无人机', NULL, 0, '0', '0', '', '2026-03-08 21:36:49', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (26, 4, '运动相机', NULL, 0, '0', '0', '', '2026-03-08 21:37:02', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (27, 4, '全景相机', NULL, 0, '0', '0', '', '2026-03-08 21:37:14', '', NULL, NULL);
INSERT INTO `rental_category` VALUES (28, 4, '云台相机', NULL, 0, '0', '0', '', '2026-03-08 21:37:25', '', NULL, NULL);

-- ----------------------------
-- Table structure for rental_coupon
-- ----------------------------
DROP TABLE IF EXISTS `rental_coupon`;
CREATE TABLE `rental_coupon`  (
  `coupon_id` bigint NOT NULL AUTO_INCREMENT COMMENT '优惠券ID',
  `coupon_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '优惠码',
  `coupon_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '优惠券名称',
  `discount_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1' COMMENT '折扣类型(1百分比折扣 2固定金额)',
  `discount_value` decimal(10, 2) NOT NULL COMMENT '折扣值(百分比如0.8代表8折,固定金额如50)',
  `min_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '最低消费金额',
  `use_count` int NULL DEFAULT 0 COMMENT '已使用次数',
  `max_use` int NULL DEFAULT -1 COMMENT '最大使用次数(-1无限制)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0启用 1禁用)',
  `start_time` datetime NULL DEFAULT NULL COMMENT '生效开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '生效结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`coupon_id`) USING BTREE,
  UNIQUE INDEX `idx_coupon_code`(`coupon_code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '优惠券表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rental_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for rental_equipment
-- ----------------------------
DROP TABLE IF EXISTS `rental_equipment`;
CREATE TABLE `rental_equipment`  (
  `equipment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `equipment_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '设备名称',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `brand` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '品牌',
  `model` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '型号',
  `specifications` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '配置参数(JSON格式)',
  `main_image` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '主图片',
  `images` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '图片列表(JSON数组)',
  `daily_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '日租价格',
  `weekly_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '周租价格',
  `monthly_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '月租价格',
  `deposit` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '押金金额',
  `stock` int NULL DEFAULT 0 COMMENT '库存数量',
  `rented_count` int NULL DEFAULT 0 COMMENT '已租数量',
  `total_rented` int NULL DEFAULT 0 COMMENT '累计租赁次数',
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '设备描述',
  `rental_notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '租赁说明',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1下架 2维修中）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`equipment_id`) USING BTREE,
  INDEX `idx_category`(`category_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '设备表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rental_equipment
-- ----------------------------
INSERT INTO `rental_equipment` VALUES (1, 'MacBook Pro 16英寸 2023款', 2, 'Apple', 'M3 Pro', '{\"cpu\":\"M3 Pro芯片\",\"memory\":\"32GB\",\"storage\":\"1TB SSD\",\"display\":\"16.2英寸 Liquid Retina XDR\"}', '/profile/upload/2026/01/15/1_20260115182949A001.jpg', '[\"/images/macbook-1.jpg\",\"/images/macbook-2.jpg\"]', 200.00, 1200.00, 4500.00, 8000.00, 3, 2, 0, '全新MacBook Pro，性能强劲，适合专业设计和开发工作', '1. 请妥善保管设备\n2. 禁止私自拆卸\n3. 如有损坏需照价赔偿', '0', '0', 'admin', '2025-12-31 19:19:01', '', '2026-01-15 19:33:05', NULL);
INSERT INTO `rental_equipment` VALUES (2, 'Dell XPS 15', 2, 'Dell', 'XPS 15 9530', '{\"cpu\":\"Intel i7-13700H\",\"memory\":\"16GB\",\"storage\":\"512GB SSD\",\"display\":\"15.6英寸 4K OLED\"}', '/profile/upload/2026/01/15/2_20260115183022A002.jpg', '[\"/images/dell-1.jpg\",\"/images/dell-2.jpg\"]', 150.00, 900.00, 3200.00, 6000.00, 8, 0, 0, '高性能商务本，4K OLED屏幕，色彩还原出色', '租赁期间请注意防水防摔', '0', '0', 'admin', '2025-12-31 19:19:01', '', '2026-01-15 18:30:23', NULL);
INSERT INTO `rental_equipment` VALUES (3, 'Canon EOS R5', 5, 'Canon', 'EOS R5', '{\"sensor\":\"全画幅 45MP\",\"video\":\"8K 30fps\",\"iso\":\"100-51200\",\"stabilization\":\"机身5轴防抖\"}', '/profile/upload/2026/01/15/3_20260115183106A003.jpg', '[\"/images/canon-1.jpg\",\"/images/canon-2.jpg\"]', 30.00, 180.00, 650.00, 15000.00, 3, 0, 0, '专业级全画幅微单相机，支持8K视频拍摄', '请配合使用原装电池和存储卡', '0', '0', 'admin', '2025-12-31 19:19:01', '', '2026-03-15 00:56:49', NULL);
INSERT INTO `rental_equipment` VALUES (4, 'Sony A7M4', 5, 'Sony', 'A7 Mark IV', '{\"sensor\":\"全画幅 33MP\",\"video\":\"4K 60fps\",\"iso\":\"100-51200\",\"stabilization\":\"机身5轴防抖\"}', '/profile/upload/2026/01/15/4_20260115183135A004.jpg', '[\"/images/sony-1.jpg\",\"/images/sony-2.jpg\"]', 25.00, 150.00, 550.00, 12000.00, 4, 0, 0, '索尼全画幅微单，视频拍摄性能优秀', '镜头需单独租赁', '0', '0', 'admin', '2025-12-31 19:19:01', '', '2026-03-15 00:56:38', NULL);
INSERT INTO `rental_equipment` VALUES (5, 'Epson投影仪 EB-2250U', 8, 'Epson', 'EB-2250U', '{\"brightness\":\"5000流明\",\"resolution\":\"1920x1200\",\"contrast\":\"15000:1\",\"lamp_life\":\"10000小时\"}', '/profile/upload/2026/01/15/5_20260115183226A005.jpg', '[\"/images/epson-1.jpg\"]', 32.00, 210.00, 900.00, 3000.00, 10, 0, 0, '商务投影仪，高亮度，适合会议室使用', '包含HDMI线和遥控器', '0', '0', 'admin', '2025-12-31 19:19:01', '', '2026-03-15 00:56:24', NULL);
INSERT INTO `rental_equipment` VALUES (6, '华为Mate 80', 17, '华为', 'Mate 80', NULL, '/profile/upload/2026/03/14/华为_20260314200923A001.jpg', NULL, 13.00, 14.00, 500.00, 1000.00, 7, 0, 0, '华为', NULL, '0', '0', '', '2026-03-14 20:09:26', '', NULL, NULL);
INSERT INTO `rental_equipment` VALUES (7, 'iQOO 15 Ultra', 17, 'iQOO', '15 Ultra', NULL, '/profile/upload/2026/03/14/iQOO 15 Ultra_20260314203501A002.jpg', NULL, 9.20, 60.00, 270.00, 3000.00, 3, 0, 0, 'CPU型号	骁龙 8 Elite Gen5更多骁龙 8 \nCPU频率	2×Prime 4.6GHz+6×Performance 3.62GHz\nCPU核心数	八核\nGPU型号	高通 Adreno 840\nRAM容量	16GB\nRAM存储类型	LPDDR5X Ultra Pro 四通道\nROM容量	256GB>5.2万张照片2.2万首歌曲\nROM存储类型	UFS 4.1\n存储卡	不支持容量扩展\n出厂系统内核	Android 16\n操作系统	OriginOS 6\n散热	冰穹风冷散热系统+8K冰穹VC\n振动马达	战锤MAX双轴马达\n扬声器	立体声双扬声器\n其他硬件参数	独立显示芯片：自研电竞芯片 Q3，支持16GB内存融合', NULL, '0', '0', '', '2026-03-14 20:35:02', '', '2026-03-15 00:48:07', NULL);
INSERT INTO `rental_equipment` VALUES (8, 'OPPO Find X9 Pro', 17, 'OPPO', 'Find X9 Pro', NULL, '/profile/upload/2026/03/14/OPPO Find X9 Pro_20260314204501A003.jpg', NULL, 11.61, 77.00, 300.00, 6000.00, 5, 0, 0, 'OPPO Find X9 Pro', NULL, '0', '0', '', '2026-03-14 20:45:03', '', '2026-03-15 00:46:33', NULL);
INSERT INTO `rental_equipment` VALUES (9, 'iPhone 17 Pro Max', 17, 'iPhone', '17 Pro Max', NULL, '/profile/upload/2026/03/14/iPhone 17 Pro Max_20260314204704A004.jpg', NULL, 21.92, 140.00, 600.00, 9000.00, 4, 0, 0, 'iPhone 17 Pro Max', NULL, '0', '0', '', '2026-03-14 20:47:07', '', '2026-03-15 00:46:06', NULL);
INSERT INTO `rental_equipment` VALUES (10, 'Redmi Turbo 5 MAX', 17, 'Redmi', 'Turbo 5 MAX', NULL, '/profile/upload/2026/03/14/Redmi Turbo 5 MAX_20260314204831A005.jpg', NULL, 5.48, 35.00, 150.00, 3000.00, 3, 0, 0, 'Redmi Turbo 5 MAX', NULL, '0', '0', '', '2026-03-14 20:48:42', '', '2026-03-15 00:45:31', NULL);
INSERT INTO `rental_equipment` VALUES (11, '荣耀Power2', 17, '荣耀', 'Power2', NULL, '/profile/upload/2026/03/14/荣耀Power2_20260314205000A006.jpg', NULL, 5.92, 40.00, 150.00, 3000.00, 5, 0, 0, '荣耀Power2', NULL, '0', '0', '', '2026-03-14 20:50:06', '', '2026-03-15 00:44:47', NULL);
INSERT INTO `rental_equipment` VALUES (12, 'iPhone Watch Series 11', 20, 'iPhone', 'Watch Series 11', NULL, '/profile/upload/2026/03/14/苹果Watch Series 11_20260314205331A007.jpg', NULL, 4.60, 28.00, 120.00, 2000.00, 2, 0, 0, 'Watch Series 11', NULL, '0', '0', '', '2026-03-14 20:53:34', '', '2026-03-15 00:46:58', NULL);
INSERT INTO `rental_equipment` VALUES (13, ' 联想拯救者R9000P 2025 AI元启', 22, ' 联想', '拯救者R9000P 2025 AI元启', NULL, '/profile/upload/2026/03/14/联想拯救者R9000P 2025 AI元启_20260314205558A008.jpg', NULL, 43.48, 280.00, 1200.00, 8000.00, 2, 0, 0, ' 联想拯救者R9000P 2025 AI元启', NULL, '0', '0', '', '2026-03-14 20:56:03', '', '2026-03-15 00:44:02', NULL);
INSERT INTO `rental_equipment` VALUES (14, '索尼PS5 PlayStation DualSense无线游戏手柄', 12, '索尼', 'PS5 PlayStation DualSense无线游戏手柄', NULL, '/profile/upload/2026/03/14/索尼PS5 PlayStation DualSense无线游戏手柄_20260314205839A009.jpg', NULL, 5.75, 35.00, 150.00, 3000.00, 5, 0, 0, '索尼PS5 PlayStation DualSense无线游戏手柄', NULL, '0', '0', '', '2026-03-14 20:58:40', '', '2026-03-15 00:43:30', NULL);
INSERT INTO `rental_equipment` VALUES (15, '北通阿修罗2无线游戏手柄', 12, '北通', '阿修罗2无线游戏手柄', NULL, '/profile/upload/2026/03/14/北通阿修罗2无线游戏手柄_20260314210131A010.jpg', NULL, 1.40, 7.00, 30.00, 200.00, 3, 0, 0, '北通阿修罗2无线游戏手柄', NULL, '0', '0', '', '2026-03-14 21:02:03', '', '2026-03-15 00:47:30', NULL);
INSERT INTO `rental_equipment` VALUES (16, '任天堂Switch 2', 24, '任天堂', 'Switch 2', NULL, '/profile/upload/2026/03/14/任天堂Switch 2_20260314210501A011.jpg', NULL, 12.33, 84.00, 360.00, 3000.00, 1, 0, 0, '任天堂Switch 2', NULL, '0', '0', '', '2026-03-14 21:05:03', '', '2026-03-15 00:42:24', NULL);
INSERT INTO `rental_equipment` VALUES (17, '华为MatePad Mini', 18, '华为', 'MatePad Mini', NULL, '/profile/upload/2026/03/15/华为MatePad Mini_20260315001915A001.jpg', NULL, 8.76, 56.00, 240.00, 3000.00, 4, 1, 0, '华为MatePad Mini', NULL, '0', '0', '', '2026-03-15 00:19:33', '', '2026-03-15 00:41:53', NULL);

-- ----------------------------
-- Table structure for rental_favorite
-- ----------------------------
DROP TABLE IF EXISTS `rental_favorite`;
CREATE TABLE `rental_favorite`  (
  `favorite_id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `equipment_id` bigint NOT NULL COMMENT '设备ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`favorite_id`) USING BTREE,
  UNIQUE INDEX `uk_user_equipment`(`user_id` ASC, `equipment_id` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_equipment`(`equipment_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rental_favorite
-- ----------------------------
INSERT INTO `rental_favorite` VALUES (1, 100, 1, '2026-01-03 17:05:42');
INSERT INTO `rental_favorite` VALUES (2, 101, 1, '2026-01-15 18:33:37');
INSERT INTO `rental_favorite` VALUES (3, 102, 1, '2026-01-15 19:31:05');
INSERT INTO `rental_favorite` VALUES (4, 103, 1, '2026-01-15 20:16:08');
INSERT INTO `rental_favorite` VALUES (5, 104, 1, '2026-01-15 20:21:56');
INSERT INTO `rental_favorite` VALUES (6, 105, 1, '2026-01-15 21:10:31');
INSERT INTO `rental_favorite` VALUES (7, 105, 2, '2026-01-15 21:12:33');
INSERT INTO `rental_favorite` VALUES (8, 106, 1, '2026-01-16 11:32:11');
INSERT INTO `rental_favorite` VALUES (9, 108, 1, '2026-01-16 11:40:49');

-- ----------------------------
-- Table structure for rental_message
-- ----------------------------
DROP TABLE IF EXISTS `rental_message`;
CREATE TABLE `rental_message`  (
  `message_id` bigint NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息标题',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '消息内容',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'system' COMMENT '消息类型(order/system)',
  `is_read` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '是否已读(0未读 1已读)',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`message_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息通知表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rental_message
-- ----------------------------
INSERT INTO `rental_message` VALUES (1, 100, '支付成功', '您的订单 ROef0d2599bacd44b5a74467dd6132f68c 已支付成功，请等待发货。', 'order', '1', '2026-03-07 17:18:21');
INSERT INTO `rental_message` VALUES (2, 100, '发货通知', '您的订单 ROef0d2599bacd44b5a74467dd6132f68c 已发货，设备已进入租赁中状态。', 'order', '0', '2026-03-09 02:20:17');
INSERT INTO `rental_message` VALUES (3, 103, '发货通知', '您的订单 RO5dd7b66052eb4372b1882f70cad0e9f4 已发货，设备已进入租赁中状态。', 'order', '1', '2026-03-09 02:20:19');
INSERT INTO `rental_message` VALUES (4, 100, '支付成功', '您的订单 RO65585b7a2dba481786861d45d6685b53 已支付成功，请等待发货。', 'order', '0', '2026-03-15 11:05:55');
INSERT INTO `rental_message` VALUES (5, 100, '发货通知', '您的订单 RO65585b7a2dba481786861d45d6685b53 已发货，设备已进入租赁中状态。', 'order', '0', '2026-03-15 11:06:12');
INSERT INTO `rental_message` VALUES (6, 100, '归还确认', '您的订单 RO65585b7a2dba481786861d45d6685b53 已确认归还，押金¥3000.00已退还。', 'order', '0', '2026-03-15 11:06:30');
INSERT INTO `rental_message` VALUES (7, 100, '支付成功', '您的订单 ROd92a803181af4fe785d80d3273857741 已支付成功，请等待发货。', 'order', '0', '2026-03-17 12:15:33');
INSERT INTO `rental_message` VALUES (8, 100, '发货通知', '您的订单 ROd92a803181af4fe785d80d3273857741 已发货，设备已进入租赁中状态。', 'order', '0', '2026-03-17 12:15:51');

-- ----------------------------
-- Table structure for rental_order
-- ----------------------------
DROP TABLE IF EXISTS `rental_order`;
CREATE TABLE `rental_order`  (
  `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `equipment_id` bigint NOT NULL COMMENT '设备ID',
  `equipment_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '设备名称',
  `quantity` int NULL DEFAULT 1 COMMENT '租赁数量',
  `rental_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '租赁类型（1日租 2周租 3月租）',
  `rental_days` int NULL DEFAULT 1 COMMENT '租赁天数',
  `start_time` datetime NULL DEFAULT NULL COMMENT '租赁开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '租赁结束时间',
  `unit_price` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '租赁单价',
  `rental_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '租赁金额',
  `deposit_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '押金金额',
  `total_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '订单总金额',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '订单状态（0待支付 1已支付 2租赁中 3已归还 4已取消 5已退款）',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `return_time` datetime NULL DEFAULT NULL COMMENT '归还时间',
  `actual_return_time` datetime NULL DEFAULT NULL COMMENT '实际归还时间',
  `is_overdue` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '是否逾期（0否 1是）',
  `overdue_days` int NULL DEFAULT 0 COMMENT '逾期天数',
  `overdue_fee` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '逾期费用',
  `refund_deposit` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '退还押金',
  `deduct_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '扣除金额',
  `deduct_reason` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '扣除原因',
  `user_remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户备注',
  `admin_remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '管理员备注',
  `coupon_code` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '使用的优惠码',
  `discount_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠金额',
  `extend_days` int NULL DEFAULT NULL COMMENT '延期天数',
  `extend_status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '延期状态(0待审批 1已批准 2已拒绝)',
  `extend_fee` decimal(10, 2) NULL DEFAULT NULL COMMENT '延期费用',
  `is_damaged` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '是否损坏(0正常 1损坏)',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0存在 2删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `receiver_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '收货人姓名',
  `receiver_phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '收货人电话',
  `receiver_address` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '收货地址',
  `return_express_no` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '归还快递单号',
  `return_express_company` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '归还快递公司',
  `return_apply_time` datetime NULL DEFAULT NULL COMMENT '申请归还时间',
  `selected_specs` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '已选规格',
  PRIMARY KEY (`order_id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_equipment`(`equipment_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rental_order
-- ----------------------------
INSERT INTO `rental_order` VALUES (1, 'ROe2898b903cfd43fc9375532f53f12994', 100, 2, 'Dell XPS 15', 1, '1', 1, NULL, NULL, 150.00, 150.00, 6000.00, 6150.00, '4', '2026-01-14 16:23:18', NULL, '2026-01-14 16:33:58', '0', 0, 0.00, 6000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '123456', '2026-01-14 16:23:05', '', '2026-01-14 16:33:57', '1', '13616542222', '1313131313131', '13213213213123232', '中通快递', '2026-01-14 16:33:50', NULL);
INSERT INTO `rental_order` VALUES (2, 'RO66f0892197214feba50f77f6809a7415', 102, 1, 'MacBook Pro 16英寸 2023款', 1, '1', 1, NULL, NULL, 200.00, 200.00, 8000.00, 8200.00, '4', '2026-01-15 19:31:54', NULL, '2026-01-15 19:32:20', '0', 0, 0.00, 8000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '1234567', '2026-01-15 19:31:45', '', '2026-01-15 19:32:20', '12345', '13616545444', 'sadasdasdasdsad', '', '', NULL, NULL);
INSERT INTO `rental_order` VALUES (3, 'RO373acc74eae648c391f5d51f299fdc74', 102, 2, 'Dell XPS 15', 1, '1', 1, NULL, NULL, 150.00, 150.00, 6000.00, 6150.00, '4', '2026-01-15 19:34:56', NULL, '2026-01-15 19:35:18', '0', 0, 0.00, 6000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '1234567', '2026-01-15 19:34:53', '', '2026-01-15 19:35:18', '23123', '13616555555', '123313131232132', '', '', NULL, NULL);
INSERT INTO `rental_order` VALUES (4, 'RO3b55cf553178435db8221885bc2f388a', 100, 1, 'MacBook Pro 16英寸 2023款', 1, '1', 1, NULL, NULL, 200.00, 200.00, 8000.00, 8200.00, '4', '2026-01-15 19:46:11', NULL, '2026-01-15 19:47:01', '0', 0, 0.00, 8000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '123456', '2026-01-15 19:46:08', '', '2026-01-15 19:47:01', '123', '13515144444', '12321312312', '2132131313123213213123', '顺丰速运', '2026-01-15 19:46:54', NULL);
INSERT INTO `rental_order` VALUES (5, 'ROe9a5e0b660d44882b4191e542a1cc116', 100, 1, 'MacBook Pro 16英寸 2023款', 1, '1', 1, NULL, NULL, 200.00, 200.00, 8000.00, 8200.00, '4', '2026-01-15 20:09:26', NULL, '2026-01-15 20:11:39', '0', 0, 0.00, 8000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '123456', '2026-01-15 20:09:17', '', '2026-01-15 20:11:39', '123', '15220222222', '12312312312321312', '1233131312312', '顺丰速运', '2026-01-15 20:11:25', NULL);
INSERT INTO `rental_order` VALUES (6, 'RO9563d0f44ece479aa96ed73ea52dc1b9', 103, 1, 'MacBook Pro 16英寸 2023款', 1, '1', 1, NULL, NULL, 200.00, 200.00, 8000.00, 8200.00, '4', '2026-01-15 20:16:42', NULL, '2026-01-15 20:17:27', '0', 0, 0.00, 8000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '12345', '2026-01-15 20:16:37', '', '2026-01-15 20:17:27', '啊实打实', '13515444444', '12421sdgsdg', '2343423423423432', '圆通速递', '2026-01-15 20:17:13', NULL);
INSERT INTO `rental_order` VALUES (7, 'RO7c41fb228b8b41359d9da10f68455e37', 104, 1, 'MacBook Pro 16英寸 2023款', 1, '1', 1, NULL, NULL, 200.00, 200.00, 8000.00, 8200.00, '4', '2026-01-15 20:22:33', NULL, '2026-01-15 20:23:00', '0', 0, 0.00, 8000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '112233', '2026-01-15 20:22:29', '', '2026-01-15 20:23:00', '请问请问', '13451555555', '啊发发发去噶士大夫士大夫山豆根', '1232131312312312', '圆通速递', '2026-01-15 20:22:53', NULL);
INSERT INTO `rental_order` VALUES (8, 'RO550280cf965141bbba1461d64308073f', 105, 1, 'MacBook Pro 16英寸 2023款', 1, '1', 1, NULL, NULL, 200.00, 200.00, 8000.00, 8200.00, '4', '2026-01-15 21:11:01', NULL, '2026-01-15 21:11:26', '0', 0, 0.00, 8000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '111111', '2026-01-15 21:10:58', '', '2026-01-15 21:11:26', '45645', '14515151555', '1dfdfg897979', '67686867867876', '顺丰速运', '2026-01-15 21:11:19', NULL);
INSERT INTO `rental_order` VALUES (9, 'ROd1e4d5dd1a2b4c7780a91806680d0f3e', 106, 1, 'MacBook Pro 16英寸 2023款', 1, '1', 1, NULL, NULL, 200.00, 200.00, 8000.00, 8200.00, '4', '2026-01-16 11:32:47', NULL, '2026-01-16 11:33:22', '0', 0, 0.00, 8000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '11112222', '2026-01-16 11:32:42', '', '2026-01-16 11:33:21', '大飒飒的', '13616555555', '阿三大苏打撒旦反对犯得上', '12313123123123123', '中通快递', '2026-01-16 11:33:12', NULL);
INSERT INTO `rental_order` VALUES (10, 'RO067ff491b52b4b4da07fc55575f97b0a', 108, 3, 'Canon EOS R5', 1, '1', 1, NULL, NULL, 300.00, 300.00, 15000.00, 15300.00, '4', '2026-01-16 11:41:23', NULL, '2026-01-16 11:41:54', '0', 0, 0.00, 15000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '33333333', '2026-01-16 11:41:15', '', '2026-01-16 11:41:54', '阿萨大大', '13515544444', '2525452452453225', '123123123123123123', '顺丰速运', '2026-01-16 11:41:46', NULL);
INSERT INTO `rental_order` VALUES (11, 'RO5dd7b66052eb4372b1882f70cad0e9f4', 103, 1, 'MacBook Pro 16英寸 2023款', 1, '1', 1, '2026-03-09 02:20:19', '2026-03-10 02:20:19', 200.00, 200.00, 8000.00, 8200.00, '2', '2026-01-30 13:20:45', NULL, NULL, '0', 0, 0.00, 0.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '12345', '2026-01-30 13:20:41', '', '2026-03-09 02:20:19', 'i企鹅舞也i', '13616545555', 'ewqhqj我去饿饿', '', '', NULL, NULL);
INSERT INTO `rental_order` VALUES (12, 'ROef0d2599bacd44b5a74467dd6132f68c', 100, 1, 'MacBook Pro 16英寸 2023款', 1, '1', 1, '2026-03-09 02:20:17', '2026-03-10 02:20:17', 200.00, 200.00, 8000.00, 8200.00, '3', '2026-03-07 17:18:22', NULL, NULL, '0', 0, 0.00, 0.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '123456', '2026-03-07 17:18:14', '', '2026-03-09 02:25:00', '111', '13666666666', '213123委屈恶趣味去', '424242424242424242', '顺丰速运', '2026-03-09 02:25:01', NULL);
INSERT INTO `rental_order` VALUES (13, 'RO65585b7a2dba481786861d45d6685b53', 100, 17, '华为MatePad Mini', 1, '1', 1, '2026-03-15 11:06:12', '2026-03-16 11:06:12', 8.76, 8.76, 3000.00, 3008.76, '4', '2026-03-15 11:05:55', NULL, '2026-03-15 11:06:31', '0', 0, 0.00, 3000.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '123456', '2026-03-15 11:05:52', '', '2026-03-15 11:06:30', '123', '14341333333', '124211414331414134', '2222222222', '顺丰速运', '2026-03-15 11:06:23', NULL);
INSERT INTO `rental_order` VALUES (14, 'ROd92a803181af4fe785d80d3273857741', 100, 17, '华为MatePad Mini', 1, '1', 1, '2026-03-17 12:15:52', '2026-03-18 12:15:52', 8.76, 8.76, 3000.00, 3008.76, '3', '2026-03-17 12:15:33', NULL, NULL, '0', 0, 0.00, 0.00, 0.00, '', '', '', NULL, NULL, NULL, NULL, NULL, '0', '0', '123456', '2026-03-17 12:15:29', '', '2026-03-17 12:16:02', '1233', '13616555555', '12413213eweqe', '12323123131231321312', '顺丰速运', '2026-03-17 12:16:03', NULL);

-- ----------------------------
-- Table structure for rental_payment
-- ----------------------------
DROP TABLE IF EXISTS `rental_payment`;
CREATE TABLE `rental_payment`  (
  `payment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '支付ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `order_no` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `payment_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '支付金额',
  `payment_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '支付类型（1租金 2押金 3逾期费）',
  `payment_method` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '支付方式（1微信 2支付宝 3银行卡）',
  `transaction_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '第三方支付单号',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '支付状态（0待支付 1已支付 2已退款）',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `refund_time` datetime NULL DEFAULT NULL COMMENT '退款时间',
  `refund_amount` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '退款金额',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`payment_id`) USING BTREE,
  INDEX `idx_order`(`order_id` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_transaction`(`transaction_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '支付记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rental_payment
-- ----------------------------

-- ----------------------------
-- Table structure for rental_review
-- ----------------------------
DROP TABLE IF EXISTS `rental_review`;
CREATE TABLE `rental_review`  (
  `review_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `nick_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `equipment_id` bigint NOT NULL COMMENT '设备ID',
  `rating` int NULL DEFAULT 5 COMMENT '评分（1-5星）',
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '评价内容',
  `images` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '评价图片(JSON数组)',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0待审核 1已通过 2未通过）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '评价时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`review_id`) USING BTREE,
  UNIQUE INDEX `uk_order`(`order_id` ASC) USING BTREE,
  INDEX `idx_equipment`(`equipment_id` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '订单评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rental_review
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-12-29 15:07:17', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-12-29 15:07:17', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-12-29 15:07:17', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-12-29 15:07:17', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2025-12-29 15:07:17', 'admin', '2026-01-15 18:15:07', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-12-29 15:07:17', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-12-29 15:07:17', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-12-29 15:07:17', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 203 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-12-29 15:07:16', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '后台', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-12-29 15:07:16', 'admin', '2026-01-15 17:56:37');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-29 15:07:16', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '总管理员', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-12-29 15:07:16', 'admin', '2026-01-15 17:57:07');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-29 15:07:16', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '管理员', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-12-29 15:07:16', 'admin', '2026-01-15 17:57:15');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-29 15:07:16', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-29 15:07:16', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-29 15:07:16', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-29 15:07:16', '', NULL);
INSERT INTO `sys_dept` VALUES (200, 100, '0,100', '用户', 2, NULL, NULL, NULL, '0', '2', 'admin', '2026-01-15 17:55:52', '', NULL);
INSERT INTO `sys_dept` VALUES (201, 100, '0,100', '前台', 4, NULL, NULL, NULL, '0', '0', 'admin', '2026-01-15 17:58:40', '', NULL);
INSERT INTO `sys_dept` VALUES (202, 201, '0,100,201', '用户', 1, NULL, NULL, NULL, '0', '0', 'admin', '2026-01-15 17:58:50', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-12-29 15:07:17', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-12-29 15:07:17', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-12-29 15:07:17', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-12-29 15:07:17', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 253 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2025-12-29 15:16:18');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-03 15:27:24');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-03 16:11:52');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-03 16:19:52');
INSERT INTO `sys_logininfor` VALUES (104, '123', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '用户不存在/密码错误', '2026-01-03 16:20:10');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-03 16:20:38');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-03 16:20:43');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '用户不存在/密码错误', '2026-01-03 16:20:55');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '用户不存在/密码错误', '2026-01-03 16:22:36');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '验证码错误', '2026-01-03 16:22:48');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '用户不存在/密码错误', '2026-01-03 16:23:03');
INSERT INTO `sys_logininfor` VALUES (111, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-03 16:24:35');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '验证码错误', '2026-01-03 16:30:55');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-03 16:30:57');
INSERT INTO `sys_logininfor` VALUES (114, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '验证码错误', '2026-01-03 16:54:02');
INSERT INTO `sys_logininfor` VALUES (115, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-03 16:54:05');
INSERT INTO `sys_logininfor` VALUES (116, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-04 08:12:10');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 14:38:52');
INSERT INTO `sys_logininfor` VALUES (118, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 14:39:31');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '验证码错误', '2026-01-14 15:15:43');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '验证码错误', '2026-01-14 15:15:43');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 15:15:46');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 15:20:05');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '验证码错误', '2026-01-14 15:22:51');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 15:22:51');
INSERT INTO `sys_logininfor` VALUES (125, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 15:25:32');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 15:30:13');
INSERT INTO `sys_logininfor` VALUES (127, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 15:58:34');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 16:21:45');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 16:25:33');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 16:46:09');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 16:55:14');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 16:59:56');
INSERT INTO `sys_logininfor` VALUES (133, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 20:56:57');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 20:57:55');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-14 22:03:01');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 17:41:33');
INSERT INTO `sys_logininfor` VALUES (137, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 18:00:31');
INSERT INTO `sys_logininfor` VALUES (138, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 18:13:05');
INSERT INTO `sys_logininfor` VALUES (139, '12345678', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '注册成功', '2026-01-15 18:18:31');
INSERT INTO `sys_logininfor` VALUES (140, '12345678', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '验证码错误', '2026-01-15 18:18:39');
INSERT INTO `sys_logininfor` VALUES (141, '12345678', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 18:18:43');
INSERT INTO `sys_logininfor` VALUES (142, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 19:24:54');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 19:28:44');
INSERT INTO `sys_logininfor` VALUES (144, '1234567', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '注册成功', '2026-01-15 19:30:01');
INSERT INTO `sys_logininfor` VALUES (145, '1234567', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 19:30:29');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 19:43:12');
INSERT INTO `sys_logininfor` VALUES (147, '123456', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '1', '验证码错误', '2026-01-15 19:45:37');
INSERT INTO `sys_logininfor` VALUES (148, '123456', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '0', '登录成功', '2026-01-15 19:45:42');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 143', 'Windows10', '0', '登录成功', '2026-01-15 19:46:38');
INSERT INTO `sys_logininfor` VALUES (150, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 19:52:44');
INSERT INTO `sys_logininfor` VALUES (151, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 20:08:43');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 20:10:42');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 20:13:38');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 20:13:46');
INSERT INTO `sys_logininfor` VALUES (155, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 20:14:01');
INSERT INTO `sys_logininfor` VALUES (156, '12345', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '注册成功', '2026-01-15 20:15:07');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 20:15:13');
INSERT INTO `sys_logininfor` VALUES (158, '12345', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 20:15:29');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 20:18:22');
INSERT INTO `sys_logininfor` VALUES (160, '12345', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 20:18:26');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 20:18:29');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 20:19:06');
INSERT INTO `sys_logininfor` VALUES (163, '112233', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '注册成功', '2026-01-15 20:21:05');
INSERT INTO `sys_logininfor` VALUES (164, '112233', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 20:21:11');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 20:21:17');
INSERT INTO `sys_logininfor` VALUES (166, '112233', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 20:42:55');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 21:05:35');
INSERT INTO `sys_logininfor` VALUES (168, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 21:05:48');
INSERT INTO `sys_logininfor` VALUES (169, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 21:06:03');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 21:06:07');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 21:07:10');
INSERT INTO `sys_logininfor` VALUES (172, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 21:07:40');
INSERT INTO `sys_logininfor` VALUES (173, '123456', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 21:08:11');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-15 21:08:15');
INSERT INTO `sys_logininfor` VALUES (175, '111111', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '注册成功', '2026-01-15 21:09:37');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 21:09:40');
INSERT INTO `sys_logininfor` VALUES (177, '111111', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-15 21:09:53');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '验证码已失效', '2026-01-16 11:31:00');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-16 11:31:02');
INSERT INTO `sys_logininfor` VALUES (180, '11112222', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '注册成功', '2026-01-16 11:31:25');
INSERT INTO `sys_logininfor` VALUES (181, '11112222', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-16 11:31:40');
INSERT INTO `sys_logininfor` VALUES (182, '11112222', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-16 11:34:34');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-16 11:36:53');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-16 11:37:36');
INSERT INTO `sys_logininfor` VALUES (185, '22222222', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '注册成功', '2026-01-16 11:37:50');
INSERT INTO `sys_logininfor` VALUES (186, '22222222', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-16 11:38:10');
INSERT INTO `sys_logininfor` VALUES (187, '22222222', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-16 11:38:55');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '退出成功', '2026-01-16 11:39:00');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-16 11:39:32');
INSERT INTO `sys_logininfor` VALUES (190, '33333333', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '注册成功', '2026-01-16 11:39:48');
INSERT INTO `sys_logininfor` VALUES (191, '333333333', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '用户不存在/密码错误', '2026-01-16 11:40:02');
INSERT INTO `sys_logininfor` VALUES (192, '333333333', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '验证码错误', '2026-01-16 11:40:09');
INSERT INTO `sys_logininfor` VALUES (193, '333333333', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '1', '用户不存在/密码错误', '2026-01-16 11:40:11');
INSERT INTO `sys_logininfor` VALUES (194, '33333333', '127.0.0.1', '内网IP', 'Edge 143', 'Windows >=10', '0', '登录成功', '2026-01-16 11:40:16');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-01-30 13:10:07');
INSERT INTO `sys_logininfor` VALUES (196, '12345', '127.0.0.1', '内网IP', 'Edge 144', 'Windows >=10', '0', '登录成功', '2026-01-30 13:11:30');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-27 13:27:21');
INSERT INTO `sys_logininfor` VALUES (198, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-27 13:27:47');
INSERT INTO `sys_logininfor` VALUES (199, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-27 14:58:19');
INSERT INTO `sys_logininfor` VALUES (200, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-27 15:05:21');
INSERT INTO `sys_logininfor` VALUES (201, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-27 15:05:34');
INSERT INTO `sys_logininfor` VALUES (202, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-02-27 15:11:32');
INSERT INTO `sys_logininfor` VALUES (203, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-02-27 15:12:26');
INSERT INTO `sys_logininfor` VALUES (204, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-02-27 15:12:29');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-07 03:33:55');
INSERT INTO `sys_logininfor` VALUES (206, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-07 03:51:49');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-07 17:07:43');
INSERT INTO `sys_logininfor` VALUES (208, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-03-07 17:17:19');
INSERT INTO `sys_logininfor` VALUES (209, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-07 17:17:24');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-08 21:08:54');
INSERT INTO `sys_logininfor` VALUES (211, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-08 21:10:10');
INSERT INTO `sys_logininfor` VALUES (212, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-03-08 21:10:28');
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-08 22:14:44');
INSERT INTO `sys_logininfor` VALUES (214, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-08 22:28:59');
INSERT INTO `sys_logininfor` VALUES (215, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-08 23:27:13');
INSERT INTO `sys_logininfor` VALUES (216, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-09 02:18:14');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码已失效', '2026-03-09 02:20:03');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-09 02:20:06');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-11 23:22:24');
INSERT INTO `sys_logininfor` VALUES (220, '12345', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-11 23:22:33');
INSERT INTO `sys_logininfor` VALUES (221, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-14 19:54:45');
INSERT INTO `sys_logininfor` VALUES (222, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-03-14 19:54:50');
INSERT INTO `sys_logininfor` VALUES (223, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-14 19:54:58');
INSERT INTO `sys_logininfor` VALUES (224, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-03-14 19:55:10');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码已失效', '2026-03-14 19:57:33');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-14 19:57:36');
INSERT INTO `sys_logininfor` VALUES (227, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-15 00:08:56');
INSERT INTO `sys_logininfor` VALUES (228, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-15 00:19:01');
INSERT INTO `sys_logininfor` VALUES (229, '12345', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-15 00:33:17');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-15 11:02:34');
INSERT INTO `sys_logininfor` VALUES (231, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-15 11:03:00');
INSERT INTO `sys_logininfor` VALUES (232, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-03-15 11:03:02');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '退出成功', '2026-03-15 11:03:20');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-03-15 11:04:43');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-15 11:04:46');
INSERT INTO `sys_logininfor` VALUES (236, '12345', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '验证码错误', '2026-03-15 11:05:11');
INSERT INTO `sys_logininfor` VALUES (237, '12345', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '1', '用户不存在/密码错误', '2026-03-15 11:05:14');
INSERT INTO `sys_logininfor` VALUES (238, '123456', '127.0.0.1', '内网IP', 'Edge 145', 'Windows >=10', '0', '登录成功', '2026-03-15 11:05:22');
INSERT INTO `sys_logininfor` VALUES (239, 'admin', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-16 15:50:42');
INSERT INTO `sys_logininfor` VALUES (240, '123456', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '1', '验证码错误', '2026-03-16 15:51:36');
INSERT INTO `sys_logininfor` VALUES (241, '123456', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-16 15:51:39');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '1', '验证码已失效', '2026-03-17 09:20:06');
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-17 09:20:08');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '1', '验证码错误', '2026-03-17 09:54:29');
INSERT INTO `sys_logininfor` VALUES (245, 'admin', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-17 09:54:31');
INSERT INTO `sys_logininfor` VALUES (246, '123456', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-17 09:56:47');
INSERT INTO `sys_logininfor` VALUES (247, '123456', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '退出成功', '2026-03-17 10:22:09');
INSERT INTO `sys_logininfor` VALUES (248, 'admin', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-17 10:22:12');
INSERT INTO `sys_logininfor` VALUES (249, '123456', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-17 10:22:31');
INSERT INTO `sys_logininfor` VALUES (250, '123456', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-17 11:59:17');
INSERT INTO `sys_logininfor` VALUES (251, 'admin', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-17 11:59:22');
INSERT INTO `sys_logininfor` VALUES (252, '123456', '127.0.0.1', '内网IP', 'Edge 146', 'Windows >=10', '0', '登录成功', '2026-03-20 20:49:40');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2036 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-12-29 15:07:16', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-12-29 15:07:16', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '1', '0', '', 'tool', 'admin', '2025-12-29 15:07:16', 'admin', '2026-03-08 22:40:30', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '1', '0', '', 'guide', 'admin', '2025-12-29 15:07:16', 'admin', '2026-03-08 22:32:19', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-12-29 15:07:16', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-12-29 15:07:16', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-12-29 15:07:16', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-12-29 15:07:16', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-12-29 15:07:16', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-12-29 15:07:16', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-12-29 15:07:16', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-12-29 15:07:16', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-12-29 15:07:16', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-12-29 15:07:16', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-12-29 15:07:16', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-12-29 15:07:16', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-12-29 15:07:16', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-12-29 15:07:16', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-12-29 15:07:16', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-12-29 15:07:16', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-12-29 15:07:16', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-12-29 15:07:16', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-12-29 15:07:16', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-12-29 15:07:16', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '租赁管理', 0, 0, 'rental', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'shopping', 'admin', '2026-01-14 15:11:23', 'admin', '2026-03-08 22:40:53', '租赁系统管理菜单');
INSERT INTO `sys_menu` VALUES (2001, '设备管理', 2000, 1, 'equipment', 'rental/equipment/index', NULL, '', 1, 0, 'C', '0', '0', 'rental:equipment:list', 'component', 'admin', '2026-01-14 15:11:23', '', NULL, '设备管理菜单');
INSERT INTO `sys_menu` VALUES (2010, '分类管理', 2000, 2, 'category', 'rental/category/index', NULL, '', 1, 0, 'C', '0', '0', 'rental:category:list', 'tree', 'admin', '2026-01-14 15:11:23', '', NULL, '分类管理菜单');
INSERT INTO `sys_menu` VALUES (2020, '订单管理', 2000, 3, 'order', 'rental/order/index', NULL, '', 1, 0, 'C', '0', '0', 'rental:order:list', 'form', 'admin', '2026-01-14 15:11:23', '', NULL, '订单管理菜单');
INSERT INTO `sys_menu` VALUES (2030, '数据统计', 2000, 4, 'statistics', 'rental/statistics/index', NULL, '', 1, 0, 'C', '0', '0', 'rental:statistics:view', 'chart', 'admin', '2026-01-14 15:11:23', '', NULL, '数据统计菜单');
INSERT INTO `sys_menu` VALUES (2031, '优惠券管理', 2000, 6, 'coupon', 'rental/coupon/index', NULL, 'Coupon', 1, 0, 'C', '0', '0', 'rental:coupon:list', 'shopping', 'admin', '2026-03-07 03:38:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '优惠券查询', 2031, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'rental:coupon:list', '#', 'admin', '2026-03-07 03:40:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '优惠券新增', 2031, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'rental:coupon:add', '#', 'admin', '2026-03-07 03:40:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '优惠券修改', 2031, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'rental:coupon:edit', '#', 'admin', '2026-03-07 03:41:03', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '优惠券删除', 2031, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'rental:coupon:remove', '#', 'admin', '2026-03-07 03:41:27', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-12-29 15:07:17', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-12-29 15:07:17', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 340 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":100,\"nickName\":\"123456\",\"params\":{},\"phonenumber\":\"13646666666\",\"postIds\":[],\"roleIds\":[],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"123456\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-03 16:24:24', 103);
INSERT INTO `sys_oper_log` VALUES (101, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '若依科技', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":1,\"createTime\":\"2026-01-03 16:29:24\",\"equipmentId\":2,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-03 16:29:24', 172);
INSERT INTO `sys_oper_log` VALUES (102, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '123456', '若依科技', '/rental/favorite', '127.0.0.1', '内网IP', '{\"equipmentId\":1,\"params\":{},\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-03 17:02:41', 11);
INSERT INTO `sys_oper_log` VALUES (103, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '123456', '若依科技', '/rental/favorite', '127.0.0.1', '内网IP', '{\"equipmentId\":1,\"params\":{},\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-03 17:02:45', 1);
INSERT INTO `sys_oper_log` VALUES (104, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '123456', '若依科技', '/rental/favorite', '127.0.0.1', '内网IP', '{\"equipmentId\":1,\"params\":{},\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-03 17:03:00', 1);
INSERT INTO `sys_oper_log` VALUES (105, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '123456', '若依科技', '/rental/favorite', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-03 17:05:41\",\"equipmentId\":1,\"favoriteId\":1,\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-03 17:05:41', 178);
INSERT INTO `sys_oper_log` VALUES (106, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '若依科技', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-14 15:26:31\",\"depositAmount\":6000,\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"orderNo\":\"RO456cc6b56bbe4416bd26d77be5b39d94\",\"params\":{},\"quantity\":1,\"rentalAmount\":150.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":6150,\"unitPrice\":150,\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'quantity\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-14 15:26:31', 35);
INSERT INTO `sys_oper_log` VALUES (107, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '若依科技', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-14 15:26:35\",\"depositAmount\":6000,\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"orderNo\":\"ROeb0bebd7ca0948648e4f32db5e637997\",\"params\":{},\"quantity\":1,\"rentalAmount\":150.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":6150,\"unitPrice\":150,\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'quantity\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-14 15:26:35', 6);
INSERT INTO `sys_oper_log` VALUES (108, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '若依科技', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-14 15:26:36\",\"depositAmount\":6000,\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"orderNo\":\"RO8b8baa60e80c4cb1a39f7d226e5c49aa\",\"params\":{},\"quantity\":1,\"rentalAmount\":150.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":6150,\"unitPrice\":150,\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'quantity\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-14 15:26:36', 5);
INSERT INTO `sys_oper_log` VALUES (109, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '若依科技', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-14 15:26:36\",\"depositAmount\":6000,\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"orderNo\":\"RO71166d348189485385f74d05fa628ad4\",\"params\":{},\"quantity\":1,\"rentalAmount\":150.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":6150,\"unitPrice\":150,\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'quantity\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-14 15:26:36', 5);
INSERT INTO `sys_oper_log` VALUES (110, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '若依科技', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-14 15:59:32\",\"depositAmount\":6000,\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"orderNo\":\"ROb56d2a8b75914bf8b714cb37925a683d\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"123121321313\",\"receiverName\":\"aaa\",\"receiverPhone\":\"13616544433\",\"rentalAmount\":150.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":6150,\"unitPrice\":150,\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'quantity\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-14 15:59:32', 28);
INSERT INTO `sys_oper_log` VALUES (111, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '若依科技', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-14 15:59:35\",\"depositAmount\":6000,\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"orderNo\":\"ROfcea39268aa94106a25ad83424617669\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"123121321313\",\"receiverName\":\"aaa\",\"receiverPhone\":\"13616544433\",\"rentalAmount\":150.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":6150,\"unitPrice\":150,\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'quantity\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-14 15:59:35', 7);
INSERT INTO `sys_oper_log` VALUES (112, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '若依科技', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-14 15:59:39\",\"depositAmount\":6000,\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"orderNo\":\"ROf7d84e2def1e4dfe9e9f0cb1c8e85202\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"123121321313\",\"receiverName\":\"aaa\",\"receiverPhone\":\"13616544433\",\"rentalAmount\":150.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":6150,\"unitPrice\":150,\"userId\":100} ', NULL, 1, 'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'quantity\' not found. Available parameters are [arg1, arg0, param1, param2]', '2026-01-14 15:59:39', 6);
INSERT INTO `sys_oper_log` VALUES (113, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '若依科技', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-14 16:23:05\",\"depositAmount\":6000,\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"orderId\":1,\"orderNo\":\"ROe2898b903cfd43fc9375532f53f12994\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"1313131313131\",\"receiverName\":\"1\",\"receiverPhone\":\"13616542222\",\"rentalAmount\":150.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":6150,\"unitPrice\":150,\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 16:23:05', 65);
INSERT INTO `sys_oper_log` VALUES (114, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '若依科技', '/rental/cart/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 16:23:05', 21);
INSERT INTO `sys_oper_log` VALUES (115, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '123456', '若依科技', '/rental/order/pay/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 16:23:17', 15);
INSERT INTO `sys_oper_log` VALUES (116, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '研发部门', '/rental/order/ship/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 16:33:08', 51);
INSERT INTO `sys_oper_log` VALUES (117, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '123456', '若依科技', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":1,\"params\":{},\"returnExpressCompany\":\"中通快递\",\"returnExpressNo\":\"13213213213123232\",\"updateBy\":\"123456\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 16:33:49', 22);
INSERT INTO `sys_oper_log` VALUES (118, '确认收货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.confirmReturn()', 'PUT', 1, 'admin', '研发部门', '/rental/order/confirmReturn/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 16:33:57', 51);
INSERT INTO `sys_oper_log` VALUES (119, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Apple\",\"categoryId\":2,\"categoryName\":\"笔记本电脑\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":200,\"delFlag\":\"0\",\"deposit\":8000,\"description\":\"全新MacBook Pro，性能强劲，适合专业设计和开发工作\",\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"images\":\"[\\\"/images/macbook-1.jpg\\\",\\\"/images/macbook-2.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/14/屏幕截图 2025-12-24 193547_20260114165546A001.png\",\"model\":\"M3 Pro\",\"monthlyPrice\":4500,\"params\":{},\"rentalNotes\":\"1. 请妥善保管设备\\n2. 禁止私自拆卸\\n3. 如有损坏需照价赔偿\",\"rentedCount\":0,\"specifications\":\"{\\\"cpu\\\":\\\"M3 Pro芯片\\\",\\\"memory\\\":\\\"32GB\\\",\\\"storage\\\":\\\"1TB SSD\\\",\\\"display\\\":\\\"16.2英寸 Liquid Retina XDR\\\"}\",\"status\":\"0\",\"stock\":5,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-01-14 16:55:48\",\"weeklyPrice\":1200} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 16:55:48', 21);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-01-14 20:58:10', 12);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 20:58:19', 21);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-01-14 20:58:21', 3);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 20:58:38', 11);
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-01-14 20:59:39', 3);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 20:59:56', 11);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-01-14 20:59:58', 6);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 21:00:13', 10);
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-01-14 21:00:16', 7);
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-01-14 21:00:25', 6);
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-01-14 21:00:39', 28);
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":4,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"visible\":\"0\"} ', '{\"msg\":\"修改菜单\'若依官网\'失败，上级菜单不能选择自己\",\"code\":500}', 0, NULL, '2026-01-14 21:00:52', 5);
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-14 21:02:13', 11);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-01-15 17:43:56', 18);
INSERT INTO `sys_oper_log` VALUES (134, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/109', '127.0.0.1', '内网IP', '109 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:44:19', 18);
INSERT INTO `sys_oper_log` VALUES (135, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/108', '127.0.0.1', '内网IP', '108 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:44:20', 17);
INSERT INTO `sys_oper_log` VALUES (136, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '127.0.0.1', '内网IP', '102 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:44:22', 20);
INSERT INTO `sys_oper_log` VALUES (137, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"管理员\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"深圳总公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:45:20', 28);
INSERT INTO `sys_oper_log` VALUES (138, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"用户\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:55:52', 13);
INSERT INTO `sys_oper_log` VALUES (139, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"后台\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"若依科技\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:56:37', 25);
INSERT INTO `sys_oper_log` VALUES (140, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/104', '127.0.0.1', '内网IP', '104 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:56:41', 17);
INSERT INTO `sys_oper_log` VALUES (141, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/105', '127.0.0.1', '内网IP', '105 ', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2026-01-15 17:56:43', 4);
INSERT INTO `sys_oper_log` VALUES (142, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/106', '127.0.0.1', '内网IP', '106 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:56:45', 18);
INSERT INTO `sys_oper_log` VALUES (143, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/107', '127.0.0.1', '内网IP', '107 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:56:47', 18);
INSERT INTO `sys_oper_log` VALUES (144, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"总管理员\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"后台\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:57:07', 15);
INSERT INTO `sys_oper_log` VALUES (145, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"管理员\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"后台\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:57:15', 18);
INSERT INTO `sys_oper_log` VALUES (146, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/200', '127.0.0.1', '内网IP', '200 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:57:53', 15);
INSERT INTO `sys_oper_log` VALUES (147, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"前台\",\"orderNum\":4,\"params\":{},\"parentId\":100,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:58:40', 9);
INSERT INTO `sys_oper_log` VALUES (148, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,201\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"用户\",\"orderNum\":1,\"params\":{},\"parentId\":201,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 17:58:50', 14);
INSERT INTO `sys_oper_log` VALUES (149, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2025-12-29 15:07:17\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 18:15:07', 34);
INSERT INTO `sys_oper_log` VALUES (150, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2026-01-03 16:24:24\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"若依科技\",\"leader\":\"若依\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"status\":\"0\"},\"deptId\":202,\"email\":\"\",\"loginDate\":\"2026-01-15 18:00:32\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"123456\",\"params\":{},\"phonenumber\":\"13646666666\",\"postIds\":[],\"roleIds\":[],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"123456\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 18:19:08', 36);
INSERT INTO `sys_oper_log` VALUES (151, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Apple\",\"categoryId\":2,\"categoryName\":\"笔记本电脑\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":200,\"delFlag\":\"0\",\"deposit\":8000,\"description\":\"全新MacBook Pro，性能强劲，适合专业设计和开发工作\",\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"images\":\"[\\\"/images/macbook-1.jpg\\\",\\\"/images/macbook-2.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/1_20260115182949A001.jpg\",\"model\":\"M3 Pro\",\"monthlyPrice\":4500,\"params\":{},\"rentalNotes\":\"1. 请妥善保管设备\\n2. 禁止私自拆卸\\n3. 如有损坏需照价赔偿\",\"rentedCount\":0,\"specifications\":\"{\\\"cpu\\\":\\\"M3 Pro芯片\\\",\\\"memory\\\":\\\"32GB\\\",\\\"storage\\\":\\\"1TB SSD\\\",\\\"display\\\":\\\"16.2英寸 Liquid Retina XDR\\\"}\",\"status\":\"0\",\"stock\":5,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-01-15 18:29:51\",\"weeklyPrice\":1200} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 18:29:51', 16);
INSERT INTO `sys_oper_log` VALUES (152, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Dell\",\"categoryId\":2,\"categoryName\":\"笔记本电脑\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":150,\"delFlag\":\"0\",\"deposit\":6000,\"description\":\"高性能商务本，4K OLED屏幕，色彩还原出色\",\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"images\":\"[\\\"/images/dell-1.jpg\\\",\\\"/images/dell-2.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/2_20260115183022A002.jpg\",\"model\":\"XPS 15 9530\",\"monthlyPrice\":3200,\"params\":{},\"rentalNotes\":\"租赁期间请注意防水防摔\",\"rentedCount\":0,\"specifications\":\"{\\\"cpu\\\":\\\"Intel i7-13700H\\\",\\\"memory\\\":\\\"16GB\\\",\\\"storage\\\":\\\"512GB SSD\\\",\\\"display\\\":\\\"15.6英寸 4K OLED\\\"}\",\"status\":\"0\",\"stock\":8,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-01-15 18:30:23\",\"weeklyPrice\":900} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 18:30:23', 10);
INSERT INTO `sys_oper_log` VALUES (153, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Canon\",\"categoryId\":5,\"categoryName\":\"单反相机\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":300,\"delFlag\":\"0\",\"deposit\":15000,\"description\":\"专业级全画幅微单相机，支持8K视频拍摄\",\"equipmentId\":3,\"equipmentName\":\"Canon EOS R5\",\"images\":\"[\\\"/images/canon-1.jpg\\\",\\\"/images/canon-2.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/3_20260115183106A003.jpg\",\"model\":\"EOS R5\",\"monthlyPrice\":6500,\"params\":{},\"rentalNotes\":\"请配合使用原装电池和存储卡\",\"rentedCount\":0,\"specifications\":\"{\\\"sensor\\\":\\\"全画幅 45MP\\\",\\\"video\\\":\\\"8K 30fps\\\",\\\"iso\\\":\\\"100-51200\\\",\\\"stabilization\\\":\\\"机身5轴防抖\\\"}\",\"status\":\"0\",\"stock\":3,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-01-15 18:31:07\",\"weeklyPrice\":1800} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 18:31:07', 1);
INSERT INTO `sys_oper_log` VALUES (154, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Sony\",\"categoryId\":5,\"categoryName\":\"单反相机\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":250,\"delFlag\":\"0\",\"deposit\":12000,\"description\":\"索尼全画幅微单，视频拍摄性能优秀\",\"equipmentId\":4,\"equipmentName\":\"Sony A7M4\",\"images\":\"[\\\"/images/sony-1.jpg\\\",\\\"/images/sony-2.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/4_20260115183135A004.jpg\",\"model\":\"A7 Mark IV\",\"monthlyPrice\":5500,\"params\":{},\"rentalNotes\":\"镜头需单独租赁\",\"rentedCount\":0,\"specifications\":\"{\\\"sensor\\\":\\\"全画幅 33MP\\\",\\\"video\\\":\\\"4K 60fps\\\",\\\"iso\\\":\\\"100-51200\\\",\\\"stabilization\\\":\\\"机身5轴防抖\\\"}\",\"status\":\"0\",\"stock\":4,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-01-15 18:31:36\",\"weeklyPrice\":1500} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 18:31:36', 6);
INSERT INTO `sys_oper_log` VALUES (155, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '研发部门', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Epson\",\"categoryId\":8,\"categoryName\":\"投影仪\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":100,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"商务投影仪，高亮度，适合会议室使用\",\"equipmentId\":5,\"equipmentName\":\"Epson投影仪 EB-2250U\",\"images\":\"[\\\"/images/epson-1.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/5_20260115183226A005.jpg\",\"model\":\"EB-2250U\",\"monthlyPrice\":2000,\"params\":{},\"rentalNotes\":\"包含HDMI线和遥控器\",\"rentedCount\":0,\"specifications\":\"{\\\"brightness\\\":\\\"5000流明\\\",\\\"resolution\\\":\\\"1920x1200\\\",\\\"contrast\\\":\\\"15000:1\\\",\\\"lamp_life\\\":\\\"10000小时\\\"}\",\"status\":\"0\",\"stock\":10,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-01-15 18:32:27\",\"weeklyPrice\":600} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 18:32:27', 3);
INSERT INTO `sys_oper_log` VALUES (156, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '12345678', '用户', '/rental/favorite', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-15 18:33:36\",\"equipmentId\":1,\"favoriteId\":2,\"params\":{},\"userId\":101} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 18:33:36', 13);
INSERT INTO `sys_oper_log` VALUES (157, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '12345678', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":2,\"createTime\":\"2026-01-15 18:33:38\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":5,\"rentalType\":\"1\",\"userId\":101} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 18:33:38', 9);
INSERT INTO `sys_oper_log` VALUES (158, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":3,\"createTime\":\"2026-01-15 19:25:11\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:25:11', 17);
INSERT INTO `sys_oper_log` VALUES (159, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":4,\"createTime\":\"2026-01-15 19:25:12\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:25:12', 9);
INSERT INTO `sys_oper_log` VALUES (160, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/3', '127.0.0.1', '内网IP', '[3] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:25:15', 9);
INSERT INTO `sys_oper_log` VALUES (161, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '1234567', '用户', '/rental/favorite', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-15 19:31:04\",\"equipmentId\":1,\"favoriteId\":3,\"params\":{},\"userId\":102} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:31:04', 19);
INSERT INTO `sys_oper_log` VALUES (162, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '1234567', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":5,\"createTime\":\"2026-01-15 19:31:17\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":102} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:31:17', 11);
INSERT INTO `sys_oper_log` VALUES (163, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '1234567', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"1234567\",\"createTime\":\"2026-01-15 19:31:45\",\"depositAmount\":8000,\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"orderId\":2,\"orderNo\":\"RO66f0892197214feba50f77f6809a7415\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"sadasdasdasdsad\",\"receiverName\":\"12345\",\"receiverPhone\":\"13616545444\",\"rentalAmount\":200.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":8200,\"unitPrice\":200,\"userId\":102} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:31:45', 35);
INSERT INTO `sys_oper_log` VALUES (164, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '1234567', '用户', '/rental/cart/5', '127.0.0.1', '内网IP', '[5] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:31:45', 11);
INSERT INTO `sys_oper_log` VALUES (165, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '1234567', '用户', '/rental/order/pay/2', '127.0.0.1', '内网IP', '2 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:31:53', 6);
INSERT INTO `sys_oper_log` VALUES (166, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/2', '127.0.0.1', '内网IP', '2 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:32:10', 4);
INSERT INTO `sys_oper_log` VALUES (167, '归还设备', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.returnEquipment()', 'PUT', 1, '1234567', '用户', '/rental/order/return/2', '127.0.0.1', '内网IP', '2 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:32:20', 17);
INSERT INTO `sys_oper_log` VALUES (168, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Apple\",\"categoryId\":2,\"categoryName\":\"笔记本电脑\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":200,\"delFlag\":\"0\",\"deposit\":8000,\"description\":\"全新MacBook Pro，性能强劲，适合专业设计和开发工作\",\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"images\":\"[\\\"/images/macbook-1.jpg\\\",\\\"/images/macbook-2.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/1_20260115182949A001.jpg\",\"model\":\"M3 Pro\",\"monthlyPrice\":4500,\"params\":{},\"rentalNotes\":\"1. 请妥善保管设备\\n2. 禁止私自拆卸\\n3. 如有损坏需照价赔偿\",\"rentedCount\":0,\"specifications\":\"{\\\"cpu\\\":\\\"M3 Pro芯片\\\",\\\"memory\\\":\\\"32GB\\\",\\\"storage\\\":\\\"1TB SSD\\\",\\\"display\\\":\\\"16.2英寸 Liquid Retina XDR\\\"}\",\"status\":\"0\",\"stock\":5,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-01-15 19:33:05\",\"weeklyPrice\":1200} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:33:05', 13);
INSERT INTO `sys_oper_log` VALUES (169, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '1234567', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":6,\"createTime\":\"2026-01-15 19:34:38\",\"equipmentId\":2,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":102} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:34:38', 9);
INSERT INTO `sys_oper_log` VALUES (170, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '1234567', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"1234567\",\"createTime\":\"2026-01-15 19:34:53\",\"depositAmount\":6000,\"equipmentId\":2,\"equipmentName\":\"Dell XPS 15\",\"orderId\":3,\"orderNo\":\"RO373acc74eae648c391f5d51f299fdc74\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"123313131232132\",\"receiverName\":\"23123\",\"receiverPhone\":\"13616555555\",\"rentalAmount\":150.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":6150,\"unitPrice\":150,\"userId\":102} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:34:53', 13);
INSERT INTO `sys_oper_log` VALUES (171, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '1234567', '用户', '/rental/cart/6', '127.0.0.1', '内网IP', '[6] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:34:53', 6);
INSERT INTO `sys_oper_log` VALUES (172, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '1234567', '用户', '/rental/order/pay/3', '127.0.0.1', '内网IP', '3 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:34:55', 3);
INSERT INTO `sys_oper_log` VALUES (173, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/3', '127.0.0.1', '内网IP', '3 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:35:09', 4);
INSERT INTO `sys_oper_log` VALUES (174, '归还设备', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.returnEquipment()', 'PUT', 1, '1234567', '用户', '/rental/order/return/3', '127.0.0.1', '内网IP', '3 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:35:18', 9);
INSERT INTO `sys_oper_log` VALUES (175, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":7,\"createTime\":\"2026-01-15 19:45:50\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:45:50', 35);
INSERT INTO `sys_oper_log` VALUES (176, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/7', '127.0.0.1', '内网IP', '[7] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:45:56', 21);
INSERT INTO `sys_oper_log` VALUES (177, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-15 19:46:08\",\"depositAmount\":8000,\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"orderId\":4,\"orderNo\":\"RO3b55cf553178435db8221885bc2f388a\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"12321312312\",\"receiverName\":\"123\",\"receiverPhone\":\"13515144444\",\"rentalAmount\":200.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":8200,\"unitPrice\":200,\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:46:08', 53);
INSERT INTO `sys_oper_log` VALUES (178, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/4', '127.0.0.1', '内网IP', '[4] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:46:09', 13);
INSERT INTO `sys_oper_log` VALUES (179, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '123456', '用户', '/rental/order/pay/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:46:11', 20);
INSERT INTO `sys_oper_log` VALUES (180, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:46:43', 6);
INSERT INTO `sys_oper_log` VALUES (181, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '123456', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":4,\"params\":{},\"returnExpressCompany\":\"顺丰速运\",\"returnExpressNo\":\"2132131313123213213123\",\"updateBy\":\"123456\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:46:54', 14);
INSERT INTO `sys_oper_log` VALUES (182, '确认收货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.confirmReturn()', 'PUT', 1, 'admin', '总管理员', '/rental/order/confirmReturn/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 19:47:01', 18);
INSERT INTO `sys_oper_log` VALUES (183, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":8,\"createTime\":\"2026-01-15 20:03:02\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:03:02', 20);
INSERT INTO `sys_oper_log` VALUES (184, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":9,\"createTime\":\"2026-01-15 20:08:52\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:08:52', 19);
INSERT INTO `sys_oper_log` VALUES (185, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/8', '127.0.0.1', '内网IP', '[8] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:08:59', 7);
INSERT INTO `sys_oper_log` VALUES (186, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-01-15 20:09:17\",\"depositAmount\":8000,\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"orderId\":5,\"orderNo\":\"ROe9a5e0b660d44882b4191e542a1cc116\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"12312312312321312\",\"receiverName\":\"123\",\"receiverPhone\":\"15220222222\",\"rentalAmount\":200.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":8200,\"unitPrice\":200,\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:09:17', 42);
INSERT INTO `sys_oper_log` VALUES (187, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/9', '127.0.0.1', '内网IP', '[9] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:09:17', 8);
INSERT INTO `sys_oper_log` VALUES (188, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '123456', '用户', '/rental/order/pay/5', '127.0.0.1', '内网IP', '5 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:09:25', 10);
INSERT INTO `sys_oper_log` VALUES (189, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/5', '127.0.0.1', '内网IP', '5 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:11:07', 7);
INSERT INTO `sys_oper_log` VALUES (190, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '123456', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":5,\"params\":{},\"returnExpressCompany\":\"顺丰速运\",\"returnExpressNo\":\"1233131312312\",\"updateBy\":\"123456\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:11:24', 7);
INSERT INTO `sys_oper_log` VALUES (191, '确认收货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.confirmReturn()', 'PUT', 1, 'admin', '总管理员', '/rental/order/confirmReturn/5', '127.0.0.1', '内网IP', '5 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:11:39', 21);
INSERT INTO `sys_oper_log` VALUES (192, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '12345', '用户', '/rental/favorite', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-15 20:16:08\",\"equipmentId\":1,\"favoriteId\":4,\"params\":{},\"userId\":103} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:16:08', 17);
INSERT INTO `sys_oper_log` VALUES (193, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '12345', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":10,\"createTime\":\"2026-01-15 20:16:22\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":103} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:16:22', 17);
INSERT INTO `sys_oper_log` VALUES (194, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '12345', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"12345\",\"createTime\":\"2026-01-15 20:16:37\",\"depositAmount\":8000,\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"orderId\":6,\"orderNo\":\"RO9563d0f44ece479aa96ed73ea52dc1b9\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"12421sdgsdg\",\"receiverName\":\"啊实打实\",\"receiverPhone\":\"13515444444\",\"rentalAmount\":200.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":8200,\"unitPrice\":200,\"userId\":103} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:16:37', 25);
INSERT INTO `sys_oper_log` VALUES (195, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '12345', '用户', '/rental/cart/10', '127.0.0.1', '内网IP', '[10] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:16:37', 9);
INSERT INTO `sys_oper_log` VALUES (196, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '12345', '用户', '/rental/order/pay/6', '127.0.0.1', '内网IP', '6 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:16:41', 11);
INSERT INTO `sys_oper_log` VALUES (197, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/6', '127.0.0.1', '内网IP', '6 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:16:54', 15);
INSERT INTO `sys_oper_log` VALUES (198, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '12345', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":6,\"params\":{},\"returnExpressCompany\":\"圆通速递\",\"returnExpressNo\":\"2343423423423432\",\"updateBy\":\"12345\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:17:13', 9);
INSERT INTO `sys_oper_log` VALUES (199, '确认收货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.confirmReturn()', 'PUT', 1, 'admin', '总管理员', '/rental/order/confirmReturn/6', '127.0.0.1', '内网IP', '6 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:17:27', 9);
INSERT INTO `sys_oper_log` VALUES (200, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '总管理员', '/system/user/101', '127.0.0.1', '内网IP', '[101] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:18:39', 18);
INSERT INTO `sys_oper_log` VALUES (201, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '112233', '用户', '/rental/favorite', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-15 20:21:56\",\"equipmentId\":1,\"favoriteId\":5,\"params\":{},\"userId\":104} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:21:56', 40);
INSERT INTO `sys_oper_log` VALUES (202, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '112233', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":11,\"createTime\":\"2026-01-15 20:22:09\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":104} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:22:09', 17);
INSERT INTO `sys_oper_log` VALUES (203, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '112233', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"112233\",\"createTime\":\"2026-01-15 20:22:29\",\"depositAmount\":8000,\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"orderId\":7,\"orderNo\":\"RO7c41fb228b8b41359d9da10f68455e37\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"啊发发发去噶士大夫士大夫山豆根\",\"receiverName\":\"请问请问\",\"receiverPhone\":\"13451555555\",\"rentalAmount\":200.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":8200,\"unitPrice\":200,\"userId\":104} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:22:29', 11);
INSERT INTO `sys_oper_log` VALUES (204, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '112233', '用户', '/rental/cart/11', '127.0.0.1', '内网IP', '[11] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:22:29', 6);
INSERT INTO `sys_oper_log` VALUES (205, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '112233', '用户', '/rental/order/pay/7', '127.0.0.1', '内网IP', '7 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:22:32', 6);
INSERT INTO `sys_oper_log` VALUES (206, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/7', '127.0.0.1', '内网IP', '7 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:22:40', 8);
INSERT INTO `sys_oper_log` VALUES (207, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '112233', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":7,\"params\":{},\"returnExpressCompany\":\"圆通速递\",\"returnExpressNo\":\"1232131312312312\",\"updateBy\":\"112233\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:22:52', 8);
INSERT INTO `sys_oper_log` VALUES (208, '确认收货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.confirmReturn()', 'PUT', 1, 'admin', '总管理员', '/rental/order/confirmReturn/7', '127.0.0.1', '内网IP', '7 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 20:23:00', 17);
INSERT INTO `sys_oper_log` VALUES (209, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '111111', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":12,\"createTime\":\"2026-01-15 21:10:21\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":105} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 21:10:21', 16);
INSERT INTO `sys_oper_log` VALUES (210, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '111111', '用户', '/rental/favorite', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-15 21:10:30\",\"equipmentId\":1,\"favoriteId\":6,\"params\":{},\"userId\":105} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 21:10:30', 16);
INSERT INTO `sys_oper_log` VALUES (211, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '111111', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"111111\",\"createTime\":\"2026-01-15 21:10:58\",\"depositAmount\":8000,\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"orderId\":8,\"orderNo\":\"RO550280cf965141bbba1461d64308073f\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"1dfdfg897979\",\"receiverName\":\"45645\",\"receiverPhone\":\"14515151555\",\"rentalAmount\":200.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":8200,\"unitPrice\":200,\"userId\":105} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 21:10:58', 37);
INSERT INTO `sys_oper_log` VALUES (212, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '111111', '用户', '/rental/cart/12', '127.0.0.1', '内网IP', '[12] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 21:10:58', 12);
INSERT INTO `sys_oper_log` VALUES (213, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '111111', '用户', '/rental/order/pay/8', '127.0.0.1', '内网IP', '8 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 21:11:00', 8);
INSERT INTO `sys_oper_log` VALUES (214, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/8', '127.0.0.1', '内网IP', '8 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 21:11:10', 9);
INSERT INTO `sys_oper_log` VALUES (215, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '111111', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":8,\"params\":{},\"returnExpressCompany\":\"顺丰速运\",\"returnExpressNo\":\"67686867867876\",\"updateBy\":\"111111\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 21:11:19', 6);
INSERT INTO `sys_oper_log` VALUES (216, '确认收货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.confirmReturn()', 'PUT', 1, 'admin', '总管理员', '/rental/order/confirmReturn/8', '127.0.0.1', '内网IP', '8 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 21:11:26', 17);
INSERT INTO `sys_oper_log` VALUES (217, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '111111', '用户', '/rental/favorite', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-15 21:12:33\",\"equipmentId\":2,\"favoriteId\":7,\"params\":{},\"userId\":105} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-15 21:12:33', 9);
INSERT INTO `sys_oper_log` VALUES (218, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '11112222', '用户', '/rental/favorite', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-16 11:32:11\",\"equipmentId\":1,\"favoriteId\":8,\"params\":{},\"userId\":106} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:32:11', 40);
INSERT INTO `sys_oper_log` VALUES (219, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '11112222', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":13,\"createTime\":\"2026-01-16 11:32:20\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":106} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:32:20', 27);
INSERT INTO `sys_oper_log` VALUES (220, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '11112222', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"11112222\",\"createTime\":\"2026-01-16 11:32:42\",\"depositAmount\":8000,\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"orderId\":9,\"orderNo\":\"ROd1e4d5dd1a2b4c7780a91806680d0f3e\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"阿三大苏打撒旦反对犯得上\",\"receiverName\":\"大飒飒的\",\"receiverPhone\":\"13616555555\",\"rentalAmount\":200.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":8200,\"unitPrice\":200,\"userId\":106} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:32:42', 40);
INSERT INTO `sys_oper_log` VALUES (221, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '11112222', '用户', '/rental/cart/13', '127.0.0.1', '内网IP', '[13] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:32:42', 10);
INSERT INTO `sys_oper_log` VALUES (222, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '11112222', '用户', '/rental/order/pay/9', '127.0.0.1', '内网IP', '9 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:32:47', 11);
INSERT INTO `sys_oper_log` VALUES (223, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/9', '127.0.0.1', '内网IP', '9 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:32:58', 19);
INSERT INTO `sys_oper_log` VALUES (224, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '11112222', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":9,\"params\":{},\"returnExpressCompany\":\"中通快递\",\"returnExpressNo\":\"12313123123123123\",\"updateBy\":\"11112222\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:33:11', 8);
INSERT INTO `sys_oper_log` VALUES (225, '确认收货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.confirmReturn()', 'PUT', 1, 'admin', '总管理员', '/rental/order/confirmReturn/9', '127.0.0.1', '内网IP', '9 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:33:21', 17);
INSERT INTO `sys_oper_log` VALUES (226, '收藏', 1, 'com.ruoyi.web.controller.rental.RentalFavoriteController.add()', 'POST', 1, '33333333', '用户', '/rental/favorite', '127.0.0.1', '内网IP', '{\"createTime\":\"2026-01-16 11:40:48\",\"equipmentId\":1,\"favoriteId\":9,\"params\":{},\"userId\":108} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:40:48', 11);
INSERT INTO `sys_oper_log` VALUES (227, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '33333333', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":14,\"createTime\":\"2026-01-16 11:40:58\",\"equipmentId\":3,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":108} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:40:58', 9);
INSERT INTO `sys_oper_log` VALUES (228, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '33333333', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"33333333\",\"createTime\":\"2026-01-16 11:41:15\",\"depositAmount\":15000,\"equipmentId\":3,\"equipmentName\":\"Canon EOS R5\",\"orderId\":10,\"orderNo\":\"RO067ff491b52b4b4da07fc55575f97b0a\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"2525452452453225\",\"receiverName\":\"阿萨大大\",\"receiverPhone\":\"13515544444\",\"rentalAmount\":300.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":15300,\"unitPrice\":300,\"userId\":108} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:41:16', 14);
INSERT INTO `sys_oper_log` VALUES (229, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '33333333', '用户', '/rental/cart/14', '127.0.0.1', '内网IP', '[14] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:41:16', 9);
INSERT INTO `sys_oper_log` VALUES (230, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '33333333', '用户', '/rental/order/pay/10', '127.0.0.1', '内网IP', '10 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:41:22', 10);
INSERT INTO `sys_oper_log` VALUES (231, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/10', '127.0.0.1', '内网IP', '10 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:41:32', 15);
INSERT INTO `sys_oper_log` VALUES (232, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '33333333', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":10,\"params\":{},\"returnExpressCompany\":\"顺丰速运\",\"returnExpressNo\":\"123123123123123123\",\"updateBy\":\"33333333\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:41:45', 9);
INSERT INTO `sys_oper_log` VALUES (233, '确认收货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.confirmReturn()', 'PUT', 1, 'admin', '总管理员', '/rental/order/confirmReturn/10', '127.0.0.1', '内网IP', '10 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-16 11:41:54', 18);
INSERT INTO `sys_oper_log` VALUES (234, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '12345', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":15,\"createTime\":\"2026-01-30 13:20:12\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":103} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 13:20:13', 207);
INSERT INTO `sys_oper_log` VALUES (235, '购物车', 2, 'com.ruoyi.web.controller.rental.RentalCartController.edit()', 'PUT', 1, '12345', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":15,\"params\":{},\"quantity\":2,\"updateTime\":\"2026-01-30 13:20:16\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 13:20:16', 9);
INSERT INTO `sys_oper_log` VALUES (236, '购物车', 2, 'com.ruoyi.web.controller.rental.RentalCartController.edit()', 'PUT', 1, '12345', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":15,\"params\":{},\"quantity\":1,\"updateTime\":\"2026-01-30 13:20:19\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 13:20:19', 11);
INSERT INTO `sys_oper_log` VALUES (237, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '12345', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"12345\",\"createTime\":\"2026-01-30 13:20:41\",\"depositAmount\":8000,\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"orderId\":11,\"orderNo\":\"RO5dd7b66052eb4372b1882f70cad0e9f4\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"ewqhqj我去饿饿\",\"receiverName\":\"i企鹅舞也i\",\"receiverPhone\":\"13616545555\",\"rentalAmount\":200.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":8200,\"unitPrice\":200,\"userId\":103} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 13:20:41', 80);
INSERT INTO `sys_oper_log` VALUES (238, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '12345', '用户', '/rental/cart/15', '127.0.0.1', '内网IP', '[15] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 13:20:41', 16);
INSERT INTO `sys_oper_log` VALUES (239, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '12345', '用户', '/rental/order/pay/11', '127.0.0.1', '内网IP', '11 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 13:20:45', 23);
INSERT INTO `sys_oper_log` VALUES (240, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":16,\"createTime\":\"2026-02-27 15:05:41\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 15:05:41', 143);
INSERT INTO `sys_oper_log` VALUES (241, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":17,\"createTime\":\"2026-02-27 15:05:42\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 15:05:42', 14);
INSERT INTO `sys_oper_log` VALUES (242, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/17', '127.0.0.1', '内网IP', '[17] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 15:05:46', 10);
INSERT INTO `sys_oper_log` VALUES (243, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/16', '127.0.0.1', '内网IP', '[16] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-27 15:05:47', 12);
INSERT INTO `sys_oper_log` VALUES (244, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"rental/coupon/index\",\"createBy\":\"admin\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"优惠券管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2000,\"path\":\"coupon\",\"perms\":\"rental:coupon:list\",\"routeName\":\"Coupon\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 03:38:09', 28);
INSERT INTO `sys_oper_log` VALUES (245, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"优惠券查询\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2031,\"perms\":\"rental:coupon:list\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 03:40:15', 151);
INSERT INTO `sys_oper_log` VALUES (246, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"优惠券新增\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2031,\"perms\":\"rental:coupon:add\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 03:40:39', 14);
INSERT INTO `sys_oper_log` VALUES (247, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"优惠券修改\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2031,\"perms\":\"rental:coupon:edit\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 03:41:03', 12);
INSERT INTO `sys_oper_log` VALUES (248, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"优惠券删除\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2031,\"perms\":\"rental:coupon:remove\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 03:41:27', 11);
INSERT INTO `sys_oper_log` VALUES (249, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '总管理员', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-03-07 17:08:27', 17);
INSERT INTO `sys_oper_log` VALUES (250, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":18,\"createTime\":\"2026-03-07 17:17:28\",\"equipmentId\":1,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 17:17:28', 32);
INSERT INTO `sys_oper_log` VALUES (251, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-03-07 17:18:14\",\"depositAmount\":8000,\"equipmentId\":1,\"equipmentName\":\"MacBook Pro 16英寸 2023款\",\"orderId\":12,\"orderNo\":\"ROef0d2599bacd44b5a74467dd6132f68c\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"213123委屈恶趣味去\",\"receiverName\":\"111\",\"receiverPhone\":\"13666666666\",\"rentalAmount\":200.00,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":8200,\"unitPrice\":200,\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 17:18:14', 50);
INSERT INTO `sys_oper_log` VALUES (252, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/18', '127.0.0.1', '内网IP', '[18] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 17:18:14', 10);
INSERT INTO `sys_oper_log` VALUES (253, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '123456', '用户', '/rental/order/pay/12', '127.0.0.1', '内网IP', '12 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 17:18:21', 42);
INSERT INTO `sys_oper_log` VALUES (254, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":11,\"categoryName\":\"测试\",\"createTime\":\"2026-03-08 21:11:47\",\"params\":{},\"parentId\":0,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:11:47', 29);
INSERT INTO `sys_oper_log` VALUES (255, '分类', 3, 'com.ruoyi.web.controller.rental.RentalCategoryController.remove()', 'DELETE', 1, 'admin', '总管理员', '/rental/category/11', '127.0.0.1', '内网IP', '[11] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:12:15', 14);
INSERT INTO `sys_oper_log` VALUES (256, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":12,\"categoryName\":\"游戏掌机\",\"createTime\":\"2026-03-08 21:15:29\",\"params\":{},\"parentId\":9,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:15:29', 16);
INSERT INTO `sys_oper_log` VALUES (257, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":13,\"categoryName\":\"手机\",\"createTime\":\"2026-03-08 21:16:43\",\"params\":{},\"parentId\":0,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:16:43', 16);
INSERT INTO `sys_oper_log` VALUES (258, '分类', 2, 'com.ruoyi.web.controller.rental.RentalCategoryController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":13,\"categoryName\":\"手机\",\"createBy\":\"\",\"createTime\":\"2026-03-08 21:16:43\",\"delFlag\":\"0\",\"params\":{},\"parentId\":0,\"sortOrder\":0,\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2026-03-08 21:17:00\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:17:00', 11);
INSERT INTO `sys_oper_log` VALUES (259, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":14,\"categoryName\":\"平板\",\"createTime\":\"2026-03-08 21:17:13\",\"params\":{},\"parentId\":0,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:17:14', 0);
INSERT INTO `sys_oper_log` VALUES (260, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":15,\"categoryName\":\"笔记本\",\"createTime\":\"2026-03-08 21:17:46\",\"params\":{},\"parentId\":0,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:17:46', 16);
INSERT INTO `sys_oper_log` VALUES (261, '分类', 3, 'com.ruoyi.web.controller.rental.RentalCategoryController.remove()', 'DELETE', 1, 'admin', '总管理员', '/rental/category/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:17:51', 17);
INSERT INTO `sys_oper_log` VALUES (262, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":16,\"categoryName\":\"11111\",\"createTime\":\"2026-03-08 21:27:45\",\"params\":{},\"parentId\":13,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:27:45', 160);
INSERT INTO `sys_oper_log` VALUES (263, '分类', 3, 'com.ruoyi.web.controller.rental.RentalCategoryController.remove()', 'DELETE', 1, 'admin', '总管理员', '/rental/category/16', '127.0.0.1', '内网IP', '[16] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:28:11', 13);
INSERT INTO `sys_oper_log` VALUES (264, '分类', 2, 'com.ruoyi.web.controller.rental.RentalCategoryController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":13,\"categoryName\":\"便携设备\",\"createBy\":\"\",\"createTime\":\"2026-03-08 21:16:43\",\"delFlag\":\"0\",\"params\":{},\"parentId\":0,\"sortOrder\":0,\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2026-03-08 21:29:38\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:29:38', 21);
INSERT INTO `sys_oper_log` VALUES (265, '分类', 3, 'com.ruoyi.web.controller.rental.RentalCategoryController.remove()', 'DELETE', 1, 'admin', '总管理员', '/rental/category/14', '127.0.0.1', '内网IP', '[14] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:29:44', 12);
INSERT INTO `sys_oper_log` VALUES (266, '分类', 3, 'com.ruoyi.web.controller.rental.RentalCategoryController.remove()', 'DELETE', 1, 'admin', '总管理员', '/rental/category/15', '127.0.0.1', '内网IP', '[15] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:29:48', 11);
INSERT INTO `sys_oper_log` VALUES (267, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":17,\"categoryName\":\"手机\",\"createTime\":\"2026-03-08 21:29:57\",\"params\":{},\"parentId\":13,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:29:57', 15);
INSERT INTO `sys_oper_log` VALUES (268, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":18,\"categoryName\":\"平板\",\"createTime\":\"2026-03-08 21:30:04\",\"params\":{},\"parentId\":13,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:30:04', 9);
INSERT INTO `sys_oper_log` VALUES (269, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":19,\"categoryName\":\"穿戴设备\",\"createTime\":\"2026-03-08 21:30:21\",\"params\":{},\"parentId\":0,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:30:21', 8);
INSERT INTO `sys_oper_log` VALUES (270, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":20,\"categoryName\":\"手表\",\"createTime\":\"2026-03-08 21:30:38\",\"params\":{},\"parentId\":19,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:30:38', 9);
INSERT INTO `sys_oper_log` VALUES (271, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":21,\"categoryName\":\"电脑\",\"createTime\":\"2026-03-08 21:32:29\",\"params\":{},\"parentId\":0,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:32:30', 14);
INSERT INTO `sys_oper_log` VALUES (272, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":22,\"categoryName\":\"游戏本\",\"createTime\":\"2026-03-08 21:32:51\",\"params\":{},\"parentId\":21,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:32:51', 12);
INSERT INTO `sys_oper_log` VALUES (273, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":23,\"categoryName\":\"台式机\",\"createTime\":\"2026-03-08 21:33:47\",\"params\":{},\"parentId\":21,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:33:47', 12);
INSERT INTO `sys_oper_log` VALUES (274, '分类', 2, 'com.ruoyi.web.controller.rental.RentalCategoryController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":22,\"categoryName\":\"笔记本\",\"createBy\":\"\",\"createTime\":\"2026-03-08 21:32:51\",\"delFlag\":\"0\",\"params\":{},\"parentId\":21,\"sortOrder\":0,\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2026-03-08 21:34:14\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:34:14', 11);
INSERT INTO `sys_oper_log` VALUES (275, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":24,\"categoryName\":\"游戏掌机\",\"createTime\":\"2026-03-08 21:34:59\",\"params\":{},\"parentId\":9,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:34:59', 11);
INSERT INTO `sys_oper_log` VALUES (276, '分类', 2, 'com.ruoyi.web.controller.rental.RentalCategoryController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":12,\"categoryName\":\"游戏手柄\",\"createBy\":\"\",\"createTime\":\"2026-03-08 21:15:29\",\"delFlag\":\"0\",\"params\":{},\"parentId\":9,\"sortOrder\":0,\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2026-03-08 21:35:13\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:35:13', 7);
INSERT INTO `sys_oper_log` VALUES (277, '分类', 2, 'com.ruoyi.web.controller.rental.RentalCategoryController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":12,\"categoryName\":\"游戏手柄\",\"createBy\":\"\",\"createTime\":\"2026-03-08 21:15:29\",\"delFlag\":\"0\",\"params\":{},\"parentId\":9,\"sortOrder\":0,\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2026-03-08 21:35:28\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:35:28', 9);
INSERT INTO `sys_oper_log` VALUES (278, '分类', 2, 'com.ruoyi.web.controller.rental.RentalCategoryController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":12,\"categoryName\":\"游戏手柄\",\"createBy\":\"\",\"createTime\":\"2026-03-08 21:15:29\",\"delFlag\":\"0\",\"params\":{},\"parentId\":9,\"sortOrder\":0,\"status\":\"0\",\"updateBy\":\"\",\"updateTime\":\"2026-03-08 21:35:37\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:35:37', 9);
INSERT INTO `sys_oper_log` VALUES (279, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":25,\"categoryName\":\"无人机\",\"createTime\":\"2026-03-08 21:36:49\",\"params\":{},\"parentId\":4,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:36:49', 10);
INSERT INTO `sys_oper_log` VALUES (280, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":26,\"categoryName\":\"运动相机\",\"createTime\":\"2026-03-08 21:37:02\",\"params\":{},\"parentId\":4,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:37:02', 11);
INSERT INTO `sys_oper_log` VALUES (281, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":27,\"categoryName\":\"全景相机\",\"createTime\":\"2026-03-08 21:37:14\",\"params\":{},\"parentId\":4,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:37:14', 10);
INSERT INTO `sys_oper_log` VALUES (282, '分类', 1, 'com.ruoyi.web.controller.rental.RentalCategoryController.add()', 'POST', 1, 'admin', '总管理员', '/rental/category', '127.0.0.1', '内网IP', '{\"categoryId\":28,\"categoryName\":\"云台相机\",\"createTime\":\"2026-03-08 21:37:25\",\"params\":{},\"parentId\":4,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 21:37:25', 6);
INSERT INTO `sys_oper_log` VALUES (283, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Epson\",\"categoryId\":8,\"categoryName\":\"投影仪\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":100,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"商务投影仪，高亮度，适合会议室使用\",\"equipmentId\":5,\"equipmentName\":\"Epson投影仪 EB-2250U\",\"images\":\"[\\\"/images/epson-1.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/5_20260115183226A005.jpg\",\"model\":\"EB-2250U\",\"monthlyPrice\":2000,\"params\":{},\"rentalNotes\":\"包含HDMI线和遥控器\",\"rentedCount\":0,\"specifications\":\"{\\\"brightness\\\":\\\"5000流明\\\",\\\"resolution\\\":\\\"1920x1200\\\",\\\"contrast\\\":\\\"15000:1\\\",\\\"lamp_life\\\":\\\"10000小时\\\"}\",\"status\":\"0\",\"stock\":10,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-08 22:10:26\",\"weeklyPrice\":600} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 22:10:27', 27);
INSERT INTO `sys_oper_log` VALUES (284, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '总管理员', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-03-08 22:31:37', 17);
INSERT INTO `sys_oper_log` VALUES (285, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 22:31:46', 20);
INSERT INTO `sys_oper_log` VALUES (286, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '总管理员', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-03-08 22:31:50', 6);
INSERT INTO `sys_oper_log` VALUES (287, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 22:32:01', 7);
INSERT INTO `sys_oper_log` VALUES (288, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 22:32:19', 13);
INSERT INTO `sys_oper_log` VALUES (289, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-29 15:07:16\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 22:40:31', 10);
INSERT INTO `sys_oper_log` VALUES (290, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '总管理员', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-14 15:11:23\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"租赁管理\",\"menuType\":\"M\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"path\":\"rental\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-08 22:40:53', 14);
INSERT INTO `sys_oper_log` VALUES (291, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/12', '127.0.0.1', '内网IP', '12 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-09 02:20:17', 62);
INSERT INTO `sys_oper_log` VALUES (292, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/11', '127.0.0.1', '内网IP', '11 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-09 02:20:19', 35);
INSERT INTO `sys_oper_log` VALUES (293, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '123456', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":12,\"params\":{},\"returnExpressCompany\":\"顺丰速运\",\"returnExpressNo\":\"424242424242424242\",\"updateBy\":\"123456\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-09 02:25:00', 22);
INSERT INTO `sys_oper_log` VALUES (294, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"华为\",\"categoryId\":17,\"createTime\":\"2026-03-14 20:09:25\",\"dailyPrice\":13,\"deposit\":1000,\"description\":\"华为\",\"equipmentId\":6,\"equipmentName\":\"华为Mate 80\",\"mainImage\":\"/profile/upload/2026/03/14/华为_20260314200923A001.jpg\",\"model\":\"Mate 80\",\"monthlyPrice\":500,\"params\":{},\"status\":\"0\",\"stock\":7,\"weeklyPrice\":14} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:09:26', 179);
INSERT INTO `sys_oper_log` VALUES (295, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"iQOO\",\"categoryId\":17,\"createTime\":\"2026-03-14 20:35:02\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"15 Ultra\",\"equipmentId\":7,\"equipmentName\":\"iQOO 15 Ultra\",\"mainImage\":\"/profile/upload/2026/03/14/iQOO 15 Ultra_20260314203501A002.jpg\",\"model\":\"15 Ultra\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":3,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:35:02', 192);
INSERT INTO `sys_oper_log` VALUES (296, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"iQOO\",\"categoryId\":17,\"categoryName\":\"手机\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:35:02\",\"dailyPrice\":1,\"delFlag\":\"0\",\"deposit\":1,\"description\":\"CPU型号\\t骁龙 8 Elite Gen5更多骁龙 8 Elite Gen5手机>，手机性能排行>\\nCPU频率\\t2×Prime 4.6GHz+6×Performance 3.62GHz\\nCPU核心数\\t八核>\\nGPU型号\\t高通 Adreno 840\\nRAM容量\\t16GB>游戏运行流畅\\nRAM存储类型\\tLPDDR5X Ultra Pro 四通道>\\nROM容量\\t256GB>5.2万张照片2.2万首歌曲\\nROM存储类型\\tUFS 4.1>\\n存储卡\\t不支持容量扩展>\\n出厂系统内核\\tAndroid 16\\n操作系统\\tOriginOS 6\\n散热\\t冰穹风冷散热系统+8K冰穹VC\\n振动马达\\t战锤MAX双轴马达\\n扬声器\\t立体声双扬声器\\n其他硬件参数\\t独立显示芯片：自研电竞芯片 Q3，支持16GB内存融合\",\"equipmentId\":7,\"equipmentName\":\"iQOO 15 Ultra\",\"mainImage\":\"/profile/upload/2026/03/14/iQOO 15 Ultra_20260314203501A002.jpg\",\"model\":\"15 Ultra\",\"monthlyPrice\":1,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":3,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 20:40:25\",\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:40:25', 22);
INSERT INTO `sys_oper_log` VALUES (297, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"iQOO\",\"categoryId\":17,\"categoryName\":\"手机\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:35:02\",\"dailyPrice\":1,\"delFlag\":\"0\",\"deposit\":1,\"description\":\"CPU型号\\t骁龙 8 Elite Gen5更多骁龙 8 \\nCPU频率\\t2×Prime 4.6GHz+6×Performance 3.62GHz\\nCPU核心数\\t八核\\nGPU型号\\t高通 Adreno 840\\nRAM容量\\t16GB\\nRAM存储类型\\tLPDDR5X Ultra Pro 四通道\\nROM容量\\t256GB>5.2万张照片2.2万首歌曲\\nROM存储类型\\tUFS 4.1\\n存储卡\\t不支持容量扩展\\n出厂系统内核\\tAndroid 16\\n操作系统\\tOriginOS 6\\n散热\\t冰穹风冷散热系统+8K冰穹VC\\n振动马达\\t战锤MAX双轴马达\\n扬声器\\t立体声双扬声器\\n其他硬件参数\\t独立显示芯片：自研电竞芯片 Q3，支持16GB内存融合\",\"equipmentId\":7,\"equipmentName\":\"iQOO 15 Ultra\",\"mainImage\":\"/profile/upload/2026/03/14/iQOO 15 Ultra_20260314203501A002.jpg\",\"model\":\"15 Ultra\",\"monthlyPrice\":1,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":3,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-14 20:41:21\",\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:41:21', 8);
INSERT INTO `sys_oper_log` VALUES (298, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"OPPO\",\"categoryId\":17,\"createTime\":\"2026-03-14 20:45:03\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"OPPO Find X9 Pro\",\"equipmentId\":8,\"equipmentName\":\"OPPO Find X9 Pro\",\"mainImage\":\"/profile/upload/2026/03/14/OPPO Find X9 Pro_20260314204501A003.jpg\",\"model\":\"Find X9 Pro\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":1,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:45:03', 8);
INSERT INTO `sys_oper_log` VALUES (299, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"iPhone\",\"categoryId\":17,\"createTime\":\"2026-03-14 20:47:07\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"iPhone 17 Pro Max\",\"equipmentId\":9,\"equipmentName\":\"iPhone 17 Pro Max\",\"mainImage\":\"/profile/upload/2026/03/14/iPhone 17 Pro Max_20260314204704A004.jpg\",\"model\":\"17 Pro Max\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":1,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:47:08', 17);
INSERT INTO `sys_oper_log` VALUES (300, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Redmi\",\"categoryId\":17,\"createTime\":\"2026-03-14 20:48:42\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"Redmi Turbo 5 MAX\",\"equipmentId\":10,\"equipmentName\":\"Redmi Turbo 5 MAX\",\"mainImage\":\"/profile/upload/2026/03/14/Redmi Turbo 5 MAX_20260314204831A005.jpg\",\"model\":\"Turbo 5 MAX\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":1,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:48:42', 9);
INSERT INTO `sys_oper_log` VALUES (301, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"荣耀\",\"categoryId\":17,\"createTime\":\"2026-03-14 20:50:06\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"荣耀Power2\",\"equipmentId\":11,\"equipmentName\":\"荣耀Power2\",\"mainImage\":\"/profile/upload/2026/03/14/荣耀Power2_20260314205000A006.jpg\",\"model\":\"Power2\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":1,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:50:06', 15);
INSERT INTO `sys_oper_log` VALUES (302, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"iPhone\",\"categoryId\":20,\"createTime\":\"2026-03-14 20:53:34\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"Watch Series 11\",\"equipmentId\":12,\"equipmentName\":\"iPhone Watch Series 11\",\"mainImage\":\"/profile/upload/2026/03/14/苹果Watch Series 11_20260314205331A007.jpg\",\"model\":\"Watch Series 11\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":2,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:53:34', 11);
INSERT INTO `sys_oper_log` VALUES (303, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\" 联想\",\"categoryId\":22,\"createTime\":\"2026-03-14 20:56:03\",\"dailyPrice\":1,\"deposit\":1,\"description\":\" 联想拯救者R9000P 2025 AI元启\",\"equipmentId\":13,\"equipmentName\":\" 联想拯救者R9000P 2025 AI元启\",\"mainImage\":\"/profile/upload/2026/03/14/联想拯救者R9000P 2025 AI元启_20260314205558A008.jpg\",\"model\":\"拯救者R9000P 2025 AI元启\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":2,\"weeklyPrice\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:56:03', 17);
INSERT INTO `sys_oper_log` VALUES (304, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"索尼\",\"categoryId\":12,\"createTime\":\"2026-03-14 20:58:40\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"索尼PS5 PlayStation DualSense无线游戏手柄\",\"equipmentId\":14,\"equipmentName\":\"索尼PS5 PlayStation DualSense无线游戏手柄\",\"mainImage\":\"/profile/upload/2026/03/14/索尼PS5 PlayStation DualSense无线游戏手柄_20260314205839A009.jpg\",\"model\":\"PS5 PlayStation DualSense无线游戏手柄\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":1,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 20:58:40', 8);
INSERT INTO `sys_oper_log` VALUES (305, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"北通\",\"categoryId\":12,\"createTime\":\"2026-03-14 21:02:03\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"北通阿修罗2无线游戏手柄\",\"equipmentId\":15,\"equipmentName\":\"北通阿修罗2无线游戏手柄\",\"mainImage\":\"/profile/upload/2026/03/14/北通阿修罗2无线游戏手柄_20260314210131A010.jpg\",\"model\":\"阿修罗2无线游戏手柄\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":1,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 21:02:03', 8);
INSERT INTO `sys_oper_log` VALUES (306, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"任天堂\",\"categoryId\":24,\"createTime\":\"2026-03-14 21:05:03\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"任天堂Switch 2\",\"equipmentId\":16,\"equipmentName\":\"任天堂Switch 2\",\"mainImage\":\"/profile/upload/2026/03/14/任天堂Switch 2_20260314210501A011.jpg\",\"model\":\"Switch 2\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":1,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-14 21:05:03', 12);
INSERT INTO `sys_oper_log` VALUES (307, '设备', 1, 'com.ruoyi.web.controller.rental.RentalEquipmentController.add()', 'POST', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"华为\",\"categoryId\":18,\"createTime\":\"2026-03-15 00:19:33\",\"dailyPrice\":1,\"deposit\":1,\"description\":\"华为MatePad Mini\",\"equipmentId\":17,\"equipmentName\":\"华为MatePad Mini\",\"mainImage\":\"/profile/upload/2026/03/15/华为MatePad Mini_20260315001915A001.jpg\",\"model\":\"MatePad Mini\",\"monthlyPrice\":1,\"params\":{},\"status\":\"0\",\"stock\":2,\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:19:33', 21);
INSERT INTO `sys_oper_log` VALUES (308, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"华为\",\"categoryId\":18,\"categoryName\":\"平板\",\"createBy\":\"\",\"createTime\":\"2026-03-15 00:19:33\",\"dailyPrice\":1,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"华为MatePad Mini\",\"equipmentId\":17,\"equipmentName\":\"华为MatePad Mini\",\"mainImage\":\"/profile/upload/2026/03/15/华为MatePad Mini_20260315001915A001.jpg\",\"model\":\"MatePad Mini\",\"monthlyPrice\":1,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":2,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:40:44\",\"weeklyPrice\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:40:45', 25);
INSERT INTO `sys_oper_log` VALUES (309, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"华为\",\"categoryId\":18,\"categoryName\":\"平板\",\"createBy\":\"\",\"createTime\":\"2026-03-15 00:19:33\",\"dailyPrice\":8.76,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"华为MatePad Mini\",\"equipmentId\":17,\"equipmentName\":\"华为MatePad Mini\",\"mainImage\":\"/profile/upload/2026/03/15/华为MatePad Mini_20260315001915A001.jpg\",\"model\":\"MatePad Mini\",\"monthlyPrice\":240,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":5,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:41:53\",\"weeklyPrice\":56} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:41:53', 14);
INSERT INTO `sys_oper_log` VALUES (310, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"任天堂\",\"categoryId\":24,\"categoryName\":\"游戏掌机\",\"createBy\":\"\",\"createTime\":\"2026-03-14 21:05:03\",\"dailyPrice\":12.33,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"任天堂Switch 2\",\"equipmentId\":16,\"equipmentName\":\"任天堂Switch 2\",\"mainImage\":\"/profile/upload/2026/03/14/任天堂Switch 2_20260314210501A011.jpg\",\"model\":\"Switch 2\",\"monthlyPrice\":360,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":1,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:42:24\",\"weeklyPrice\":84} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:42:24', 0);
INSERT INTO `sys_oper_log` VALUES (311, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"索尼\",\"categoryId\":12,\"categoryName\":\"游戏手柄\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:58:40\",\"dailyPrice\":5.75,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"索尼PS5 PlayStation DualSense无线游戏手柄\",\"equipmentId\":14,\"equipmentName\":\"索尼PS5 PlayStation DualSense无线游戏手柄\",\"mainImage\":\"/profile/upload/2026/03/14/索尼PS5 PlayStation DualSense无线游戏手柄_20260314205839A009.jpg\",\"model\":\"PS5 PlayStation DualSense无线游戏手柄\",\"monthlyPrice\":150,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":5,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:43:30\",\"weeklyPrice\":35} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:43:30', 0);
INSERT INTO `sys_oper_log` VALUES (312, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\" 联想\",\"categoryId\":22,\"categoryName\":\"笔记本\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:56:03\",\"dailyPrice\":43.48,\"delFlag\":\"0\",\"deposit\":8000,\"description\":\" 联想拯救者R9000P 2025 AI元启\",\"equipmentId\":13,\"equipmentName\":\" 联想拯救者R9000P 2025 AI元启\",\"mainImage\":\"/profile/upload/2026/03/14/联想拯救者R9000P 2025 AI元启_20260314205558A008.jpg\",\"model\":\"拯救者R9000P 2025 AI元启\",\"monthlyPrice\":1200,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":2,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:44:02\",\"weeklyPrice\":280} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:44:02', 8);
INSERT INTO `sys_oper_log` VALUES (313, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"荣耀\",\"categoryId\":17,\"categoryName\":\"手机\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:50:06\",\"dailyPrice\":5.92,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"荣耀Power2\",\"equipmentId\":11,\"equipmentName\":\"荣耀Power2\",\"mainImage\":\"/profile/upload/2026/03/14/荣耀Power2_20260314205000A006.jpg\",\"model\":\"Power2\",\"monthlyPrice\":150,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":5,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:44:47\",\"weeklyPrice\":40} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:44:47', 10);
INSERT INTO `sys_oper_log` VALUES (314, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Redmi\",\"categoryId\":17,\"categoryName\":\"手机\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:48:42\",\"dailyPrice\":5.48,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"Redmi Turbo 5 MAX\",\"equipmentId\":10,\"equipmentName\":\"Redmi Turbo 5 MAX\",\"mainImage\":\"/profile/upload/2026/03/14/Redmi Turbo 5 MAX_20260314204831A005.jpg\",\"model\":\"Turbo 5 MAX\",\"monthlyPrice\":150,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":3,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:45:31\",\"weeklyPrice\":35} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:45:31', 0);
INSERT INTO `sys_oper_log` VALUES (315, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"iPhone\",\"categoryId\":17,\"categoryName\":\"手机\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:47:07\",\"dailyPrice\":21.92,\"delFlag\":\"0\",\"deposit\":9000,\"description\":\"iPhone 17 Pro Max\",\"equipmentId\":9,\"equipmentName\":\"iPhone 17 Pro Max\",\"mainImage\":\"/profile/upload/2026/03/14/iPhone 17 Pro Max_20260314204704A004.jpg\",\"model\":\"17 Pro Max\",\"monthlyPrice\":600,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":4,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:46:06\",\"weeklyPrice\":140} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:46:06', 7);
INSERT INTO `sys_oper_log` VALUES (316, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"OPPO\",\"categoryId\":17,\"categoryName\":\"手机\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:45:03\",\"dailyPrice\":11.61,\"delFlag\":\"0\",\"deposit\":6000,\"description\":\"OPPO Find X9 Pro\",\"equipmentId\":8,\"equipmentName\":\"OPPO Find X9 Pro\",\"mainImage\":\"/profile/upload/2026/03/14/OPPO Find X9 Pro_20260314204501A003.jpg\",\"model\":\"Find X9 Pro\",\"monthlyPrice\":300,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":5,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:46:33\",\"weeklyPrice\":77} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:46:33', 1);
INSERT INTO `sys_oper_log` VALUES (317, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"iPhone\",\"categoryId\":20,\"categoryName\":\"手表\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:53:34\",\"dailyPrice\":4.6,\"delFlag\":\"0\",\"deposit\":2000,\"description\":\"Watch Series 11\",\"equipmentId\":12,\"equipmentName\":\"iPhone Watch Series 11\",\"mainImage\":\"/profile/upload/2026/03/14/苹果Watch Series 11_20260314205331A007.jpg\",\"model\":\"Watch Series 11\",\"monthlyPrice\":120,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":2,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:46:58\",\"weeklyPrice\":28} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:46:58', 6);
INSERT INTO `sys_oper_log` VALUES (318, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"北通\",\"categoryId\":12,\"categoryName\":\"游戏手柄\",\"createBy\":\"\",\"createTime\":\"2026-03-14 21:02:03\",\"dailyPrice\":1.4,\"delFlag\":\"0\",\"deposit\":200,\"description\":\"北通阿修罗2无线游戏手柄\",\"equipmentId\":15,\"equipmentName\":\"北通阿修罗2无线游戏手柄\",\"mainImage\":\"/profile/upload/2026/03/14/北通阿修罗2无线游戏手柄_20260314210131A010.jpg\",\"model\":\"阿修罗2无线游戏手柄\",\"monthlyPrice\":30,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":3,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:47:30\",\"weeklyPrice\":7} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:47:30', 0);
INSERT INTO `sys_oper_log` VALUES (319, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"iQOO\",\"categoryId\":17,\"categoryName\":\"手机\",\"createBy\":\"\",\"createTime\":\"2026-03-14 20:35:02\",\"dailyPrice\":9.2,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"CPU型号\\t骁龙 8 Elite Gen5更多骁龙 8 \\nCPU频率\\t2×Prime 4.6GHz+6×Performance 3.62GHz\\nCPU核心数\\t八核\\nGPU型号\\t高通 Adreno 840\\nRAM容量\\t16GB\\nRAM存储类型\\tLPDDR5X Ultra Pro 四通道\\nROM容量\\t256GB>5.2万张照片2.2万首歌曲\\nROM存储类型\\tUFS 4.1\\n存储卡\\t不支持容量扩展\\n出厂系统内核\\tAndroid 16\\n操作系统\\tOriginOS 6\\n散热\\t冰穹风冷散热系统+8K冰穹VC\\n振动马达\\t战锤MAX双轴马达\\n扬声器\\t立体声双扬声器\\n其他硬件参数\\t独立显示芯片：自研电竞芯片 Q3，支持16GB内存融合\",\"equipmentId\":7,\"equipmentName\":\"iQOO 15 Ultra\",\"mainImage\":\"/profile/upload/2026/03/14/iQOO 15 Ultra_20260314203501A002.jpg\",\"model\":\"15 Ultra\",\"monthlyPrice\":270,\"params\":{},\"rentedCount\":0,\"status\":\"0\",\"stock\":3,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:48:07\",\"weeklyPrice\":60} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:48:07', 8);
INSERT INTO `sys_oper_log` VALUES (320, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Epson\",\"categoryId\":8,\"categoryName\":\"投影仪\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":32,\"delFlag\":\"0\",\"deposit\":3000,\"description\":\"商务投影仪，高亮度，适合会议室使用\",\"equipmentId\":5,\"equipmentName\":\"Epson投影仪 EB-2250U\",\"images\":\"[\\\"/images/epson-1.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/5_20260115183226A005.jpg\",\"model\":\"EB-2250U\",\"monthlyPrice\":900,\"params\":{},\"rentalNotes\":\"包含HDMI线和遥控器\",\"rentedCount\":0,\"specifications\":\"{\\\"brightness\\\":\\\"5000流明\\\",\\\"resolution\\\":\\\"1920x1200\\\",\\\"contrast\\\":\\\"15000:1\\\",\\\"lamp_life\\\":\\\"10000小时\\\"}\",\"status\":\"0\",\"stock\":10,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:56:24\",\"weeklyPrice\":210} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:56:24', 7);
INSERT INTO `sys_oper_log` VALUES (321, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Sony\",\"categoryId\":5,\"categoryName\":\"单反相机\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":25,\"delFlag\":\"0\",\"deposit\":12000,\"description\":\"索尼全画幅微单，视频拍摄性能优秀\",\"equipmentId\":4,\"equipmentName\":\"Sony A7M4\",\"images\":\"[\\\"/images/sony-1.jpg\\\",\\\"/images/sony-2.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/4_20260115183135A004.jpg\",\"model\":\"A7 Mark IV\",\"monthlyPrice\":550,\"params\":{},\"rentalNotes\":\"镜头需单独租赁\",\"rentedCount\":0,\"specifications\":\"{\\\"sensor\\\":\\\"全画幅 33MP\\\",\\\"video\\\":\\\"4K 60fps\\\",\\\"iso\\\":\\\"100-51200\\\",\\\"stabilization\\\":\\\"机身5轴防抖\\\"}\",\"status\":\"0\",\"stock\":4,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:56:38\",\"weeklyPrice\":150} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:56:38', 6);
INSERT INTO `sys_oper_log` VALUES (322, '设备', 2, 'com.ruoyi.web.controller.rental.RentalEquipmentController.edit()', 'PUT', 1, 'admin', '总管理员', '/rental/equipment', '127.0.0.1', '内网IP', '{\"brand\":\"Canon\",\"categoryId\":5,\"categoryName\":\"单反相机\",\"createBy\":\"admin\",\"createTime\":\"2025-12-31 19:19:01\",\"dailyPrice\":30,\"delFlag\":\"0\",\"deposit\":15000,\"description\":\"专业级全画幅微单相机，支持8K视频拍摄\",\"equipmentId\":3,\"equipmentName\":\"Canon EOS R5\",\"images\":\"[\\\"/images/canon-1.jpg\\\",\\\"/images/canon-2.jpg\\\"]\",\"mainImage\":\"/profile/upload/2026/01/15/3_20260115183106A003.jpg\",\"model\":\"EOS R5\",\"monthlyPrice\":650,\"params\":{},\"rentalNotes\":\"请配合使用原装电池和存储卡\",\"rentedCount\":0,\"specifications\":\"{\\\"sensor\\\":\\\"全画幅 45MP\\\",\\\"video\\\":\\\"8K 30fps\\\",\\\"iso\\\":\\\"100-51200\\\",\\\"stabilization\\\":\\\"机身5轴防抖\\\"}\",\"status\":\"0\",\"stock\":3,\"totalRented\":0,\"updateBy\":\"\",\"updateTime\":\"2026-03-15 00:56:49\",\"weeklyPrice\":180} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 00:56:49', 5);
INSERT INTO `sys_oper_log` VALUES (323, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":19,\"createTime\":\"2026-03-15 11:05:25\",\"equipmentId\":17,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 11:05:25', 24);
INSERT INTO `sys_oper_log` VALUES (324, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-03-15 11:05:52\",\"depositAmount\":3000,\"equipmentId\":17,\"equipmentName\":\"华为MatePad Mini\",\"orderId\":13,\"orderNo\":\"RO65585b7a2dba481786861d45d6685b53\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"124211414331414134\",\"receiverName\":\"123\",\"receiverPhone\":\"14341333333\",\"rentalAmount\":8.76,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":3008.76,\"unitPrice\":8.76,\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 11:05:52', 44);
INSERT INTO `sys_oper_log` VALUES (325, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/19', '127.0.0.1', '内网IP', '[19] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 11:05:52', 16);
INSERT INTO `sys_oper_log` VALUES (326, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '123456', '用户', '/rental/order/pay/13', '127.0.0.1', '内网IP', '13 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 11:05:55', 28);
INSERT INTO `sys_oper_log` VALUES (327, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/13', '127.0.0.1', '内网IP', '13 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 11:06:12', 24);
INSERT INTO `sys_oper_log` VALUES (328, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '123456', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":13,\"params\":{},\"returnExpressCompany\":\"顺丰速运\",\"returnExpressNo\":\"2222222222\",\"updateBy\":\"123456\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 11:06:23', 6);
INSERT INTO `sys_oper_log` VALUES (329, '确认收货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.confirmReturn()', 'PUT', 1, 'admin', '总管理员', '/rental/order/confirmReturn/13', '127.0.0.1', '内网IP', '13 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-15 11:06:30', 21);
INSERT INTO `sys_oper_log` VALUES (330, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":20,\"createTime\":\"2026-03-16 15:51:48\",\"equipmentId\":17,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-16 15:51:48', 18);
INSERT INTO `sys_oper_log` VALUES (331, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '总管理员', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-03-17 09:26:56', 24);
INSERT INTO `sys_oper_log` VALUES (332, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '总管理员', '/system/menu/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2026-03-17 09:27:15', 11);
INSERT INTO `sys_oper_log` VALUES (333, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":21,\"createTime\":\"2026-03-17 12:15:05\",\"equipmentId\":17,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-17 12:15:05', 32);
INSERT INTO `sys_oper_log` VALUES (334, '订单', 1, 'com.ruoyi.web.controller.rental.RentalOrderController.add()', 'POST', 1, '123456', '用户', '/rental/order', '127.0.0.1', '内网IP', '{\"createBy\":\"123456\",\"createTime\":\"2026-03-17 12:15:29\",\"depositAmount\":3000,\"equipmentId\":17,\"equipmentName\":\"华为MatePad Mini\",\"orderId\":14,\"orderNo\":\"ROd92a803181af4fe785d80d3273857741\",\"params\":{},\"quantity\":1,\"receiverAddress\":\"12413213eweqe\",\"receiverName\":\"1233\",\"receiverPhone\":\"13616555555\",\"rentalAmount\":8.76,\"rentalDays\":1,\"rentalType\":\"1\",\"status\":\"0\",\"totalAmount\":3008.76,\"unitPrice\":8.76,\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-17 12:15:30', 68);
INSERT INTO `sys_oper_log` VALUES (335, '购物车', 3, 'com.ruoyi.web.controller.rental.RentalCartController.remove()', 'DELETE', 1, '123456', '用户', '/rental/cart/20', '127.0.0.1', '内网IP', '[20] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-17 12:15:30', 20);
INSERT INTO `sys_oper_log` VALUES (336, '订单支付', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.pay()', 'PUT', 1, '123456', '用户', '/rental/order/pay/14', '127.0.0.1', '内网IP', '14 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-17 12:15:33', 27);
INSERT INTO `sys_oper_log` VALUES (337, '确认发货', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.ship()', 'PUT', 1, 'admin', '总管理员', '/rental/order/ship/14', '127.0.0.1', '内网IP', '14 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-17 12:15:51', 31);
INSERT INTO `sys_oper_log` VALUES (338, '申请归还', 2, 'com.ruoyi.web.controller.rental.RentalOrderController.applyReturn()', 'PUT', 1, '123456', '用户', '/rental/order/applyReturn', '127.0.0.1', '内网IP', '{\"orderId\":14,\"params\":{},\"returnExpressCompany\":\"顺丰速运\",\"returnExpressNo\":\"12323123131231321312\",\"updateBy\":\"123456\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-17 12:16:02', 12);
INSERT INTO `sys_oper_log` VALUES (339, '购物车', 1, 'com.ruoyi.web.controller.rental.RentalCartController.add()', 'POST', 1, '123456', '用户', '/rental/cart', '127.0.0.1', '内网IP', '{\"cartId\":22,\"createTime\":\"2026-03-17 12:19:11\",\"equipmentId\":17,\"params\":{},\"quantity\":1,\"rentalDays\":1,\"rentalType\":\"1\",\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-17 12:19:12', 8);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-12-29 15:07:16', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-12-29 15:07:16', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-12-29 15:07:16', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2000);
INSERT INTO `sys_role_menu` VALUES (1, 2001);
INSERT INTO `sys_role_menu` VALUES (1, 2010);
INSERT INTO `sys_role_menu` VALUES (1, 2020);
INSERT INTO `sys_role_menu` VALUES (1, 2030);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-03-17 11:59:23', '2025-12-29 15:07:16', 'admin', '2025-12-29 15:07:16', '', NULL, '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-12-29 15:07:16', '2025-12-29 15:07:16', 'admin', '2025-12-29 15:07:16', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 202, '123456', '123456', '00', '', '13646666666', '0', '', '$2a$10$S21hGtZWgbGl/TIkL0fNLu/aApR0WyLm3.h39I.GY5OsxnvRj.HsO', '0', '0', '127.0.0.1', '2026-03-20 20:49:39', NULL, 'admin', '2026-01-03 16:24:24', 'admin', '2026-01-15 18:19:08', NULL);
INSERT INTO `sys_user` VALUES (101, 202, '12345678', '12345678', '00', '', '', '0', '', '$2a$10$yBKsBvQdbwMrhQQcvrazbe9lrjCWlyqDmMQh3fb22UaE/S3ERkanW', '0', '2', '127.0.0.1', '2026-01-15 18:18:43', '2026-01-15 18:18:29', '', '2026-01-15 18:18:29', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (102, 202, '1234567', '1234567', '00', '', '', '0', '', '$2a$10$M/vfvk6vYYof8Z6t9FG3P.VjQ76n3BQFOu2zzJ5XkwlgmzchBRp6.', '0', '0', '127.0.0.1', '2026-01-15 19:30:30', '2026-01-15 19:30:01', '', '2026-01-15 19:30:01', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (103, 202, '12345', '12345', '00', '', '', '0', '', '$2a$10$gmW4yICB2H/J.KvV2mkZW.StmqS6QPX0ycRd7lT8phBuloOtin6Le', '0', '0', '127.0.0.1', '2026-03-15 00:33:18', '2026-01-15 20:15:07', '', '2026-01-15 20:15:06', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (104, 202, '112233', '112233', '00', '', '', '0', '', '$2a$10$fKHoXWCyvf7CmmC873Zlc.aynqdM9TrqadPn0OhM4ApxuHS0bCBh.', '0', '0', '127.0.0.1', '2026-01-15 20:21:12', '2026-01-15 20:21:06', '', '2026-01-15 20:21:05', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (105, 202, '111111', '111111', '00', '', '', '0', '', '$2a$10$hSKvnagMtkM4tIUwT/lfJOkOCJWoyzc5rR/kyhBgq9q99qMoOBTQ2', '0', '0', '127.0.0.1', '2026-01-15 21:09:53', '2026-01-15 21:09:37', '', '2026-01-15 21:09:37', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (106, 202, '11112222', '11112222', '00', '', '', '0', '', '$2a$10$O7F8bvx7d7D9bDsMqZQyyeRKZPqEsBCSKzTDm/1vC.MhT/F.vJDwS', '0', '0', '127.0.0.1', '2026-01-16 11:31:40', '2026-01-16 11:31:25', '', '2026-01-16 11:31:25', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (107, 202, '22222222', '22222222', '00', '', '', '0', '', '$2a$10$klvXekujweFKKjXxZ1VJLu7WpjIAxYe6ydJFG8nSpN34pbizAVMk.', '0', '0', '127.0.0.1', '2026-01-16 11:38:10', '2026-01-16 11:37:50', '', '2026-01-16 11:37:50', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (108, 202, '33333333', '33333333', '00', '', '', '0', '', '$2a$10$oqKkMC78bb7MuLfBETnqheaj7JmxBsXS5nv4xaeeg.cWp3mgsSiNa', '0', '0', '127.0.0.1', '2026-01-16 11:40:16', '2026-01-16 11:39:48', '', '2026-01-16 11:39:48', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

SET FOREIGN_KEY_CHECKS = 1;
