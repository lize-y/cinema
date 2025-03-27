-- 演员表
CREATE TABLE IF NOT EXISTS `artist`(
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '演员ID',
    `name` VARCHAR(32) NOT NULL COMMENT '演职人员姓名'
);

-- 电影表
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

-- 创建电影-导演关联表（复合主键）
CREATE TABLE IF NOT EXISTS `movie_director` (
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    `artist_id` BIGINT NOT NULL COMMENT '导演id',
    PRIMARY KEY (`movie_id`, `artist_id`),
    FOREIGN KEY (`movie_id`) REFERENCES `movie`(`id`),
    FOREIGN KEY (`artist_id`) REFERENCES `artist`(`id`)
);

-- 创建电影-演员关联表（复合主键）
CREATE TABLE IF NOT EXISTS `movie_artist` (
    `movie_id` BIGINT NOT NULL COMMENT '电影id',
    `artist_id` BIGINT NOT NULL COMMENT '演员id',
    PRIMARY KEY (`movie_id`, `artist_id`),
    FOREIGN KEY (`movie_id`) REFERENCES `movie`(`id`),
    FOREIGN KEY (`artist_id`) REFERENCES `artist`(`id`)
);

-- 创建影厅表
CREATE TABLE IF NOT EXISTS `hall` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '影厅id',
    `name` VARCHAR(32) NOT NULL COMMENT '影厅名称',
    `seating` INT NOT NULL COMMENT '座位数'
);

-- 创建排片表
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

-- 权限表
CREATE TABLE IF NOT EXISTS `perm` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '权限id',
    `name` VARCHAR(32) NOT NULL COMMENT '权限名称'
);

-- 角色表
CREATE TABLE IF NOT EXISTS `role` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY NOT NULL COMMENT '角色id',
    `name` VARCHAR(32) NOT NULL COMMENT '角色名称'
);

-- 用户表
CREATE TABLE IF NOT EXISTS `user`(
    `id`         BIGINT AUTO_INCREMENT PRIMARY KEY             NOT NULL COMMENT '用户id',
    `username`   VARCHAR(32)                                   NOT NULL COMMENT '用户名',
    `password`   VARCHAR(64)                                   NOT NULL COMMENT '密码',
    `email`      VARCHAR(32) COMMENT '邮箱',
    `phone`      VARCHAR(15) COMMENT '手机',
    `birthday`   DATE COMMENT '生日',
    `sex`        ENUM ('male','female','other') DEFAULT 'male' NOT NULL COMMENT '性别：1:男、2:女',
    `photo_path` VARCHAR(256) COMMENT '头像路径'
);

-- 角色-权限关联表（复合主键）
CREATE TABLE IF NOT EXISTS `role_perm` (
    `role_id` BIGINT NOT NULL COMMENT '角色id',
    `perm_id` BIGINT NOT NULL COMMENT '权限id',
    PRIMARY KEY (`role_id`, `perm_id`),
    FOREIGN KEY (`role_id`) REFERENCES `role`(`id`),
    FOREIGN KEY (`perm_id`) REFERENCES `perm`(`id`)
);

-- 用户-角色关联表（复合主键）
CREATE TABLE IF NOT EXISTS `user_role` (
    `user_id` BIGINT NOT NULL COMMENT '用户id',
    `role_id` BIGINT NOT NULL COMMENT '角色id',
    PRIMARY KEY (`user_id`, `role_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user`(`id`),
    FOREIGN KEY (`role_id`) REFERENCES `role`(`id`)
);

-- 外键约束
ALTER TABLE role_perm
ADD CONSTRAINT fk_role_id
FOREIGN KEY (role_id) REFERENCES role(id)
ON DELETE CASCADE;

ALTER TABLE user_role
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id) REFERENCES user(id)
ON DELETE CASCADE;