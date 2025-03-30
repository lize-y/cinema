-- 创建数据库
CREATE DATABASE IF NOT EXISTS `movie_ticket_system`;

-- 使用数据库
USE `movie_ticket_system`;

-- 创建电影表
CREATE TABLE IF NOT EXISTS `movie` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '电影id',
    `name` VARCHAR(64) NOT NULL COMMENT '电影名称',
    `aka_name` VARCHAR(64) COMMENT '电影又名',
    `intro` VARCHAR(256) COMMENT '电影简介',
    `poster` VARCHAR(256) COMMENT '电影海报',
    `director` VARCHAR(64) COMMENT '导演',
    `actor` VARCHAR(256) COMMENT '演员',
    `date` DATE NOT NULL COMMENT '上映日期',
    `area` VARCHAR(32) COMMENT '地区',
    `language` VARCHAR(16) COMMENT '语言',
    `duration` INT NOT NULL COMMENT '电影时长',
    `company` VARCHAR(128) COMMENT '发行公司',
    `key_disabled_date` DATETIME NOT NULL COMMENT '密钥失效时间'
);

-- 创建电影类型表
CREATE TABLE IF NOT EXISTS `movie_type` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '电影类型id',
    `name` VARCHAR(32) NOT NULL COMMENT '电影类型名称'
);

-- 创建电影-类型关联表（复合主键）
CREATE TABLE IF NOT EXISTS `movie_type_conn` (
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    `type_id` BIGINT NOT NULL COMMENT '类型id',
    PRIMARY KEY (`movie_id`, `type_id`),
    FOREIGN KEY (`movie_id`) REFERENCES `movie`(`id`),
    FOREIGN KEY (`type_id`) REFERENCES `movie_type`(`id`)
);

-- 创建影厅表
CREATE TABLE IF NOT EXISTS `hall` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '影厅id',
    `name` VARCHAR(32) NOT NULL COMMENT '影厅名称',
    `seating` INT NOT NULL COMMENT '座位数'
);

-- 创建座位表（添加唯一约束）
CREATE TABLE IF NOT EXISTS `seat` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '座位id',
    `hall_id` BIGINT NOT NULL COMMENT '所属影厅id',
    `row` INT NOT NULL COMMENT '行',
    `start_column` INT NOT NULL COMMENT '起始列',
    `end_column` INT NOT NULL COMMENT '结束列',
    FOREIGN KEY (`hall_id`) REFERENCES `hall`(`id`),
    UNIQUE KEY (`hall_id`, `row`, `start_column`, `end_column`)
);

-- 创建设备类型表
CREATE TABLE IF NOT EXISTS `equip_type` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '设备类型id',
    `name` VARCHAR(32) NOT NULL COMMENT '设备类型名称'
);

-- 创建设备表
CREATE TABLE IF NOT EXISTS `equipment` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '设备id',
    `hall_id` BIGINT NOT NULL COMMENT '所属影厅id',
    `type_id` BIGINT NOT NULL COMMENT '设备类型',
    `name` VARCHAR(64) NOT NULL COMMENT '设备名称',
    `status` ENUM('NORMAL','MAINTAINED','DISABLED') DEFAULT 'normal' NOT NULL COMMENT '状态：1:正常、2:维护中、3:已退役',
    `start_time` DATETIME COMMENT '初次投用时间',
    `last_check` DATETIME COMMENT '最后检修时间',
    FOREIGN KEY (`hall_id`) REFERENCES `hall`(`id`),
    FOREIGN KEY (`type_id`) REFERENCES `equip_type`(`id`)
);

-- 创建排片表（添加时间逻辑校验）
CREATE TABLE IF NOT EXISTS `schedule` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '排片id',
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    `hall_id` BIGINT NOT NULL COMMENT '影厅id',
    `start_time` DATETIME NOT NULL COMMENT '开始时间',
    `end_time` DATETIME NOT NULL COMMENT '结束时间',
    `price` DECIMAL(10,2) NOT NULL COMMENT '基票础价',
    `detail` VARCHAR(16) NOT NULL COMMENT '详情',
    -- 用一个bool表示能否用优惠
    `discount` BOOLEAN DEFAULT FALSE,
	`status` ENUM('disabled','enabled') DEFAULT 'disabled' NOT NULL COMMENT '状态：1:未生效、2:生效',
    FOREIGN KEY (`movie_id`) REFERENCES `movie`(`id`),
    FOREIGN KEY (`hall_id`) REFERENCES `hall`(`id`),
    CHECK (`start_time` < `end_time`)
);

