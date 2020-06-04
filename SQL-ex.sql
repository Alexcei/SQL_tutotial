Задание: 1 
Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd

SELECT model, speed, hd
FROM pc
WHERE price < 500

Задание: 2
Найдите производителей принтеров. Вывести: maker

SELECT DISTINCT maker
FROM product
WHERE type = 'printer'

Задание: 3
Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

SELECT model, ram, screen
FROM laptop
WHERE price > 1000

Задание: 4
Найдите все записи таблицы Printer для цветных принтеров.

SELECT *
FROM printer
WHERE color = 'y'

Задание: 5
Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

SELECT model, speed, hd
FROM PC
WHERE (cd = '12x' OR cd = '24x')
AND price < 600

Задание: 6
Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

SELECT p.maker, v.speed FROM product AS p
INNER JOIN (SELECT model, speed FROM laptop WHERE hd >= 10.0 GROUP BY model, speed) AS v
ON v.model = p.model
GROUP BY p.maker, v.speed

Задание: 7
Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

SELECT product.model, pc.price
FROM product, pc
WHERE maker = 'B'
AND product.model = pc.model
UNION
SELECT product.model, laptop.price
FROM product, laptop
WHERE maker = 'B'
AND product.model = laptop.model
UNION
SELECT product.model, printer.price
FROM product, printer
WHERE maker = 'B'
AND product.model = printer.model

Задание: 8
Найдите производителя, выпускающего ПК, но не ПК-блокноты.

select DISTINCT maker from product where type='PC' and maker not in
(select maker from product where type = 'Laptop')

Задание: 9 (Serge I: 2002-11-02)
Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

SELECT DISTINCT maker
FROM pc INNER JOIN product ON pc.model = product.model
WHERE speed >= 450

Задание: 10
Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

SELECT model, price
FROM printer
WHERE price = (SELECT MAX(price) FROM printer)

Задание: 11
Найдите среднюю скорость ПК.

SELECT AVG(speed)
FROM pc

Задание: 12
Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

SELECT AVG(speed)
FROM laptop
WHERE price > 1000

Задание: 13
Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT AVG(speed)
FROM pc
WHERE model in (SELECT model FROM product WHERE maker = 'A')

Задание: 14
Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

SELECT Ships.class, name, country
FROM Ships
INNER JOIN Classes
ON Ships.class = Classes.class 
WHERE Classes.class in (SELECT class FROM Classes WHERE numGuns >= 10)

Задание: 15
Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT hd
FROM pc
GROUP BY hd
HAVING COUNT(hd) > 1

Задание: 16
Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

SELECT DISTINCT a.model, b.model, a.speed, a.ram
FROM pc a, pc b
WHERE a.speed = b.speed
AND a.ram = b.ram 
AND a.model > b.model

Задание: 17
Найдите модели ПК-блокнотов, скорость которых меньше скорости любого из ПК.
Вывести: type, model, speed

SELECT DISTINCT product.type, laptop.model, laptop.speed
FROM laptop, product
WHERE laptop.speed < (SELECT MIN(speed) FROM pc)
AND product.model = laptop.model

Задание: 18
Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

SELECT DISTINCT maker, price
FROM product, printer
WHERE color = 'y'
AND price = (SELECT MIN(price) FROM printer WHERE color = 'y')
AND product.model = printer.model

Задание: 19
Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.

SELECT maker, AVG(screen)
FROM product, laptop
WHERE laptop.model = product.model
GROUP BY maker

Задание: 20
Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.

select maker, count(model)
from product
WHERE type = 'pc'
group by maker
having count(model) >= 3

Задание: 21
Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.

SELECT maker, MAX(price)
FROM product, pc
WHERE product.model = pc.model
GROUP BY maker

Задание: 22
Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.

SELECT speed, AVG(price)
FROM pc
WHERE speed > 600
GROUP BY speed

Задание: 23
Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
Вывести: Maker

SELECT maker
FROM product
WHERE model in (SELECT model FROM pc WHERE speed >= 750)
INTERSECT
SELECT maker
FROM product
WHERE model in (SELECT model FROM laptop WHERE speed >= 750)

