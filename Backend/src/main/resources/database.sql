-- 电影表
DROP TABLE IF EXISTS movie;
CREATE TABLE IF NOT EXISTS `movie` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '电影id',
    `name` VARCHAR(64) NOT NULL COMMENT '电影名称',
    `aka_name` VARCHAR(64) COMMENT '电影又名',
    `intro` VARCHAR(256) COMMENT '电影简介',
    `poster_path` VARCHAR(256) COMMENT '电影海报',
    `date` DATE NOT NULL COMMENT '上映日期',
    `area` VARCHAR(32) COMMENT '地区',
    `language` VARCHAR(16) COMMENT '语言',
    `duration` INT NOT NULL COMMENT '电影时长',
    `company` VARCHAR(128) COMMENT '发行公司',
    `key_disabled_date` DATETIME NOT NULL COMMENT '密钥失效时间'
);

-- 创建排片表
-- DROP TABLE IF EXISTS schedule;
CREATE TABLE IF NOT EXISTS `schedule` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '排片id',
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    `hall_id` BIGINT NOT NULL COMMENT '影厅id',
    `start_time` DATETIME NOT NULL COMMENT '开始时间',
    `end_time` DATETIME NOT NULL COMMENT '结束时间',
    `price` DECIMAL(10,2) NOT NULL COMMENT'票价',
    `detail` VARCHAR(16) NOT NULL COMMENT '详情',
    -- 用一个bool表示能否用优惠
    `discount` BOOLEAN DEFAULT FALSE,
	`status` ENUM('disabled','enabled') DEFAULT 'disabled' NOT NULL COMMENT '状态：1:未生效、2:生效',
    FOREIGN KEY (`movie_id`) REFERENCES `movie`(`id`),
    FOREIGN KEY (`hall_id`) REFERENCES `hall`(`id`),
    CHECK (`start_time` < `end_time`)
);

-- 创建设备表
-- DROP TABLE IF EXISTS equipment;
DROP IF EXISTS `equipment`;
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

-- 创建订单表
DROP TABLE IF EXISTS order;
CREATE TABLE IF NOT EXISTS `order` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '订单id',
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    `payer_id` BIGINT NOT NULL COMMENT '下单用户id',
    `order_time` DATETIME NOT NULL COMMENT '下单时间',
    `pay_amount` DECIMAL(10,2) NOT NULL COMMENT '订单总金额',
    `ticket_amount` INT NOT NULL COMMENT '电影票数',
    `price_rule_id` BIGINT COMMENT '票价策略',
    `pay_method` ENUM('CASH','WECHAT','ALIPAY','CREDIT_CARD') DEFAULT NULL COMMENT '支付方式：1:现金，2:微信，3:支付宝，4:信用卡',
    `status` ENUM('NOT_PAID','PAID','CHANGE_TICKET','CANCELLED','REFUNDED','CHANGED','VERIFIED') DEFAULT 'NOT_PAID' NOT NULL COMMENT '状态：1:未支付，2:已支付，3:改签票，4:已核销，5:已改签，6:已退票，7:已取消',
    FOREIGN KEY (`movie_id`) REFERENCES `movie`(`id`)
);

-- 创建电影票表
DROP TABLE IF EXISTS `order_ticket`;
CREATE TABLE IF NOT EXISTS `order_ticket` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '电影票id',
    `order_id` BIGINT NOT NULL COMMENT '所属订单id',
    `schedule_id` BIGINT NOT NULL COMMENT '排片场次id',
    `row` INT NOT NULL COMMENT '座位行',
    `column` INT NOT NULL COMMENT '座位列',
    `ticket_type` ENUM('STUDENT','NORMAL','ELDER') DEFAULT 'NORMAL' NOT NULL COMMENT '票价类型：1:学生票，2:普通票，3:老年票',
    `ticket_price` DECIMAL(10,2) COMMENT '票价',
    `ticket_status` ENUM('ENABLED','DISABLED') DEFAULT 'ENABLED' NOT NULL COMMENT '电影票状态：1:有效，2:无效',
    FOREIGN KEY (`order_id`) REFERENCES `order`(`id`),
    FOREIGN KEY (`schedule_id`) REFERENCES `schedule`(`id`)
);

-- 创建票价策略表
DROP TABLE IF EXISTS `price_rule`;
CREATE TABLE IF NOT EXISTS `price_rule` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '票价策略id',
    `rule_name` VARCHAR(32) NOT NULL COMMENT '策略名称',
    `discount` DECIMAL(3,2) NOT NULL COMMENT '折扣',
    `start_time` DATETIME NOT NULL COMMENT '开始时间',
    `end_time` DATETIME NOT NULL COMMENT '结束时间',
    CHECK (`start_time` < `end_time`)
);

-- 创建策略-电影类型关联表
DROP TABLE IF EXISTS `movie_rule`;
CREATE TABLE IF NOT EXISTS `movie_rule` (
    `rule_id` BIGINT NOT NULL COMMENT '策略id',
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    PRIMARY KEY (`rule_id`, `movie_id`),
    FOREIGN KEY (`rule_id`) REFERENCES `price_rule`(`id`),
    FOREIGN KEY (`movie_id`) REFERENCES `movie`(`id`)
);