-- 创建票价类型表
CREATE TABLE IF NOT EXISTS `ticket_type` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '票价类型id',
    `name` VARCHAR(32) NOT NULL COMMENT '类型名称',
    `discount` DECIMAL(3,2) NOT NULL COMMENT '折扣'
);

-- 创建票价策略表
CREATE TABLE IF NOT EXISTS `price_rule` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '票价策略id',
    `rule_name` VARCHAR(32) NOT NULL COMMENT '策略名称',
    `discount` DECIMAL(3,2) NOT NULL COMMENT '折扣',
    `start_time` DATETIME NOT NULL COMMENT '开始时间',
    `end_time` DATETIME NOT NULL COMMENT '结束时间',
    CHECK (`start_time` < `end_time`)
);

-- 创建策略-电影类型关联表
CREATE TABLE IF NOT EXISTS `movie_rule` (
    `rule_id` BIGINT NOT NULL COMMENT '策略id',
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    PRIMARY KEY (`rule_id`, `movie_type_id`),
    FOREIGN KEY (`rule_id`) REFERENCES `price_rule`(`id`),
    FOREIGN KEY (`movie、_id`) REFERENCES `movie_type`(`id`)
);

-- 创建策略-票价类型关联表
CREATE TABLE IF NOT EXISTS `ticket_rule` (
    `rule_id` BIGINT NOT NULL COMMENT '策略id',
    `ticket_type_id` BIGINT NOT NULL COMMENT '票价类型id',
    PRIMARY KEY (`rule_id`, `ticket_type_id`),
    FOREIGN KEY (`rule_id`) REFERENCES `price_rule`(`id`),
    FOREIGN KEY (`ticket_type_id`) REFERENCES `ticket_type`(`id`)
);

-- 创建用户表
CREATE TABLE IF NOT EXISTS `user` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '账号id',
    `username` VARCHAR(32) NOT NULL COMMENT '账号名称',
    `password` VARCHAR(64) NOT NULL COMMENT '账号密码',
    `phone` VARCHAR(15) COMMENT '电话',
    `age` INT COMMENT '年龄',
    `birthday` DATE COMMENT '生日',
    `email` VARCHAR(32) COMMENT '邮箱',
    `photo` VARCHAR(256) COMMENT '头像',
    `role` ENUM('normal','vip') DEFAULT 'normal' NOT NULL COMMENT '角色：1:普通用户，2:会员'
);

-- 创建管理员表
CREATE TABLE IF NOT EXISTS `admin` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '账号id',
    `username` VARCHAR(32) NOT NULL COMMENT '账号名称',
    `password` VARCHAR(64) NOT NULL COMMENT '账号密码',
    `phone` VARCHAR(15) NOT NULL COMMENT '电话',
    `name` VARCHAR(32) NOT NULL COMMENT '管理员姓名',
    `age` INT COMMENT '年龄',
    `birthday` DATE COMMENT '生日',
    `email` VARCHAR(32) COMMENT '邮箱',
    `role` ENUM('super_admin','admin') DEFAULT 'admin' NOT NULL COMMENT '角色：1:管理员，2:售票员'
);

-- 创建订单表
CREATE TABLE IF NOT EXISTS `order` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '订单id',
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    `payer_id` BIGINT NOT NULL COMMENT '下单用户id',
    `order_time` DATETIME NOT NULL COMMENT '下单时间',
    `pay_amount` DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
    `ticket_amount` INT NOT NULL COMMENT '电影票数',
    `pay_method` ENUM('cash','wechat_pay','ali_pay','creit_card') DEFAULT NULL COMMENT '支付方式：1:现金，2:微信，3:支付宝，4:信用卡',
    `status` ENUM('not_pay','paid','change_ticket','cancelled','changed','refuned','canceled') DEFAULT 'not_pay' NOT NULL COMMENT '状态：1:未支付，2:已支付，3:改签票，4:已核销，5:已改签，6:已退票，7:已取消',
    FOREIGN KEY (`movie_id`) REFERENCES `movie`(`id`)
);

