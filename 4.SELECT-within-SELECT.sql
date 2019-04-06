--1. Bigger than Russia
SELECT name
FROM world
WHERE population > 
    (SELECT population
    FROM world
    WHERE name = 'Russia');

--2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name
FROM world
WHERE continent = 'Europe'
        AND gdp / population >
    (SELECT gdp / population
    FROM world
    WHERE name = 'United Kingdom');

--3. Neighbours of Argentina and Australia
SELECT name,
         continent
FROM world
WHERE continent IN 
    (SELECT continent
    FROM world
    WHERE name IN ('Argentina', 'Australia'))
ORDER BY  name;

--4. Between Canada and Poland
SELECT name,
         population
FROM world
WHERE population > 
    (SELECT population
    FROM world
    WHERE name = 'Canada')
        AND population < 
    (SELECT population
    FROM world
    WHERE name = 'Poland');

--5. Percentages of Germany
SELECT name,
         CONCAT(ROUND(population/
    (SELECT population
    FROM world
    WHERE name = 'Germany')*100), '%')
FROM world
WHERE continent = 'Europe';

--6. Bigger than every country in Europe
SELECT name
FROM world
WHERE gdp > ALL
    (SELECT gdp
    FROM world
    WHERE gdp > 0
            AND continent = 'Europe');

--7. Largest in each continent
SELECT continent,
         name,
         area
FROM world x
WHERE area >= ALL
    (SELECT area
    FROM world y
    WHERE x.continent = y.continent
            AND y.area > 0);

--8. First country of each continent (alphabetically)
SELECT continent,
         name
FROM world x
WHERE name <= ALL
    (SELECT name
    FROM world y
    WHERE x.continent = y.continent);

----Difficult questions
--9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name,
         continent,
         population
FROM world
WHERE continent IN 
    (SELECT continent
    FROM world x
    WHERE 25000000 >= 
        (SELECT MAX(population)
        FROM world y
        WHERE x.continent = y.continent)); ORSELECT y.name,
         y.continent,
         y.population
    FROM world AS y
JOIN 
    (SELECT continent,
         max(population)
    FROM world
    GROUP BY  continent
    HAVING max(population) <= 25000000) AS x
    ON y.continent = x.continent;

--10. Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT x.name,
         x.continent
FROM world AS x
WHERE x.population/3 > ALL 
    (SELECT y.population
    FROM world AS y
    WHERE x.continent = y.continent
            AND x.name != y.name);