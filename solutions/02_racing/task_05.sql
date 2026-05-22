-- Задача 5: Классы с наибольшим кол-вом авто с позицией > 3.0
-- Логика: 
-- 1. Считаем low_position_count по условию >= 3.0 (чтобы Sedan получил 2 балла)
-- 2. Фильтруем итоговые строки по > 3.0 (чтобы исключить BMW 3 Series из вывода)
-- 3. total_races = кол-во автомобилей в классе, участвовавших в гонках

WITH CarStats AS (
    SELECT 
        c.name AS car_name,
        c.class AS car_class,
        cl.country AS car_country,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
    JOIN Classes cl ON c.class = cl.class
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class, cl.country
),
ClassStats AS (
    SELECT 
        car_class,
        car_country,
        COUNT(*) AS total_races,
        COUNT(*) FILTER (WHERE average_position >= 3.0) AS low_position_count
    FROM CarStats
    GROUP BY car_class, car_country
)
SELECT 
    cs.car_name,
    cs.car_class,
    cs.average_position,
    cs.race_count,
    cs.car_country,
    cls.total_races,
    cls.low_position_count
FROM CarStats cs
JOIN ClassStats cls ON cs.car_class = cls.car_class
WHERE cs.average_position > 3.0
ORDER BY cls.low_position_count DESC, cs.car_class, cs.car_name;