-- 创建电影票表（添加状态校验）
CREATE TABLE IF NOT EXISTS `order_ticket` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '电影票id',
    `order_id` BIGINT NOT NULL COMMENT '所属订单id',
    `schedule_id` BIGINT NOT NULL COMMENT '排片场次id',
    `row` INT NOT NULL COMMENT '座位行',
    `column` INT NOT NULL COMMENT '座位列',
    `ticket_type` VARCHAR(16) COMMENT '票价类型',
    `ticket_price` DECIMAL(10,2) COMMENT '票价',
    `ticket_status` ENUM('enabled','disabled') DEFAULT 'enabled' NOT NULL COMMENT '电影票状态：1:有效，2:无效',
    FOREIGN KEY (`order_id`) REFERENCES `order`(`id`),
    FOREIGN KEY (`schedule_id`) REFERENCES `schedule`(`id`)
);

-- 创建退票改签表
CREATE TABLE IF NOT EXISTS `refund_exchange` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '主键id',
    `old_order_id` BIGINT NOT NULL COMMENT '旧订单id',
    `new_order_id` BIGINT COMMENT '新订单id',
    `processed_by` BIGINT NOT NULL COMMENT '操作人id',
    `operation_type` ENUM('changed','all_refunded','part_refunded') NOT NULL COMMENT '操作类型：1:改签、2:全额退票、3:手续费退票',
    `processed_time` DATETIME NOT NULL COMMENT '操作时间',
    `refund_amount` DECIMAL(10,2) COMMENT '退款金额',
    FOREIGN KEY (`old_order_id`) REFERENCES `order`(`id`),
    FOREIGN KEY (`new_order_id`) REFERENCES `order`(`id`),
    FOREIGN KEY (`processed_by`) REFERENCES `admin`(`id`)
);

-- 创建票房统计表
CREATE TABLE IF NOT EXISTS `box_office` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '主键id',
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    `income` DECIMAL(14,2) NOT NULL COMMENT '票房收入',
    `audience_amount` BIGINT NOT NULL COMMENT '观影人数',
    `schedule_amount` BIGINT NOT NULL COMMENT '场次',
    `data_time` DATETIME NOT NULL COMMENT '数据日期',
    FOREIGN KEY (`movie_id`) REFERENCES `movie`(`id`)
);

-- 创建索引优化
CREATE INDEX idx_seat ON `seat`(`hall_id`,`row`,`start_column`,`end_column`);
CREATE INDEX idx_orderticket_status ON `order_ticket`(`schedule_id`,`ticket_status`);
CREATE INDEX idx_orderticket_seat ON `order_ticket`(`schedule_id`,`row`,`column`,`ticket_status`);
CREATE INDEX idx_boxoffice_date ON `box_office`(`data_time`);



-- 插入电影类型
INSERT INTO `movie_type` (`id`, `name`) VALUES
(1, '全部'),
(2, '剧情'),
(3, '喜剧'),
(4, '爱情'),
(5, '动作'),
(6, '科幻'),
(7, '动画'),
(8, '悬疑'),
(9, '犯罪'),
(10, '惊悚'),
(11, '冒险'),
(12, '战争'),
(13, '纪录片'),
(14, '历史'),
(15, '奇幻'),
(16, '传记'),
(17, '情色'),
(18, '灾难'),
(19, '武侠'),
(20, '家庭'),
(21, '恐怖');

