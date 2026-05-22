-- Задача 1: Рекурсивное дерево подчинения + проекты и задачи
WITH RECURSIVE EmpTree AS (
    SELECT EmployeeID, Name, ManagerID, DepartmentID, RoleID
    FROM Employees
    WHERE EmployeeID = 1
    UNION ALL
    SELECT e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
    FROM Employees e
             JOIN EmpTree et ON e.ManagerID = et.EmployeeID
)
SELECT
    et.EmployeeID,
    et.Name AS EmployeeName,
    et.ManagerID,
    d.DepartmentName,
    r.RoleName,
    STRING_AGG(p.ProjectName, ', ' ORDER BY p.ProjectID) AS ProjectNames,
    STRING_AGG(t.TaskName, ', ' ORDER BY t.TaskID DESC) AS TaskNames
FROM EmpTree et
         LEFT JOIN Departments d ON et.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r ON et.RoleID = r.RoleID
         LEFT JOIN Projects p ON et.DepartmentID = p.DepartmentID
         LEFT JOIN Tasks t ON et.EmployeeID = t.AssignedTo
GROUP BY et.EmployeeID, et.Name, et.ManagerID, d.DepartmentName, r.RoleName
ORDER BY et.Name;