Задание: 24
Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

SELECT DISTINCT p.model
FROM product AS p, pc, laptop, printer
WHERE p.model in (pc.model, laptop.model, printer.model)
AND pc.price = (SELECT MAX(price) FROM pc)
AND laptop.price = (SELECT MAX(price) FROM laptop)
AND printer.price = (SELECT MAX(price) FROM printer)
AND ((pc.price >= laptop.price AND pc.price >= printer.price and pc.model = p.model)
OR (laptop.price >= pc.price AND laptop.price >= printer.price and laptop.model = p.model)
OR (printer.price >= laptop.price AND printer.price >= pc.price and printer.model = p.model))

Задание: 25
Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

SELECT maker
FROM product AS p, pc
WHERE p.model = pc.model
AND speed = (SELECT MAX(speed) FROM pc WHERE ram = (SELECT MIN(ram) FROM pc))
AND ram = (SELECT MIN(ram) FROM pc)
INTERSECT
SELECT maker
FROM product
WHERE type = 'printer'

Задание: 26
Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.

SELECT AVG(price)
FROM (SELECT price, model FROM pc WHERE model 
IN (SELECT model FROM product WHERE maker = 'A' AND type = 'pc')
UNION ALL
SELECT price, model FROM laptop WHERE model 
IN (SELECT model FROM product WHERE maker = 'A' AND type = 'laptop')) AS prod

Задание: 27
Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.

SELECT maker, AVG(hd)
FROM product p INNER JOIN pc
ON p.model = pc.model
AND maker IN (SELECT maker FROM product WHERE type = 'printer')
GROUP BY maker

Задание: 28
Используя таблицу Product, определить количество производителей, выпускающих по одной модели.

SELECT COUNT(maker)
FROM (SELECT maker FROM product
GROUP BY maker
HAVING COUNT(model) = 1) AS prod

Задание: 29
В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o.

SELECT point, date, SUM(inc), SUM(out)
FROM
(SELECT point, date, inc, NULL AS out
FROM Income_o
UNION
SELECT point, date, NULL AS inc, out
FROM Outcome_o) AS a
GROUP BY point, date

Задание: 30
В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта за день (inc). Отсутствующие значения считать неопределенными (NULL).

SELECT point, date, SUM(Outcome), SUM(income)
FROM
(SELECT point, date, NULL AS Outcome, SUM(inc) AS income
FROM Income
GROUP BY point, date
UNION
SELECT point, date, SUM(out) AS Outcome, NULL AS income
FROM Outcome
GROUP BY point, date) AS a
GROUP BY point, date

Задание: 31
Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс и страну.

SELECT class, country
FROM Classes
WHERE bore >= 16

Задание: 32
Одной из характеристик корабля является половина куба калибра его главных орудий (mw). С точностью до 2 десятичных знаков определите среднее значение mw для кораблей каждой страны, у которой есть корабли в базе данных.

SELECT DISTINCT country, CAST(AVG(POWER(bore, 3)/2) AS NUMERIC(6,2)) AS weight
FROM
(SELECT name, bore, country
FROM Classes c, Ships s
WHERE s.class = c.class
UNION
SELECT ship AS name, bore, country
FROM Outcomes o, Classes c
WHERE ship = c.class
AND ship NOT IN (SELECT name FROM Ships)) AS a
GROUP BY country

Задание: 33
Укажите корабли, потопленные в сражениях в Северной Атлантике (North Atlantic). Вывод: ship.

SELECT ship
FROM Outcomes
WHERE result = 'sunk'
AND battle = 'North Atlantic'

Задание: 34
По Вашингтонскому международному договору от начала 1922 г. запрещалось строить линейные корабли водоизмещением более 35 тыс.тонн. Укажите корабли, нарушившие этот договор (учитывать только корабли c известным годом спуска на воду). Вывести названия кораблей.

SELECT name
FROM Ships s, Classes c
WHERE c.class = s.class
AND displacement > 35000
AND launched >= 1922
AND type = 'bb'

