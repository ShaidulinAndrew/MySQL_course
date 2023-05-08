USE property;

/* Задача № 1
Вывести список риелторов в алфавитном порядке
*/

SELECT DISTINCT last_name
FROM agent
ORDER BY last_name 
;

/* Задача № 2
Выведите агентов с количеством квартир на продаже
*/

SELECT agent_seller_id , COUNT(*) AS total
FROM upp_seller
GROUP BY agent_seller_id
ORDER BY total DESC
;

/* Задача № 3
Выведите трех агентов с наибольшим количеством квартир на покупке
*/

SELECT 
	agent_buyer_id AS №,
	(SELECT first_name FROM agent WHERE id = upp_buyer.agent_buyer_id) AS agent,
	COUNT(*) AS total
FROM upp_buyer
GROUP BY agent_buyer_id
ORDER BY total DESC
LIMIT 3
;	
	
/* Задача № 4
 * Выведите уникальных клиентов компании (продавцов и покупателей) в алфавитном порядке
 */	

SELECT last_name, first_name FROM buyer
UNION 
SELECT last_name, first_name FROM seller
ORDER BY last_name;

/* Задача № 5
 * Выведите продавцов квартир и адреса квартир
 */		

SELECT
	s.first_name, s.last_name,
	a.city, a.street, a.house, a.flat
FROM seller s
INNER JOIN apartment a ON s.id=a.id
GROUP BY s.id
;

/* Задача № 6
 * Выведите клиентов которые одновременно являются и продавцами и покупателями
 */		

SELECT  
	CONCAT (s.first_name, ' ', s.last_name) AS Продавец,
	CONCAT (b.first_name, ' ', b.last_name) AS Покупатель
FROM seller s
JOIN buyer b ON s.first_name = b.first_name AND s.last_name = b.last_name
;

/* Задача № 7
 * Создать представление вызывающее информацию о сделках находящихся в процессе регистрации
 */	


CREATE OR REPLACE VIEW status_reg
AS

SELECT 
	id AS №,
	(SELECT CONCAT (seller.first_name, ' ', seller.last_name) FROM seller WHERE id = upp_seller_id) AS Продавец,
	(SELECT CONCAT (agent.first_name, ' ', agent.last_name) FROM agent WHERE id = agent_seller_id) AS Агент_Продавца,
	(SELECT CONCAT (buyer.first_name, ' ', buyer.last_name) FROM buyer WHERE id = upp_buyer_id) AS Покупатель,
	(SELECT CONCAT (agent.first_name, ' ', agent.last_name) FROM agent WHERE id = agent_buyer_id) AS Агент_Покупателя, 
	(SELECT CONCAT (apartment.city, ' ', apartment.street, ' ', apartment.house, ' ', apartment.flat, ' '
	) FROM apartment WHERE id = apartment_id) AS Адрес
FROM contracts c 
WHERE stage = 'registration';

-- SELECT * FROM status_reg

-- DROP VIEW status_reg


/* Задача № 8
 * Создать представление выводящее информацию о квартирах в порядке убывания цены
 */	

CREATE OR REPLACE VIEW sort_cost
AS

SELECT
	cost AS Цена, rooms AS Комнаты, floors AS Этаж, city AS Город, street AS Улица, house AS Дом, flat AS Квартина 
FROM apartment
ORDER BY cost;

/* Задача № 9
 * Создать процедуру добавляющую продавца
 */
DROP PROCEDURE IF EXISTS in_seller;

DELIMITER //
CREATE PROCEDURE in_seller (f VARCHAR(50), l VARCHAR(50), p BIGINT UNSIGNED)
	BEGIN 
		INSERT INTO seller (first_name, last_name, phone) VALUES (f, l, p);
	END // 
DELIMITER;

CALL in_seller('fff', 'aaa', '9020880899');
	
/* Задача № 10
 * Создать процедуру которая будет показывать квартиры из города, который мы укажем в качестве аргумента
 */

DROP PROCEDURE IF EXISTS sort_city;

DELIMITER //
CREATE PROCEDURE sort_city (city_arg VARCHAR(50))
BEGIN
	SELECT city, street, house, flat, cost	
	FROM apartment
	WHERE city = city_arg;
END //
DELIMITER;

CALL sort_city ('Владивосток');

/* Задача № 11
 * Создать триггер увеличивающий стоимость квартиры на 1%
 */

-- триггер создан для таблицы apartment
-- называется correct_cost

/* Задача № 12
 * Создать триггер проверяющий корректность установки времени обновления статуса сделки
 */

-- триггер создан для таблицы contract
-- называется check_update_ut
