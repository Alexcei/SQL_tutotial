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