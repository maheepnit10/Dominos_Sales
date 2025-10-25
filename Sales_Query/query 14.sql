-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
-- basically top 3 pizzas in each category

select category, name, revenue
from
(select category, name, revenue,
rank() over(partition by category order by revenue desc) as ranks
from
(select pizza_types.category, pizza_types.name,
round(sum(pizzas.price*order_details.quantity),0) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category, pizza_types.name
order by revenue desc) as a) as b
where ranks<=3;