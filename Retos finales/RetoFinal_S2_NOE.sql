# NOE GONZALEZ RETO FINAL S2

#1 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con A.
SELECT 
    employeeNumber, lastName, firstName
FROM
    employees
WHERE
    firstName LIKE 'A%';

#2 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo apellido termina con on.
SELECT 
    employeeNumber, lastName, firstName
FROM
    employees
WHERE
    lastName LIKE '%on';

#3 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
SELECT 
    employeeNumber, lastName, firstName
FROM
    employees
WHERE
    firstName LIKE '%on%';

#4 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen seis letras e inician con G.
SELECT 
    employeeNumber, lastName, firstName
FROM
    employees
WHERE
    LENGTH(firstName) = 6
        AND firstName LIKE 'g%';

#5 Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B.
SELECT 
    employeeNumber, lastName, firstName
FROM
    employees
WHERE
    firstName NOT LIKE 'B%';

#6 Dentro de la tabla products, obten el código de producto y nombre de los productos cuyo código incluye la cadena _20.
SELECT 
    productCode, productName
FROM
    products
WHERE
    productCode LIKE '%_20%';

#7 Dentro de la tabla orderdetails, obten el total de cada orden.
SELECT 
    orderNumber, (quantityOrdered * priceEach) AS OrderTotal
FROM
    orderdetails;

#8 Dentro de la tabla orders obten el número de órdenes por año.
SELECT 
    YEAR(orderDate) AS Year, COUNT(*) AS OrdersCount
FROM
    orders
GROUP BY YEAR(orderDate);

#9 Obten el apellido y nombre de los empleados cuya oficina está ubicada en USA.
SELECT 
    lastName, firstName
FROM
    employees
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            offices
        WHERE
            country = 'USA');

#10 Obten el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.
SELECT 
    customerNumber, checkNumber, amount
FROM
    payments
ORDER BY amount DESC
LIMIT 1;

#11 Obten el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.
SELECT 
    customerNumber, checkNumber, amount
FROM
    payments
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            payments);

#12 Obten el nombre de aquellos clientes que no han hecho ninguna orden.
SELECT 
    customerName
FROM
    customers
WHERE
    customerNumber NOT IN (SELECT DISTINCT
            customerNumber
        FROM
            orders);

#13 Obten el máximo, mínimo y promedio del número de productos en las órdenes de venta.
SELECT 
    MAX(TotalProductos),
    MIN(TotalProductos),
    AVG(TotalProductos)
FROM
    (SELECT 
        ordernumber, SUM(quantityOrdered) AS TotalProductos
    FROM
        orderdetails
    GROUP BY orderNumber) AS sq;

#14 Dentro de la tabla orders, obten el número de órdenes que hay por cada estado.
SELECT 
    status, COUNT(*)
FROM
    orders
GROUP BY status;