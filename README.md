## Реляционные базы данных

## Описание, цели и задачи
Учебный проект по дисциплине «Базы данных».

**Цели:**
- Закрепить навыки проектирования реляционных схем и обеспечения ссылочной целостности.
- Отработать написание запросов разной сложности.
- Продемонстрировать умение структурировать SQL-проекты и документировать код.

## Структура баз данных и реализованные функции
1. **Vehicles** (таблицы Vehicle, Car, Motorcycle, Bicycle) 
2. **Racing** (таблицы Classes, Cars, Races, Results)
3. **Hotels** (таблицы Hotel, Room, Customer, Booking) 
4. **Organization** (таблицы Departments, Roles, Employees, Projects, Tasks)

## Инструкция по запуску и тестированию
Требуется PostgreSQL 15+.

1. Создайте базы данных:
   ```sql
   CREATE DATABASE db_vehicles;
   CREATE DATABASE db_racing;
   CREATE DATABASE db_hotels;
   CREATE DATABASE db_organization;
   ```

2. Инициализируйте схемы и данные (пример для Vehicles):
   ```bash
   psql -U postgres -d db_vehicles -f databases/01_vehicles/01_schema.sql
   psql -U postgres -d db_vehicles -f databases/01_vehicles/02_data.sql
   ```
   Повторите для остальных баз, изменив путь и имя БД.

3. Запустите проверку задачи:
   ```bash
   psql -U postgres -d db_vehicles -f solutions/01_vehicles/task_01.sql
   ```

## Документация кода
- Все решения оформлены в виде единых SQL-запросов, соответствующих условию.
- В начале каждого файла указан номер задачи и краткое описание логики.
- Использованы стандартные конструкции ANSI SQL, совместимые с PostgreSQL.