Задание: 35
В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра).
Вывод: номер модели, тип модели.

SELECT model, type
FROM product
WHERE model NOT LIKE '%[^A-Z]%'
OR model NOT LIKE '%[^0-9]%'

Задание: 36
Перечислите названия головных кораблей, имеющихся в базе данных (учесть корабли в Outcomes).

SELECT name
FROM Ships
WHERE name = class
UNION
SELECT ship
FROM Outcomes o, Classes c
WHERE o.ship = c.class

Задание: 37
Найдите классы, в которые входит только один корабль из базы данных (учесть также корабли в Outcomes).

SELECT class
FROM
(SELECT name, class FROM Ships
UNION
SELECT ship AS name, class FROM Outcomes, Classes WHERE class = ship) AS gr
GROUP BY class
HAVING COUNT(gr.name) = 1

Задание: 38
Найдите страны, имевшие когда-либо классы обычных боевых кораблей ('bb') и имевшие когда-либо классы крейсеров ('bc').

SELECT DISTINCT country
FROM
(SELECT country
FROM Classes
WHERE type = 'bb'
INTERSECT
SELECT country
FROM Classes
WHERE type = 'bc') AS q

Задание: 39
Найдите корабли, `сохранившиеся для будущих сражений`; т.е. выведенные из строя в одной битве (damaged), они участвовали в другой, произошедшей позже.

SELECT DISTINCT ship
FROM Outcomes, Battles b
WHERE battle = b.name
AND ship IN (SELECT ship
FROM Outcomes, Battles b1
WHERE battle = b1.name
AND result = 'damaged'
AND b.date > b1.date)

Задание: 40
Найти производителей, которые выпускают более одной модели, при этом все выпускаемые производителем модели являются продуктами одного типа.
Вывести: maker, type

SELECT DISTINCT maker, type
FROM product
WHERE maker IN
(SELECT maker
FROM product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1
AND COUNT(model) > 1)

Задание: 41
Для каждого производителя, у которого присутствуют модели хотя бы в одной из таблиц PC, Laptop или Printer,
определить максимальную цену на его продукцию.
Вывод: имя производителя, если среди цен на продукцию данного производителя присутствует NULL, то выводить для этого производителя NULL,
иначе максимальную цену.

SELECT DISTINCT maker, 
CASE WHEN COUNT(*) = COUNT(price) THEN MAX(price) ELSE NULL END AS m_price
FROM
(SELECT maker, price
FROM pc, product p
WHERE p.model = pc.model
UNION
SELECT maker, price
FROM laptop l, product p
WHERE p.model = l.model
UNION
SELECT maker, price
FROM printer pr, product p
WHERE p.model = pr.model) AS t1
GROUP BY maker

Задание: 42
Найдите названия кораблей, потопленных в сражениях, и название сражения, в котором они были потоплены.

SELECT ship, battle
FROM Outcomes
WHERE result = 'sunk'

Задание: 43
Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.

SELECT name
FROM Battles
WHERE YEAR(date) NOT IN (SELECT launched
FROM Ships
WHERE launched IS NOT NULL)

Задание: 44
Найдите названия всех кораблей в базе данных, начинающихся с буквы R.

SELECT name
FROM ships
WHERE name LIKE 'R%'
UNION
SELECT ship
FROM Outcomes
WHERE ship LIKE 'R%'

Задание: 45
Найдите названия всех кораблей в базе данных, состоящие из трех и более слов (например, King George V).
Считать, что слова в названиях разделяются единичными пробелами, и нет концевых пробелов.

SELECT name
FROM Ships
WHERE name LIKE '% % %'
UNION
SELECT ship
FROM Outcomes
WHERE ship LIKE '% % %'

Задание: 46
Для каждого корабля, участвовавшего в сражении при Гвадалканале (Guadalcanal), вывести название, водоизмещение и число орудий.

