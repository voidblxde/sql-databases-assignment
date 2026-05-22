-- Задача 4: Автомобили, опережающие средний показатель своего класса (класс >= 2 авто)
WITH CarAgg AS (
    SELECT c.name, c.class, cl.country, AVG(r.position) as car_avg, COUNT(*) as race_count
    FROM Cars c 
    JOIN Classes cl ON c.class = cl.class 
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class, cl.country
),
ClassAgg AS (
    SELECT class, AVG(car_avg) as class_avg, COUNT(*) as car_count
    FROM CarAgg 
    GROUP BY class
)
SELECT 
    ca.name AS car_name,
    ca.class AS car_class,
    ca.car_avg AS average_position,
    ca.race_count,
    ca.country AS car_country
FROM CarAgg ca
JOIN ClassAgg cl ON ca.class = cl.class
WHERE ca.car_avg < cl.class_avg 
  AND cl.car_count >= 2
ORDER BY ca.class, ca.car_avg;