use classicmodels;

# 1. Obtén la cantidad de productos de cada orden.
select ordernumber, sum(quantityOrdered) as ProductsQuantity from orderdetails group by ordernumber;

# 2. Obten el número de orden, estado y costo total de cada orden.
select o.orderNumber, o.status, sum(quantityOrdered*priceEach) as total from orders as o
join orderdetails as od
on o.orderNumber=od.orderNumber
group by orderNumber;

# 3. Obten el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza.
select o.orderNumber, o.requiredDate, od.orderLineNumber, p.productName, od.quantityOrdered, od.priceEach
from orders o 
join orderdetails od on o.orderNumber=od.orderNumber
join products p on od.productCode=p.productCode;

# 4. Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
select od.orderNumber, p.productName, p.MSRP, od.priceEach
from orderdetails od
join products p on od.productCode=p.productCode;

# Para estas consultas usa LEFT JOIN
# 5. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. ¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
select c.customerNumber, c.customerName, o.orderNumber, o.status
from customers c
left join orders o
on c.customerNumber=o.customerNumber;

# 6. Obtén los clientes que no tienen una orden asociada.
select c.customerNumber, c.customerName, o.orderNumber from customers c
left join orders o on c.customerNumber=o.customerNumber
where o.orderNumber is null;

# 7. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
select e.lastName, e.firstName, c.customerName, p.checkNumber, p.amount
from employees e
left join customers c on e.employeeNumber=c.salesRepEmployeeNumber
left join payments p on c.customerNumber=p.customerNumber;

# Para estas consultas usa RIGHT JOIN
# 8. Repite los ejercicios 5 a 7 usando RIGHT JOIN. ¿Representan lo mismo? Explica las diferencias en un comentario. Para poner comentarios usa --.
# Rep 5
select c.customerNumber, c.customerName, o.orderNumber, o.status
from customers c
right join orders o
on c.customerNumber=o.customerNumber;

# Rep 6
select c.customerNumber, c.customerName, o.orderNumber from customers c
right join orders o on c.customerNumber=o.customerNumber
where o.orderNumber is null;

#Rep 7
select e.lastName, e.firstName, c.customerName, p.checkNumber, p.amount
from employees e
right join customers c on e.employeeNumber=c.salesRepEmployeeNumber
right join payments p on c.customerNumber=p.customerNumber;

# 9. Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta para cada una.
# View 1
create view orders_710 as
(select o.orderNumber, o.requiredDate, od.orderLineNumber, p.productName, od.quantityOrdered, od.priceEach
from orders o 
join orderdetails od on o.orderNumber=od.orderNumber
join products p on od.productCode=p.productCode);

# View 2
create view customersorders_710 as 
(select c.customerNumber, c.customerName, o.orderNumber, o.status
from customers c
left join orders o
on c.customerNumber=o.customerNumber);

# View 3
create view employeecustomers_710 as 
(select e.lastName, e.firstName, c.customerName, p.checkNumber, p.amount
from employees e
left join customers c on e.employeeNumber=c.salesRepEmployeeNumber
left join payments p on c.customerNumber=p.customerNumber);


