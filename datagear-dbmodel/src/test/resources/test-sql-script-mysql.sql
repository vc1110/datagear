CREATE TABLE T_ACCOUNT
(
	ID INT(10) NOT NULL,
	NAME VARCHAR(20) NOT NULL COMMENT '帐号名',
	HEAD_IMG BLOB COMMENT '头像图片',
	INTRODUCTION TEXT COMMENT '自我介绍',
	PRIMARY KEY (ID)
) COMMENT='帐号';

CREATE TABLE T_ADDRESS
(
	ACCOUNT_ID INT(10) COMMENT '所属帐号',
	CITY VARCHAR(50) COMMENT '城市',
	STREET VARCHAR(100) COMMENT '街道',
	RESIDENTIAL VARCHAR(100) COMMENT '住宅区',
	HOUSE_NUMBER VARCHAR(100) COMMENT '门牌号'
) COMMENT='住址';
ALTER TABLE T_ADDRESS ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES T_ACCOUNT (ID);
ALTER TABLE T_ADDRESS ADD CONSTRAINT UK_ACCOUNT_ID UNIQUE (ACCOUNT_ID);

CREATE TABLE T_ADDRESS_MORE
(
	ACCOUNT_ID INT(10) NOT NULL COMMENT '所属地址',
	ADDRESS VARCHAR(200) COMMENT '地址'
) COMMENT='更多住址';
ALTER TABLE T_ADDRESS_MORE ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES T_ADDRESS (ACCOUNT_ID) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE T_PRODUCT
(
	ID INT(10) NOT NULL,
	NAME VARCHAR(20) NOT NULL COMMENT '商品名称',
	PRICE FLOAT(10,2) NOT NULL COMMENT '价格',
	PRIMARY KEY (ID)
) COMMENT='商品';

CREATE TABLE T_ORDER
(
	ID INT(10) NOT NULL,
	NAME VARCHAR(20) NOT NULL COMMENT '订单名称',
	ACCOUNT_ID INT(10) COMMENT '所属帐号',
	DESCRIPTION VARCHAR(20) DEFAULT 'note' COMMENT '描述',
	STAR_LEVEL INT(4) DEFAULT 1 COMMENT '星级',
	CREATE_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP() COMMENT '创建日期',
	EDIT_TIME DATETIME COMMENT '编辑日期',
	PRIMARY KEY (ID)
) COMMENT='订单';
ALTER TABLE T_ORDER ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES T_ACCOUNT (ID);

CREATE TABLE T_ORDER_PRODUCTS
(
	ORDER_ID INT(10) NOT NULL COMMENT '订单',
	PRODUCT_ID INT(10) NOT NULL COMMENT '商品'
) COMMENT='订单-商品';
ALTER TABLE T_ORDER_PRODUCTS ADD FOREIGN KEY (ORDER_ID) REFERENCES T_ORDER (ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE T_ORDER_PRODUCTS ADD FOREIGN KEY (PRODUCT_ID) REFERENCES T_PRODUCT (ID) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE T_PRODUCT_PRICE_HISTORY
(
	PRODUCT_ID INT(10) NOT NULL COMMENT '商品',
	PRICE FLOAT(10,2) NOT NULL COMMENT '价格'
);
ALTER TABLE T_PRODUCT_PRICE_HISTORY ADD FOREIGN KEY (PRODUCT_ID) REFERENCES T_PRODUCT (ID) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE T_AUTO_GENERATED_KEYS
(
	ID INT(10) NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(20),
	CREATE_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (ID)
);
