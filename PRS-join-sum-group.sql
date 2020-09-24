/*select r.description, u.LastName, p.name, l.quantity, p.price,
(l.quantity * p.price) as 'subtotal'*/
select r.description, sum(l.quantity * p.price) as 'total'
from Requests r
left join users u on u.id = r.UserId
left join LineItem l on r.id = l.RequestId
left join Products p on p.id=  l.productid
group by r.description
