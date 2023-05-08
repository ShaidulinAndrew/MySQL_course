DROP DATABASE IF EXISTS property;
CREATE DATABASE property;
USE property;

DROP TABLE IF EXISTS contracts;
CREATE TABLE contracts (                              -- таблица содержит информацию о сделках
	id SERIAL PRIMARY KEY,
	upp_seller_id BIGINT UNSIGNED NOT NULL,           -- ссылка на таблицу заявка на продажу
	upp_buyer_id BIGINT UNSIGNED NOT NULL,            -- ссылка на таблицу заявка на покупку
	apartment_id BIGINT UNSIGNED NOT NULL,            -- ссылка на таблицу квартиры
	agent_seller_id BIGINT UNSIGNED NOT NULL,         -- ссылка на таблицу риелтор
	agent_buyer_id BIGINT UNSIGNED NOT NULL,          -- ссылка на таблицу риелтор
	stage ENUM('contract', 'registration', 'end'),    -- текущий статус сделки
	advertising_id VARCHAR(50) NOT NULL,              -- ссылка на таблицу объявлений
	creature_at DATETIME DEFAULT NOW(),               -- время создание сделки
	update_at DATETIME ON UPDATE NOW(),               -- время обновления статуса
	FOREIGN KEY (upp_seller_id) REFERENCES upp_seller(id),	
	FOREIGN KEY (upp_buyer_id) REFERENCES upp_buyer(id),
	FOREIGN KEY (apartment_id) REFERENCES apartment(id),
	FOREIGN KEY (agent_seller_id) REFERENCES agent(id),
	FOREIGN KEY (agent_buyer_id) REFERENCES agent(id)
	);
	
DROP TABLE IF EXISTS upp_seller;
CREATE TABLE upp_seller (                             -- таблица содержит информацию о заявке на продажу
	id SERIAL PRIMARY KEY,
	seller_id SMALLINT UNSIGNED NOT NULL,             -- ссылка на таблицу продавец
	agent_seller_id TINYINT UNSIGNED NOT NULL,        -- ссылка на таблицу риелтор
	apartment_id SMALLINT UNSIGNED NOT NULL,          -- ссылка на таблицу квартиры
	doc_seller_id SMALLINT UNSIGNED NOT NULL	      -- ссылка на таблицу документы покупателя
	);
	
DROP TABLE IF EXISTS upp_buyer;
CREATE TABLE upp_buyer (                              -- таблица содержит информацию о заявке на покупку
	id SERIAL PRIMARY KEY,
	buyer_id SMALLINT UNSIGNED NOT NULL,              -- ссылка на таблицу продавец
	agent_buyer_id TINYINT UNSIGNED NOT NULL,         -- ссылка на таблицу риелтор
	apartment_id SMALLINT UNSIGNED NOT NULL,          -- ссылка на таблицу квартиры
	doc_buyer SMALLINT UNSIGNED NOT NULL	          -- ссылка на таблицу документы продавца
	);
	
DROP TABLE IF EXISTS apartment;
CREATE TABLE apartment (                              -- таблица содержит информацию о квартирах
	id SERIAL PRIMARY KEY,
	seller_id SMALLINT UNSIGNED NOT NULL,             -- ссылка на таблицу продавец
	rooms TINYINT UNSIGNED NOT NULL,                  -- количество комнат
	floors TINYINT UNSIGNED NOT NULL,                 -- этаж
	cost INT UNSIGNED NOT NULL,                       -- цена
	city VARCHAR(50) NOT NULL,                        -- город
	street VARCHAR(50) NOT NULL,                      -- улица
	house TINYINT UNSIGNED NOT NULL,                  -- дом
	flat TINYINT UNSIGNED NOT NULL                    -- квартира
	);

DROP TABLE IF EXISTS agent;
CREATE TABLE agent (                                  -- таблица содержит информацию о риелторе
	id SERIAL PRIMARY KEY,
	last_name VARCHAR(50) NOT NULL,                   -- имя риелтора
	first_name VARCHAR(50) NOT NULL,                  -- фамилия риелтора
	phone SMALLINT UNSIGNED NOT NULL                  -- телефон риелтора
	);

DROP TABLE IF EXISTS seller;
CREATE TABLE seller (                                 -- таблица содержит информацию о продавце
	id SERIAL PRIMARY KEY,
	last_name VARCHAR(50) NOT NULL,                   -- имя продавца
	first_name VARCHAR(50) NOT NULL,                  -- фамилия продавца
	phone SMALLINT UNSIGNED NOT NULL                  -- телефон продавца
	);
	
	DROP TABLE IF EXISTS buyer;
CREATE TABLE buyer (                                  -- таблица содержит информацию о покупателе
	id SERIAL PRIMARY KEY,
	last_name VARCHAR(50) NOT NULL,                   -- имя покупателя
	first_name VARCHAR(50) NOT NULL,                  -- фамилия покупателя
	phone SMALLINT UNSIGNED NOT NULL                  -- телефон покупателя
	);

DROP TABLE IF EXISTS advertising;
CREATE TABLE advertising (                            -- таблица содержит информацию о размещении объявления
	id SERIAL PRIMARY KEY,
	site VARCHAR(50) NOT NULL,                        -- сайт на котором размещено объявление
	creature_at DATETIME DEFAULT NOW()                -- время размещения объявления
	);

DROP TABLE IF EXISTS doc_buyer;
CREATE TABLE doc_buyer (                              -- таблица содержит документы покупателя
	id SERIAL PRIMARY KEY,
	document_1 VARCHAR(50) NOT NULL,                  -- документ1
	document_2 VARCHAR(50) NOT NULL,                  -- документ2
	document_3 VARCHAR(50) NOT NULL                   -- документ3
	);
	
DROP TABLE IF EXISTS doc_seller;
CREATE TABLE doc_seller (                              -- таблица содержит документы продавца
	id SERIAL PRIMARY KEY,
	document_1 VARCHAR(50) NOT NULL,                  -- документ1
	document_2 VARCHAR(50) NOT NULL,                  -- документ2
	document_3 VARCHAR(50) NOT NULL                   -- документ3
	);