USE employee;
SELECT COUNT(*) FROM travel_bpo_employee_data_simplified;

SELECT * FROM travel_bpo_employee_data_simplified LIMIT 10;

SELECT Department, COUNT(*) AS Total_Employees
FROM travel_bpo_employee_data_simplified
GROUP BY Department
ORDER BY Total_Employees DESC;

SELECT Gender, COUNT(*) AS Count,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) 
FROM travel_bpo_employee_data_simplified), 2) AS Percentage
FROM travel_bpo_employee_data_simplified
GROUP BY Gender;

SELECT City, COUNT(*) AS Total_Employees
FROM travel_bpo_employee_data_simplified
GROUP BY City
ORDER BY Total_Employees DESC;

SELECT City, COUNT(*) AS Total_Employees
FROM travel_bpo_employee_data_simplified
GROUP BY City
ORDER BY Total_Employees DESC;

SELECT Shift, COUNT(*) AS Total_Employees
FROM travel_bpo_employee_data_simplified
GROUP BY Shift
ORDER BY Total_Employees DESC;

SELECT Department, Gender, COUNT(*) AS Count
FROM travel_bpo_employee_data_simplified
GROUP BY Department, Gender
ORDER BY Department, Count DESC;

SELECT Process_Type, COUNT(*) AS Total
FROM travel_bpo_employee_data_simplified
GROUP BY Process_Type
ORDER BY Total DESC;

SELECT City, COUNT(*) AS Headcount,
RANK() OVER (ORDER BY COUNT(*) DESC) AS City_Rank
FROM travel_bpo_employee_data_simplified
GROUP BY City;

SELECT Department, COUNT(*) AS Headcount
FROM travel_bpo_employee_data_simplified
GROUP BY Department
HAVING COUNT(*) > (
    SELECT AVG(dept_count) 
    FROM (
        SELECT COUNT(*) AS dept_count 
        FROM travel_bpo_employee_data_simplified 
        GROUP BY Department
    ) AS dept_avg
);

WITH CityProcess AS (
    SELECT City, Process_Country, COUNT(*) AS Count
    FROM travel_bpo_employee_data_simplified
    GROUP BY City, Process_Country
)
SELECT City,
MAX(CASE WHEN Process_Country = 'USA' THEN Count ELSE 0 END) AS USA_Employees,
MAX(CASE WHEN Process_Country = 'UK' THEN Count ELSE 0 END) AS UK_Employees,
SUM(Count) AS Total
FROM CityProcess
GROUP BY City
ORDER BY Total DESC;