-- 插入电影数据（利用 AUTO_INCREMENT）
INSERT INTO `movie` (`id`,`name`, `aka_name`, `intro`, `poster`, `director`, `actor`, `date`, `area`, `duration`, `language`, `company`, `key_disabled_date`) VALUES
(1,'哪吒之魔童闹海', 'Ne Zha 2', '天劫之后，哪吒、敖丙的灵魂虽保住了，但肉身很快会魂飞魄散。太乙真人打算用七色宝莲给二人重塑肉身。但是在重塑肉身的过程中却遇到重重困难，哪吒、敖丙的命运将走向何方？', 
'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2916323291.jpg', '饺子', '吕艳婷,囧森瑟夫,瀚墨,陈浩,绿绮', '2025-01-29', '中国大陆', 144, '汉语普通话', '光线传媒', '2025-04-30 23:59:59'),
(2,'破·地狱', 'The Last Dance', '婚礼策划师道生（黄子华 饰）因婚礼市场萧条而债台高筑，被迫改行成为葬礼经纪人。红白二事大相径庭，令道生处处碰壁，但最难一关是要得到喃呒师傅文哥（许冠文 饰）的认可。
起初因为理念不合，道生与文哥冲突不断，两人的关系岌岌可危。但数次危难时刻文哥的出手相助，以及亲历文哥与女儿文玥（卫诗雅 饰）的相处点滴，道生与文哥之间的心结慢慢解开，也逐渐悟到“破地狱”的真正意义。', 
'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2915837972.jpg', '陈茂贤', '黄子华,许冠文,卫诗雅,朱栢康,周家怡', '2024-11-09', '中国香港', 126, '粤语', '英皇影业有限公司', '2025-04-14 23:59:59'),
(3,'美国队长4', 'Captain America 4', '能够展翅高飞的猎鹰山姆·威尔逊（安东尼·麦凯 Anthony Mackie 饰）受史蒂夫·罗杰斯的信任所托，接过盾牌，正式成为美国队长。
在与美国总统撒迪厄斯·罗斯（哈里森·福特 Harrison Ford 饰）会面后，山姆发现自己被卷入了一场国际事件。他必须赶在真正的幕后黑手让全世界陷入混乱之前查明真相，揭露这起波及全球的阴谋。', 
'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2915154169.jpg', '朱利叶斯·约拿', '安东尼·麦凯,哈里森·福特,丹尼·拉米雷斯,茜拉·哈斯,卡尔·鲁伯利', '2025-02-14', '美国', 119, '英语', '华特·迪士尼影片公司', '2025-05-9 23:59:59'),
(4,'还有明天', 'C\'è ancora domani', '1946年二战后的意大利，女性地位依旧低下。底层女性迪莉娅（宝拉·柯特莱西 Paola Cortellesi 饰），每日在丈夫的暴虐下和生活琐碎中艰难生存，
唯有女儿玛塞拉、朋友玛丽莎和每日难得的自由踱步是她痛苦生活中的慰藉……这时，迪莉娅意外收到一封神秘信件，一场出逃即将改变一切……', 
'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2918279456.jpg', '宝拉·柯特莱西', '宝拉·柯特莱西,瓦莱里奥·马斯坦德雷亚,罗马纳·马乔拉·韦尔加诺,埃马努艾拉·法内利,乔治·科兰杰利', '2023-10-26', ' 意大利', 118, '意大利语', 'Vision Distribution', '2025-05-14 23:59:59');

-- 关联电影与类型
INSERT INTO `movie_type_conn` (`movie_id`, `type_id`) VALUES
(1, 2),  -- 哪吒之魔童闹海 -> 剧情
(1, 3),  -- 哪吒之魔童闹海 -> 喜剧
(1, 7),  -- 哪吒之魔童闹海 -> 动画
(1, 15),  -- 哪吒之魔童闹海 -> 奇幻
(2, 2),  -- 破·地狱 -> 剧情
(2, 20),  -- 破·地狱 -> 家庭
(3, 5),  -- 美国队长4 -> 动作
(3, 6),  -- 美国队长4 -> 科幻
(3, 11),  -- 美国队长4 -> 冒险
(4, 2),  -- 还有明天 -> 剧情
(4, 3),  -- 还有明天 -> 喜剧
(4, 14);  -- 还有明天 -> 历史

-- 插入影厅数据
INSERT INTO `hall` (`id`, `name`, `seating`) VALUES
(1, '1号IMAX厅', 411),
(2, '2号杜比全景声厅', 394),
(3, '3号杜比全景声厅', 252),
(4, '4号4K激光厅', 89),
(5, '5号厅', 83);

-- 插入1号厅座位数据
INSERT INTO `seat` (`hall_id`, `row`, `start_column`, `end_column`) VALUES
(1, 1, 5, 29),(1, 2, 5, 29),(1, 3, 5, 29),(1, 4, 5, 29),(1, 5, 4, 29),
(1, 6, 3, 31),(1, 7, 1, 32),(1, 8, 1, 32),(1, 9, 1, 32),(1, 10, 1, 32),
(1, 11, 1, 32),(1, 12, 1, 32),(1, 13, 1, 32),(1, 14, 1, 32);

