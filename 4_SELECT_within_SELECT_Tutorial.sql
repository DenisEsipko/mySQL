-- # 1. List each country name where the population is larger than
-- # 'Russia'.

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
      
 -- #  2.    Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
 -- # Per Capita GDP
 -- # The per capita GDP is the gdp/population
 
 SELECT name FROM world
  WHERE continent = 'Europe'
AND
     gdp/population > 
(   SELECT gdp/population 
    FROM world
    WHERE name='United Kingdom'
)

-- # 3. Укажите название и континент стран континентов, содержащих либо Аргентину, либо Австралию.
-- # Сортировка по названию страны.

SELECT name, continent 
FROM world 
WHERE continent 
IN (
SELECT continent 
FROM world 
WHERE name IN ('Argentina', 'Australia')
   ) 
ORDER BY name;

-- # 4. В какой стране проживает больше, чем в Канаде, но меньше, чем в Польше? Покажите имя и население.

SELECT name,population 
FROM  world
WHERE  population >
(
SELECT population 
FROM  world
WHERE name ='Canada'
)  AND population <
(
SELECT population 
FROM  world
WHERE name ='Poland'
)

-- # 5. Германия (население 80 миллионов человек) имеет наибольшее население в странах Европы. Австрия (население 8,5 млн. 
-- # Человек) имеет 11% населения Германии.
-- # Покажите название и население каждой страны в Европе. Покажите население в процентах от населения Германии.
-- # Вы можете использовать функцию CONCAT для добавления символа процента.
SELECT name, CONCAT(ROUND (population/
(
SELECT population 
FROM world 
WHERE name = 'Germany')
*100,0), '%')
FROM world
WHERE continent = 'Europe'

-- # 6.  В каких странах ВВП выше, чем в каждой стране Европы? [Дать только имя.] (Некоторые страны могут иметь значения NULL gdp)

SELECT name
 FROM world
 WHERE gdp > ALL
(
SELECT gdp 
FROM world 
WHERE gdp > 0 
AND continent = 'Europe'
);


-- # 7. Найдите самую большую страну (по площади) на каждом континенте, покажите континент, название и область:
SELECT continent, name, area
 FROM world AS x
  WHERE area >= ALL
    (SELECT area FROM world AS y
        WHERE y.continent=x.continent
          AND population>0)
          
          
 -- # 8.Перечислите каждый континент и название страны, которая поступает первым в алфавитном порядке.
 SELECT continent, name
 FROM world AS x
  WHERE name <= ALL
    (SELECT name FROM world AS y
        WHERE y.continent=x.continent
          )
          

