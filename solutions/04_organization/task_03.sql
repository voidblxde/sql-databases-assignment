WITH RECURSIVE AllDescendants AS (
    -- Базовый случай: все сотрудники, у которых есть менеджер
    SELECT EmployeeID, ManagerID
    FROM Employees
    WHERE ManagerID IS NOT NULL
    UNION ALL
    -- Рекурсивный шаг: ищем подчиненных подчиненных
    SELECT e.EmployeeID, ad.ManagerID
    FROM Employees e
             JOIN AllDescendants ad ON e.ManagerID = ad.EmployeeID
),
               RecursiveCounts AS (
                   -- Считаем общее количество подчиненных для каждого менеджера
                   SELECT ManagerID, COUNT(*) AS TotalSubordinates
                   FROM AllDescendants
                   GROUP BY ManagerID
               ),
-- Предварительная агрегация задач (чтобы избежать перекрёстного JOIN с проектами)
               EmpTasks AS (
                   SELECT AssignedTo, STRING_AGG(TaskName, ', ' ORDER BY TaskID DESC) AS TaskNames
                   FROM Tasks
                   GROUP BY AssignedTo
               ),
-- Предварительная агрегация проектов по отделам
               EmpProjects AS (
                   SELECT e.EmployeeID, STRING_AGG(p.ProjectName, ', ' ORDER BY p.ProjectID) AS ProjectNames
                   FROM Employees e
                            JOIN Projects p ON e.DepartmentID = p.DepartmentID
                   GROUP BY e.EmployeeID
               )
SELECT
    e.EmployeeID,
    e.Name AS EmployeeName,
    e.ManagerID,
    d.DepartmentName,
    r.RoleName,
    ep.ProjectNames,
    et.TaskNames,
    rc.TotalSubordinates
FROM Employees e
         JOIN Departments d ON e.DepartmentID = d.DepartmentID
         JOIN Roles r ON e.RoleID = r.RoleID
         LEFT JOIN EmpTasks et ON e.EmployeeID = et.AssignedTo
         LEFT JOIN EmpProjects ep ON e.EmployeeID = ep.EmployeeID
         JOIN RecursiveCounts rc ON e.EmployeeID = rc.ManagerID
WHERE r.RoleName = 'Менеджер' AND rc.TotalSubordinates > 0
ORDER BY e.EmployeeID;