SELECT ship, displacement, numGuns
FROM Classes, Outcomes
WHERE ship NOT IN (SELECT name FROM Ships)
AND ship = class
AND battle = 'Guadalcanal'
UNION
SELECT name, displacement, numGuns
FROM Classes c, Ships s, Outcomes o
WHERE o.ship = s.name 
AND s.class = c.class
AND battle = 'Guadalcanal'
UNION
SELECT ship, NULL AS displacement, NULL AS numGuns
FROM Classes c, Ships s, Outcomes o
WHERE ship NOT IN (SELECT name FROM Ships)
AND ship NOT IN (SELECT class FROM Classes)
AND battle = 'Guadalcanal'


Задание: 48
Найдите классы кораблей, в которых хотя бы один корабль был потоплен в сражении.

SELECT DISTINCT class
FROM Ships
WHERE name IN (SELECT ship FROM Outcomes WHERE result = 'sunk')
UNION
SELECT DISTINCT class
FROM Classes
WHERE class IN (SELECT ship FROM Outcomes WHERE result = 'sunk')

Задание: 49
Найдите названия кораблей с орудиями калибра 16 дюймов (учесть корабли из таблицы Outcomes).

SELECT DISTINCT name
FROM Ships s, Classes c
WHERE bore = 16
AND s.class = c.class
UNION
SELECT DISTINCT ship
FROM Outcomes o, Classes c
WHERE bore = 16
AND o.ship = c.class

Задание: 50
Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.

SELECT DISTINCT battle
FROM outcomes
WHERE ship IN (SELECT name FROM Ships WHERE class = 'Kongo')


Задание: 52
Определить названия всех кораблей из таблицы Ships, которые могут быть линейным японским кораблем,
имеющим число главных орудий не менее девяти, калибр орудий менее 19 дюймов и водоизмещение не более 65 тыс.тонн

SELECT name
FROM Ships s, Classes c
WHERE s.class = c.class
AND type = 'bb'
AND country = 'Japan'
AND (numGuns >= 9 OR numGuns IS NULL)
AND (bore < 19 OR bore IS NULL)
AND (displacement <= 65000 OR displacement IS NULL)

Задание: 53
Определите среднее число орудий для классов линейных кораблей.
Получить результат с точностью до 2-х десятичных знаков.

SELECT CAST(AVG(numGuns*1.0) AS NUMERIC(6,2))
FROM Classes
WHERE type = 'bb'

Задание: 54
С точностью до 2-х десятичных знаков определите среднее число орудий всех линейных кораблей (учесть корабли из таблицы Outcomes).

SELECT CAST(AVG(numGuns*1.0) AS NUMERIC(6,2))
FROM
(SELECT name AS n, numGuns
FROM Ships s INNER JOIN Classes c
ON c.class = s.class
AND type = 'bb'
UNION
SELECT DISTINCT ship AS n, numGuns
FROM Outcomes o INNER JOIN Classes c
ON ship NOT IN (SELECT name FROM Ships)
AND ship = c.class 
AND type = 'bb') AS a

Задание: 55
Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

SELECT c.class, MIN(s.launched)
FROM Ships s RIGHT JOIN Classes c
ON c.class = s.class
GROUP BY c.class

Задание: 59
Посчитать остаток денежных средств на каждом пункте приема для базы данных с отчетностью не чаще одного раза в день. Вывод: пункт, остаток.

SELECT point, SUM(price) AS Remain
FROM
(SELECT point, SUM(inc) AS price
FROM Income_o
GROUP BY point
UNION
SELECT point, -SUM(out) AS price
FROM Outcome_o
GROUP BY point) AS a
GROUP BY point

Задание: 61
Посчитать остаток денежных средств на всех пунктах приема для базы данных с отчетностью не чаще одного раза в день.

SELECT SUM(su)
FROM
(SELECT SUM(inc) AS su FROM Income_o
UNION
SELECT -SUM(out) AS su FROM Outcome_o) AS someone

Задание: 62
Посчитать остаток денежных средств на всех пунктах приема на начало дня 15/04/01 для базы данных с отчетностью не чаще одного раза в день.