-- 插入2号厅座位数据
INSERT INTO `seat` (`hall_id`, `row`, `start_column`, `end_column`) VALUES
(2, 1, 6, 26),(2, 2, 6, 26),(2, 3, 4, 28),(2, 4, 4, 28),(2, 5, 4, 28),
(2, 6, 4, 28),(2, 8, 6, 26),(2, 9, 6, 26),(2, 10, 6, 26),(2, 11, 7, 25),
(2, 12, 1, 4),(2, 12, 7, 25),(2, 12, 28, 31),(2, 13, 1, 4),(2, 13, 7, 25),
(2, 13, 28, 31),(2, 14, 1, 4),(2, 14, 7, 25),(2, 14, 28, 31),(2, 15, 1, 4),
(2, 15, 7, 25),(2, 15, 28, 31),(2, 16, 1, 9),(2, 16, 12, 25),(2, 16, 28, 31);

-- 插入3号厅座位数据
INSERT INTO `seat` (`hall_id`, `row`, `start_column`, `end_column`) VALUES
(3, 1, 3, 23),(3, 2, 2, 24),(3, 3, 2, 24),(3, 4, 2, 24),(3, 5, 2, 24),
(3, 7, 2, 24),(3, 8, 2, 24),(3, 9, 2, 24),(3, 10, 2, 24),
(3, 11, 2, 24),(3, 12, 1, 16),(3, 12, 18, 25);

-- 插入4号厅座位数据
INSERT INTO `seat` (`hall_id`, `row`, `start_column`, `end_column`) VALUES
(4, 1, 1, 11),(4, 2, 1, 11),(4, 3, 1, 11),(4, 4, 1, 11),(4, 5, 1, 11),
(4, 6, 1, 11),(4, 7, 1, 11),(4, 8, 1, 12);

-- 插入5号厅座位数据
INSERT INTO `seat` (`hall_id`, `row`, `start_column`, `end_column`) VALUES
(5, 1, 1, 11),(5, 2, 1, 11),(5, 3, 1, 11),(5, 4, 1, 11),(5, 5, 1, 11),
(5, 6, 1, 11),(5, 7, 2, 10),(5, 8, 2, 9);

-- 插入设备类型和设备
INSERT INTO `equip_type` (`id`, `name`) VALUES
(1, '音响'),
(2, '灯光'),
(3, '投影'),
(4, '空调');

-- 设备基础数据（包含设备命名规范）
INSERT INTO `equipment` (`hall_id`, `type_id`, `name`, `status`, `start_time`, `last_check`) VALUES
/* 1号IMAX厅（411座） */
(1, 1, 'JBL主阵列音响', 1, '2024-03-01', '2025-03-10'),
(1, 1, 'BOSE环绕音响', 1, '2024-03-01', '2025-03-12'),
(1, 2, '飞利浦主舞台灯', 2, '2024-03-15', '2025-03-13'),
(1, 2, '欧司朗应急灯组', 1, '2024-04-01', '2025-02-28'),
(1, 3, '巴可DP4K-60L', 1, '2024-01-10', '2025-03-10'),
(1, 3, 'NEC备用投影', 2, '2024-06-01', '2025-01-15'),
(1, 4, '大金中央空调', 1, '2024-02-01', '2025-03-12'),

/* 2号杜比厅（394座） */
(2, 1, 'DOLBY全景声音柱', 1, '2024-05-01', '2025-03-11'),
(2, 2, 'RGB激光灯阵', 1, '2024-05-10', '2025-03-09'),
(2, 3, 'Christie 4K-HS', 1, '2024-04-20', '2025-03-13'),
(2, 4, '格力多联机', 1, '2024-03-25', '2025-02-28'),

/* 3号杜比厅（252座） */
(3, 1, '雅马哈环绕系统', 1, '2024-07-01', '2025-03-10'),
(3, 3, 'SONY VPL-GTZ380', 1, '2024-08-15', '2025-03-12'),
(3, 4, '美的分体空调', 1, '2024-06-01', '2025-01-30'),

/* 小型影厅设备 */
(4, 1, 'TOA基础音响', 1, '2024-09-01', '2025-02-28'),
(4, 3, '爱普生CB-700U', 1, '2024-10-01', '2025-03-10'),
(5, 1, '先锋基础音响', 3, '2023-12-01', '2024-12-31'),
(5, 3, '明基TK850', 1, '2024-11-01', '2025-03-11');

