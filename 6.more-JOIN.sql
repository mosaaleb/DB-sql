--1. 1962 movies
SELECT id,
         title
FROM movie
WHERE yr = 1962;

--2. When was Citizen Kane released?
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

--3. Star Trek movies
SELECT id,
         title,
         yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY  yr;

--4. id for actor Glenn Close
SELECT id
FROM actor
WHERE name = 'Glenn Close'

--5. id for Casablanca
SELECT id
FROM movie
WHERE title = 'Casablanca';

--6. Cast list for Casablanca
SELECT name
FROM actor
JOIN casting
    ON id = actorid
WHERE movieid = 11768;

--7. Alien cast list
SELECT actor.name
FROM casting
JOIN movie
    ON movieid = movie.id
JOIN actor
    ON actorid = actor.id
WHERE movie.title = 'Alien';

--8. Harrison Ford movies
SELECT movie.title
FROM casting
JOIN movie
    ON movieid = movie.id
JOIN actor
    ON actorid = actor.id
WHERE actor.name = 'Harrison Ford';

--9. Harrison Ford as a supporting actor
SELECT movie.title
FROM casting
JOIN movie
    ON movieid = movie.id
JOIN actor
    ON actorid = actor.id
WHERE actor.name = 'Harrison Ford'
        AND ord != 1;

--10.Lead actors in 1962 movies
SELECT title,
         name
FROM casting
JOIN movie
    ON movieid = movie.id
JOIN actor
    ON actorid = actor.id
WHERE ord = 1
        AND yr = 1962;