SELECT
(SELECT SUM(inc)
FROM Income_o i
WHERE i.date < '2001-04-15')
-
(SELECT SUM(out)
FROM Outcome_o o
WHERE o.date < '2001-04-15')

Задание: 63
Определить имена разных пассажиров, когда-либо летевших на одном и том же месте более одного раза.

SELECT name
FROM Passenger
WHERE ID_psg IN
(SELECT ID_psg
FROM Pass_in_trip
GROUP BY ID_psg, place
HAVING COUNT(*) > 1)

Задание: 64
Используя таблицы Income и Outcome, для каждого пункта приема определить дни, когда был приход, но не было расхода и наоборот.
Вывод: пункт, дата, тип операции (inc/out), денежная сумма за день.

SELECT income.point, income.date, 'inc' AS operation, SUM(income.inc) AS money_sum
FROM income LEFT JOIN outcome
ON income.date = outcome.date AND income.point = outcome.point
WHERE outcome.date IS NULL
GROUP BY income.point, income.date
UNION
SELECT outcome.point, outcome.date, 'out' AS operation, SUM(outcome.out) AS money_sum
FROM outcome left JOIN income
ON income.date = outcome.date AND income.point = outcome.point
WHERE income.date IS NULL
GROUP BY outcome.point, outcome.date

Задание: 67
Найти количество маршрутов, которые обслуживаются наибольшим числом рейсов.
Замечания.
1) A - B и B - A считать РАЗНЫМИ маршрутами.
2) Использовать только таблицу Trip

SELECT COUNT(cou)
FROM
(SELECT COUNT(trip_no) AS cou, town_from, town_to
FROM Trip
GROUP BY town_from, town_to) AS a
WHERE cou IN (SELECT MAX(couu)
FROM
(SELECT COUNT(trip_no) AS couu, town_from, town_to
FROM Trip
GROUP BY town_from, town_to) AS b)

Задание: 70
Укажите сражения, в которых участвовало по меньшей мере три корабля одной и той же страны.

SELECT DISTINCT battle AS bat
FROM
(SELECT battle, ship, country
FROM Outcomes, Classes c
WHERE ship = c.class
UNION
SELECT battle, ship, country
FROM Outcomes, Classes c, Ships s
WHERE ship = s.name AND s.class = c.class) AS a
GROUP BY battle, country
HAVING COUNT(ship) >= 3

Задание: 74
Вывести классы всех кораблей России (Russia). Если в базе данных нет классов кораблей России, вывести классы для всех имеющихся в БД стран.
Вывод: страна, класс

SELECT country, class
FROM Classes
WHERE 'Russia' NOT IN (SELECT country FROM Classes)
UNION
SELECT country, class
FROM Classes
WHERE country = 'Russia'

Задание: 80
Найти производителей компьютерной техники, у которых нет моделей ПК, не представленных в таблице PC.

SELECT DISTINCT maker
FROM product
WHERE maker NOT IN (
SELECT maker
FROM product
WHERE type = 'pc'
AND model NOT IN (
SELECT model
FROM pc))

Задание: 83
Определить названия всех кораблей из таблицы Ships, которые удовлетворяют, по крайней мере, комбинации любых четырёх критериев из следующего списка:
numGuns = 8
bore = 15
displacement = 32000
type = bb
launched = 1915
class=Kongo
country=USA

SELECT name
FROM Ships s, Classes c
WHERE s.class = c.class
AND (
CASE WHEN c.numGuns = 8 THEN 1 ELSE 0 END +
CASE WHEN c.bore = 15 THEN 1 ELSE 0 END +
CASE WHEN c.displacement = 32000 THEN 1 ELSE 0 END +
CASE WHEN c.type = 'bb' THEN 1 ELSE 0 END +
CASE WHEN s.launched = 1915 THEN 1 ELSE 0 END +
CASE WHEN c.class = 'Kongo' THEN 1 ELSE 0 END +
CASE WHEN c.country = 'USA' THEN 1 ELSE 0 END >= 4)

