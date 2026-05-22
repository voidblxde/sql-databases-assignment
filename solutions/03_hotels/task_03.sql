-- Задача 3: Предпочтения клиентов по типу отелей
WITH HotelCategories AS (
    SELECT
        h.ID_hotel,
        h.name AS hotel_name,
        CASE
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) <= 300 THEN 'Средний'
            ELSE 'Дорогой'
            END AS category
    FROM Hotel h
             JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
     CustomerHotels AS (
         SELECT DISTINCT
             c.ID_customer,
             c.name,
             hc.category,
             hc.hotel_name
         FROM Customer c
                  JOIN Booking b ON c.ID_customer = b.ID_customer
                  JOIN Room r ON b.ID_room = r.ID_room
                  JOIN HotelCategories hc ON r.ID_hotel = hc.ID_hotel
     ),
     CustomerPreferences AS (
         SELECT
             ID_customer,
             name,
             CASE
                 WHEN BOOL_OR(category = 'Дорогой') THEN 'Дорогой'
                 WHEN BOOL_OR(category = 'Средний') THEN 'Средний'
                 ELSE 'Дешевый'
                 END AS preferred_hotel_type,
             STRING_AGG(hotel_name, ',' ORDER BY hotel_name) AS visited_hotels
         FROM CustomerHotels
         GROUP BY ID_customer, name
     )
SELECT
    ID_customer,
    name,
    preferred_hotel_type,
    visited_hotels
FROM CustomerPreferences
ORDER BY
    CASE preferred_hotel_type
        WHEN 'Дешевый' THEN 1
        WHEN 'Средний' THEN 2
        WHEN 'Дорогой' THEN 3
        END,
    ID_customer;