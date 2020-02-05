База данных - структурированный набор постоянно хранимых данных.
Реляционные бд - состоят из друхмерных таблиц
Строки - записи
Столбцы - поля
Первичный ключ - ID
SQL - яп
- интерактивный - внутри бд
- статический - для доступа к бд из вне
- динамический - для доступа к бд из вне
Типы данных
- INT - целые
- VARCHAR(10) - строка с текстом длянной 10
- DATE - дата
Оператор - команда - предложение с ключивыми словами
- DDL - создают объекты
- DML - управляют значениями в таблицах
- DCL - средства подтверждения пользователя на выполнение действий (права)
SELECT Аргументы FROM Арг WHERE условие;

SHOW databases; - показать все бд

CREATE DATABASE Name; - создать бд

DROP DATABASE Name; - удалить бд

USE Name; - использовать бд Name

CREATE TABLE colom_name(id INT, fname VARCHAR(30), dates DATE); - создать таблицу

DROP TABLE colom_name; - удалить таблицу

DESC name_table; - выводит инфу о таблице

INSERT INTO name_table VALUES (1, 'Name', 01.01.2008); - заполнить таблицу

INSERT INTO name_table (fname, dates) VALUES ('name'); - заполнить конкретные поля

SELECT * FROM name_table; - вывести всю таблицу

SELECT name, price FROM product
	WHERE param = 7; >= OR AND LIKE

SELECT price FROM product
	WHERE name LIKE '%ok'; - вывести где name заканчивается на *ok

SELECT price FROM product
	WHERE name LIKE 'nam_'; - вывести где nam_ + любая буква. Можно (_a%)

SELECT price FROM product
	WHERE name IN ('sasha', 'petia'); - вместо = AND =

SELECT name FROM product
	WHERE NOT price BETWEEN (5, 10);

DELETE FROM name_table - удалить записи
	WHERE price > 100; 

UPDATE name SET - изменить значения 
	price = 100
	WHERE name = 'fruts'

Нормализованная таблица - Первичный ключ(Каждая запись должна содержать свой уникальный номер)
                        - Атомарность данных(Данные должны быть разбиты на наиболее эффективные части)

CREATE TABLE name (id INT AUTO_INCREMENT, PRIMARY KEY (id)); - авто id + Первичный ключ

ALTER TABLE name - изменить таблицу
ADD COLUMN is id AUTO_INCREMENT FIRST, - на первом месте
ADD PRIMARY KEY (id)