Задание: 85
Найти производителей, которые выпускают только принтеры или только PC.
При этом искомые производители PC должны выпускать не менее 3 моделей.

SELECT maker
FROM product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1
AND (MAX(type) = 'printer' OR (MAX(type) = 'pc' AND COUNT(model) >= 3))

Задание: 86
Для каждого производителя перечислить в алфавитном порядке с разделителем "/" все типы выпускаемой им продукции.
Вывод: maker, список типов продукции

SELECT maker,
CASE COUNT(DISTINCT type) WHEN 3 THEN 'Laptop/PC/Printer'
WHEN 2 THEN MIN(type) + '/' + MAX(type)
WHEN 1 THEN MAX(type) END
FROM product
GROUP BY maker

Задание: 89
Найти производителей, у которых больше всего моделей в таблице Product, а также тех, у которых меньше всего моделей.
Вывод: maker, число моделей

WITH a AS (SELECT DISTINCT maker, COUNT(model) b FROM product GROUP BY maker)
SELECT DISTINCT maker, COUNT(model) b
FROM product
GROUP BY maker
HAVING COUNT(model) = (SELECT MAX(b) FROM a)
OR COUNT(model) = (SELECT MIN(b) FROM a)

Задание: 90
Вывести все строки из таблицы Product, кроме трех строк с наименьшими номерами моделей и трех строк с наибольшими номерами моделей.

SELECT a.maker, a.model, a.type
FROM
(SELECT *,
row_number() OVER(ORDER BY model) c1,
row_number() OVER(ORDER BY model DESC) c2
FROM product) a
WHERE c1 > 3 AND c2 > 3

Задание: 91
C точностью до двух десятичных знаков определить среднее количество краски на квадрате.

SELECT CAST(AVG(T.s) AS NUMERIC(6,2)) FROM 
(SELECT q.Q_NAME, CAST(SUM(ISNULL(B_VOL, 0)) AS NUMERIC(6,2)) as s 
FROM utQ q LEFT JOIN utB B
ON q.Q_ID=B.B_Q_ID
group by q.Q_NAME) T

Задание: 125
Данные о продаваемых моделях и ценах (из таблиц Laptop, PC и Printer) объединить в одну таблицу LPP и создать в ней порядковую нумерацию (id) без пропусков и дубликатов. 
Считать...

SELECT row_number() over(ORDER BY data.Id) Id, data.type, data.model, data.price
FROM (SELECT row_number() over(ORDER BY l.id) Id, product.type, l.model, l.price
FROM (SELECT row_number() over(ORDER BY code) AS id, code, model, price
FROM laptop
WHERE code < (SELECT COUNT(code) FROM laptop) / 2 + 1
UNION
SELECT row_number() over(ORDER BY code DESC) AS id, code, model, price
FROM laptop
WHERE code > (SELECT COUNT(code) FROM laptop) / 2) AS l
INNER JOIN product ON product.model = l.model
UNION
SELECT row_number() over(ORDER BY p.id) Id, product.type, p.model, p.price
FROM (SELECT row_number() over(ORDER BY code) AS id, code, model, price
FROM pc
WHERE code < (SELECT COUNT(code) FROM pc) / 2 + 1
UNION
SELECT row_number() over(ORDER BY code DESC) AS id, code, model, price
FROM pc
WHERE code > (SELECT COUNT(code) FROM pc) / 2) AS p
INNER JOIN product ON product.model = p.model
UNION
SELECT row_number() over(ORDER BY pr.id) Id, product.type, pr.model, pr.price
FROM (SELECT row_number() over(ORDER BY code) AS id, code, model, price
FROM printer
WHERE code < (SELECT COUNT(code) FROM printer) / 2 + 1				
UNION				
SELECT row_number() over(ORDER BY code DESC) AS id, code, model, price
FROM printer
WHERE code > (SELECT COUNT(code) FROM printer) / 2) AS pr
INNER JOIN product ON product.model = pr.model) AS DATA
