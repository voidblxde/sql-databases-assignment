-- Задача 1: Лучший автомобиль по средней позиции в каждом классе
WITH CarStats AS (
    SELECT 
        c.name AS car_name,
        cl.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
    JOIN Classes cl ON c.class = cl.class
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, cl.class
),
Ranked AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY car_class ORDER BY average_position, car_name) as rn
    FROM CarStats
)
SELECT car_name, car_class, average_position, race_count
FROM Ranked
WHERE rn = 1
ORDER BY average_position;