-- 插入排片数据
INSERT INTO `schedule` (`id`, `movie_id`, `hall_id`, `start_time`, `end_time`, `price`, `detail`, `status`) VALUES
(1, 1, 1, '2025-03-14 10:00:00', '2025-03-14 12:24:00', 89.00, '国语 3D', 'enabled'), -- 哪吒之魔童闹海（144分钟）
(2, 1, 2, '2025-03-14 13:30:00', '2025-03-14 15:54:00', 65.00, '国语 2D', 'enabled'),
(3, 2, 3, '2025-03-14 11:00:00', '2025-03-14 13:06:00', 45.00, '粤语 2D', 'enabled'), -- 破·地狱（126分钟）
(4, 3, 4, '2025-03-14 20:00:00', '2025-03-14 21:59:00', 75.00, '英语 3D', 'enabled'), -- 美国队长4（119分钟）
(5, 4, 5, '2025-03-14 09:30:00', '2025-03-14 11:28:00', 39.90, '原版 2D', 'enabled'); -- 还有明天（118分钟）

-- 插入票价类型与排片关联
INSERT INTO `ticket_type` (`id`, `name`, `discount`) VALUES
(1, '普通票', 1.00), (2, '学生票', 0.90), (3, '儿童票', 0.85), (4, '老年票', 0.85), (5, '会员票', 0.77);

INSERT INTO `schedule_ticket` (`schedule_id`, `ticket_type_id`) VALUES
(1,1), (1,2), (1,5), -- 支持全价/学生/会员
(2,1), (2,3),       -- 支持全价/儿童
(3,1), (3,2), (3,5), -- 支持全价/学生/会员
(4,1), (4,5),       -- 全价/会员
(5,1), (5,4);       -- 全价/老年

-- 插入用户和管理员
INSERT INTO `user` (`id`, `username`, `password`, `phone`, `nickname`, `age`, `birthday`, `email`, `role`) VALUES
(1, 'user01', '123456', '8613862488951', '影迷小王', 25, '2000-05-01', 'wang@example.com', 'normal'),
(2, 'vip_user', '123456', '8613912345678', '黄金会员', 32, '1993-08-15', 'vip@example.com', 'vip');

INSERT INTO `admin` (`id`, `username`, `password`, `phone`, `name`, `age`, `birthday`, `email`, `role`) VALUES
(40001, 'sysadmin', '123456', '8613745863518', '张二狗', 45, '1980-05-08', 'zhang@example.com', 'super_admin'),
(40002, 'cashier01', '123456', '8613888631496', '黄大剩', 35, '1990-09-01', 'huang@example.com', 'admin');

-- 插入订单数据（注意支付方式枚举值）
INSERT INTO `order` (`id`, `movie_id`, `payer_id`, `order_time`, `pay_amount`, `ticket_amount`, `pay_method`, `status`) VALUES
(1, 1, 40001, '2025-03-13 14:30:00', 267.00, 3, 'ali_pay', 'paid'),
(2, 3, 2, '2025-03-14 19:45:00', 150.00, 2, 'wechat_pay', 'paid'),
(3, 4, 1, '2025-03-12 14:30:00', 39.90, 2, 'ali_pay', 'refuned');

-- 插入电影票数据（验证保留字转义）
INSERT INTO `order_ticket` (`id`, `order_id`, `schedule_id`, `row`, `column`, `ticket_type`, `ticket_price`, `ticket_status`) VALUES
(1, 1, 1, 5, 12, '普通票', 89.00, 'enabled'),
(2, 1, 1, 5, 13, '普通票', 89.00, 'enabled'),
(3, 1, 1, 5, 14, '普通票', 89.00, 'enabled'),
(4, 2, 4, 8, 6, '普通票', 75.00, 'enabled'),
(5, 2, 4, 8, 7, '普通票', 75.00, 'enabled'),
(6, 3, 5, 5, 5, '普通票', 39.90, 'disabled');

-- 插入退票改签记录
INSERT INTO `refund_exchange` (`id`, `old_order_id`, `processed_by`, `operation_type`, `processed_time`, `refund_amount`) VALUES
(1, 3, 40002, 'all_refunded', '2025-03-12 19:00:00', 39.99);

-- 插入票房统计
INSERT INTO `box_office` (`movie_id`, `income`, `audience_amount`, `schedule_amount`, `data_time`) VALUES
(1, 135280.00, 1520, 8, '2025-03-13'), -- 哪吒日票房
(3, 73870.00, 830, 6, '2025-03-13'); -- 美国队长日票房
