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

