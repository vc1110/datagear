CREATE TABLE T_ACCOUNT
(
	ID INTEGER NOT NULL,
	NAME VARCHAR(20) NOT NULL,
	HEAD_IMG BINARY(8000),
	INTRODUCTION TEXT,
	PRIMARY KEY (ID)
);

/*
COMMENT ON TABLE T_ACCOUNT IS '账号';
COMMENT ON COLUMN T_ACCOUNT.NAME IS '帐号名';
COMMENT ON COLUMN T_ACCOUNT.HEAD_IMG IS '头像图片';
COMMENT ON COLUMN T_ACCOUNT.INTRODUCTION IS '自我介绍';
*/

CREATE TABLE T_ADDRESS
(
	ACCOUNT_ID INTEGER NOT NULL,
	CITY VARCHAR(50),
	STREET VARCHAR(100),
	RESIDENTIAL VARCHAR(100),
	HOUSE_NUMBER VARCHAR(100)
);
ALTER TABLE T_ADDRESS ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES T_ACCOUNT (ID);
ALTER TABLE T_ADDRESS ADD CONSTRAINT UK_ACCOUNT_ID UNIQUE (ACCOUNT_ID);

/*
COMMENT ON TABLE T_ADDRESS IS '住址';
COMMENT ON COLUMN T_ADDRESS.ACCOUNT_ID IS '所属帐号';
COMMENT ON COLUMN T_ADDRESS.CITY IS '城市';
COMMENT ON COLUMN T_ADDRESS.STREET IS '街道';
COMMENT ON COLUMN T_ADDRESS.RESIDENTIAL IS '住宅区';
COMMENT ON COLUMN T_ADDRESS.HOUSE_NUMBER IS '门牌号';
*/

CREATE TABLE T_ADDRESS_MORE
(
	ACCOUNT_ID INTEGER NOT NULL,
	ADDRESS VARCHAR(200)
);
ALTER TABLE T_ADDRESS_MORE ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES T_ADDRESS (ACCOUNT_ID) ON DELETE CASCADE ON UPDATE CASCADE;

/*
COMMENT ON TABLE T_ADDRESS_MORE IS '更多住址';
COMMENT ON COLUMN T_ADDRESS_MORE.ACCOUNT_ID IS '所属地址';
COMMENT ON COLUMN T_ADDRESS_MORE.ADDRESS IS '地址';
*/

CREATE TABLE T_PRODUCT
(
	ID INTEGER NOT NULL,
	NAME VARCHAR(20) NOT NULL,
	PRICE NUMERIC(10,2) NOT NULL,
	PRIMARY KEY (ID)
);

/*
COMMENT ON TABLE T_PRODUCT IS '商品';
COMMENT ON COLUMN T_PRODUCT.NAME IS '商品名称';
COMMENT ON COLUMN T_PRODUCT.PRICE IS '价格';
*/

CREATE TABLE T_ORDER
(
	ID INTEGER NOT NULL,
	NAME VARCHAR(20) NOT NULL,
	ACCOUNT_ID INTEGER,
	DESCRIPTION VARCHAR(20) DEFAULT 'note',
	STAR_LEVEL INTEGER DEFAULT 1,
	CREATE_TIME DATETIME DEFAULT CURRENT_TIMESTAMP,
	EDIT_TIME TIMESTAMP,
	PRIMARY KEY (ID)
);
ALTER TABLE T_ORDER ADD FOREIGN KEY (ACCOUNT_ID) REFERENCES T_ACCOUNT (ID);

/*
COMMENT ON TABLE T_ORDER IS '订单';
COMMENT ON COLUMN T_ORDER.NAME IS '订单名称';
COMMENT ON COLUMN T_ORDER.ACCOUNT_ID IS '所属帐号';
COMMENT ON COLUMN T_ORDER.DESCRIPTION IS '描述';
COMMENT ON COLUMN T_ORDER.STAR_LEVEL IS '星级';
COMMENT ON COLUMN T_ORDER.CREATE_TIME IS '创建日期';
COMMENT ON COLUMN T_ORDER.EDIT_TIME IS '编辑日期';
*/

CREATE TABLE T_ORDER_PRODUCTS
(
	ORDER_ID INTEGER NOT NULL,
	PRODUCT_ID INTEGER NOT NULL
);
ALTER TABLE T_ORDER_PRODUCTS ADD FOREIGN KEY (ORDER_ID) REFERENCES T_ORDER (ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE T_ORDER_PRODUCTS ADD FOREIGN KEY (PRODUCT_ID) REFERENCES T_PRODUCT (ID) ON DELETE CASCADE ON UPDATE CASCADE;

/*
COMMENT ON TABLE T_ORDER_PRODUCTS IS '订单-商品';
COMMENT ON COLUMN T_ORDER_PRODUCTS.ORDER_ID IS '订单';
COMMENT ON COLUMN T_ORDER_PRODUCTS.PRODUCT_ID IS '商品';
*/

CREATE TABLE T_PRODUCT_PRICE_HISTORY
(
	PRODUCT_ID INTEGER NOT NULL,
	PRICE NUMERIC(10,2) NOT NULL
);
ALTER TABLE T_PRODUCT_PRICE_HISTORY ADD FOREIGN KEY (PRODUCT_ID) REFERENCES T_PRODUCT (ID) ON DELETE CASCADE ON UPDATE CASCADE;

/*
COMMENT ON TABLE T_PRODUCT_PRICE_HISTORY IS '商品价格历史';
COMMENT ON COLUMN T_PRODUCT_PRICE_HISTORY.PRODUCT_ID IS '商品';
COMMENT ON COLUMN T_PRODUCT_PRICE_HISTORY.PRICE IS '价格';
*/

CREATE TABLE T_AUTO_GENERATED_KEYS
(
	ID INTEGER IDENTITY(1,1) PRIMARY KEY,
	NAME VARCHAR(20),
	CREATE_TIME DATETIME
);
