/*
 * 1- Crea el esquema de la BBDD
 */

/*
 * 2- Muestra los nombres de todas las películas con una clasificación por edades de 'R'
 */

select 
	f.title as Titulo ,
	f.rating 
from film f 
where f.rating = 'R';

/*
 * 3-Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40
 */

select 
	concat(a.first_name, ' ', a.last_name ) as Nombre_actor,
	a.actor_id 
from actor a 
where a.actor_id between 30 and 40;

/*
 * 4- Obtén las películas cuyo idioma coincide con el idioma original
 */

select 
	f.title as titulo,
	f.language_id ,
	f.original_language_id 
from film f 
where f.language_id = f.original_language_id; 

/*
 * 5- Ordena las películas por duración de forma ascendente.
 */

select 
	f.title as titulo,
	f.rental_duration as duracion
from film f 
order by f.rental_duration asc;

/*
 * 6- Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
 */

select concat(a.first_name ,' ', a.last_name ) as nombre
from actor a 
where a.last_name like '%ALLEN%';

/*
 * 7- Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y 
muestra la clasificación junto con el recuento.
 */

select 
	f.rating ,
	COUNT(*) as total_peliculas
from film f 
group by f.rating 
order by total_peliculas desc;

/*
 * 8- Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.
*/

select 
	f.title as titulo,
	f.rating as clasificacion ,
	f.length as duracion
from film f 
where f.rating = 'PG-13'
	or f.length > 180;

/*
 * 9- Encuentra la variabilidad de lo que costaría reemplazar las películas.
 */

select 
	var_pop(f.replacement_cost ) as varianza_reemplazo
from film f;

/*
 * 10- Encuentra la mayor y menor duración de una película de nuestra BBDD.
 */

select
	MAX(f.length ) as duracion_maxima,
	MIN(f.length ) as duracion_minima
from film f; 

/*
 * 11- Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
 */

select p.amount 
from payment p 
order by p.payment_date desc
offset 2
limit 1;

/*
 * 12- Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-
17’ ni ‘G’ en cuanto a su clasificación.
 */

select f.title as titulo,
	f.rating as clasificacion
from film f 
where f.rating not in ('NC-17', 'G');

/*
 * 13- Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y 
muestra la clasificación junto con el promedio de duración.
 */

select 
	f.rating as clasificacion, 
	AVG(f.length ) as promedio_duracion
from film f 
group by f.rating 
order by promedio_duracion desc;

/*
 * 14- Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.
 */

select f.title as titulo,
	f.length as duracion
from film f 
where f.length > 180;

/*
 * 15- ¿Cuánto ha generado en totaal la empresa?
 */

select SUM(p.amount ) as ingresos_totales
from payment p;

/*
 * 16- Muestra los 10 clientes con mayor valor de id
 */

select c.customer_id , 
	concat(c.first_name ,' ', c.last_name ) as nombre_cliente
from customer c 
order by c.customer_id desc
limit 10;

/*
 * 17- Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’.
 */

select 
	concat(a.first_name ,' ', a.last_name ) as nombre_actor
from actor a 
join film_actor fa on a.actor_id = fa.actor_id 
join film f on fa.film_id = f.film_id 
where f.title = 'EGG IGBY';

/*
 * 18- Selecciona todos los nombres de las películas únicos.
 */

select distinct f.title as titulo
from film f
order by f.title asc;

/*
 * 19- Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.
 */

select f.title as titulo,
	c."name"  as categoria,
	f.length as duracion
from film f 
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where c."name" = 'Comedy' and f.length > 180;

/*
 * 20- Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos 
y muestra el nombre de la categoría junto con el promedio de duración.
 */

select c."name" as categoria,
	AVG(F.length ) as promedio_duracion
from film f 
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
group by c."name" 
having AVG(f.length ) > 110
order by promedio_duracion desc;

/*
 * 21- ¿Cuál es la media de duración del alquiler de las películas?
 */

select AVG(r.return_date - r.rental_date ) as media_duracion_alquiler
from rental r;

/*
 * 22- Crea una columna con el nombre y apellidos de todos los actores y
actrices.
 */

select concat(a.first_name , ' ', a.last_name ) as nombre_completo
from actor a
order by nombre_completo asc;

/*
 * 23- Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.
 */

select DATE(r.rental_date ) as dia,
	Count(*) as numero_alquileres
from rental r 
group by DATE(r.rental_date)
order by numero_alquileres desc;

/*
 * 24- Encuentra las películas con una duración superior al promedio.
 */

select f.title as titulo,
	f.length as duracion
from film f 
where f.length >(
	select AVG(f2.length) as promedio_duracion
	from film f2 
);

/*
 * 25- Averigua el número de alquileres registrados por mes.
 */

select 
	date_trunc('month', r.rental_date ) as mes,
	count(*) as numero_alquileres
from rental r
group by date_trunc('month', r.rental_date )
order by mes;

/*
 * 26- Encuentra el promedio, la desviación estándar y varianza del total
pagado.
 */

select 
	AVG(p.amount) as promedio,
	stddev(p.amount ) as desviacion_estandar,
	var_samp(p.amount ) as varianza
from payment p;

/*
 * 27- ¿Qué películas se alquilan por encima del precio medio?
 */

select 
	f.title as titulo,
	f.rental_rate as tarifa_alquiler
from film f
where f.rental_rate > (
	select AVG(f2.rental_rate)
	from film f2 
)
order by f.rental_rate desc;

/*
 * 28- Muestra el id de los actores que hayan participado en más de 40
películas.
 */

select 
	fa.actor_id 
from film_actor fa 
group by actor_id 
having count(fa.film_id ) > 40;

/*
 * 29- Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.
 */

select 
	f.film_id,
	f.title as titulo,
	count(i.inventory_id ) as cantidad_disponible
from film f 
left join inventory i 
	on f.film_id = i.film_id 
group by f.film_id , f.title 
order by f.title;

/*
 * 30- Obtener los actores y el número de películas en las que ha actuado.
 */

select 
	a.actor_id ,
	concat(a. first_name , ' ', a.last_name ) as nombre_completo,
	count(fa.film_id ) as numero_peliculas
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id, concat(a. first_name , ' ', a.last_name )
order by numero_peliculas desc;

/*
 * 31- Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.
 */

select 
	f.film_id ,
	f.title as titulo,
	a.actor_id ,
	concat(a.first_name , ' ', a.last_name ) as nombre_actor
from film f 
left join film_actor fa 
	on f.film_id = fa.film_id 
left join actor a 
	on fa.actor_id = a.actor_id 
order by f.title , nombre_actor;

/*
 * 32- Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.
 */

select 
	a.actor_id ,
	concat(a.first_name , ' ', a.last_name ) as nombre_actor,
	f.film_id ,
	f.title as titulo
from actor a
left join film_actor fa 
	on a.actor_id  = fa.actor_id  
left join film f 
	on fa.film_id  = f.film_id 
order by nombre_actor, f.title;

/*
 * 33- Obtener todas las películas que tenemos y todos los registros de
alquiler.
 */

select 
	f.film_id ,
	f.title as titulo,
	r.rental_id ,
	r.rental_date ,
	r.return_date 
from film f 
left join inventory i 
	on f.film_id = i.film_id 
left join rental r 
	on i.inventory_id = r.inventory_id 
order by titulo , r.rental_date;

/*
 * 34- Encuentra los 5 clientes que más dinero hayan gastado en nosotros
 */

select 
	c.customer_id, 
	concat(c.first_name ,' ', c.last_name ) as nombre_cliente,
	SUM(p.amount ) as total_gastado
from customer c 
join payment p 
	on c.customer_id = p.customer_id 
group by c.customer_id , concat(c.first_name ,' ', c.last_name )
order by total_gastado desc 
limit 5;

/*
 * 35- Selecciona todos los actores cuyo primer nombre es 'Johnny'.
 */

select 
	a.actor_id,
	a.first_name,
	a.last_name 
from actor a 
where a.first_name = 'JOHNNY';

/*
 *36- Renombra la columna "first_name" como Nombre y "last_name" como Apellido. 
 */

select 
	a.first_name as Nombre,
	a.last_name as Apellido
from actor a;
	
/*
 * 37- Encuentra el ID del actor más bajo y más alto en la tabla actor.
 */

select 
	MIN(a.actor_id ) as minimo,
	MAX(a.actor_id ) as maximo	
from actor a;

/*
 * 38- Cuenta cuántos actores hay en la tabla "actor".
 */

select count(*) as total_actores
from actor a;

/*
 * 39- Selecciona todos los actores y ordénalos por apellido en orden ascendente.
 */

select *
from actor a 
order by a.last_name asc;

/*
 * 40- Selecciona las primeras 5 películas de la tabla "film".
 */

select *
from film f 
limit 5;

/*
 * 41- Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre.
 ¿Cuál es el nombre más repetido?
 */

select 
	a.first_name as nombre,
	count(*) as total
from actor a 
group by a.first_name 
order by total desc;

--Para obtener simplemente el nombre más repetido, se añade LIMIT 1--
select 
	a.first_name as nombre,
	count(*) as total
from actor a 
group by a.first_name 
order by total desc
limit 1;

/*
 * 42- Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.
 */

select 
	r.rental_id ,
	r.rental_date as fecha_alquiler,
	c.first_name as nombre,
	c. last_name as apellido
from rental r 
join customer c on r.customer_id = c.customer_id; 

/*
 * 43- Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.
 */

select 
	c.customer_id ,
	c.first_name as nombre,
	c.last_name as apellido,
	r.rental_id ,
	r.rental_date as fecha_alquiler
from customer c 
left join rental r 
	on c.customer_id = r.customer_id
order by c.customer_id;

/*
 * 44- Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.
 */

select 
	f.title as titulo,
	c."name" as nombre_categoria
from film f 
cross join category c;

/*Esta consulta no aporta un valor práctico ya que se obtienen más filas de las que tenemos originalmente,
por lo que dificulta la capacidad de analizar dicha consulta y, por otro lado, entre las tablas elegidas
no existe una relación directa.*/

/*
 * 45- Encuentra los actores que han participado en películas de la categoría
'Action'.
 */

select 
	a.first_name as nombre_actor,
	a.last_name as apellido_actor
from actor a 
where a.actor_id in (
	select fa.actor_id  
	from film_actor fa 
	join film_category fc on fa.film_id = fc.film_id 
	join category c on fc.category_id = c.category_id 
	where c."name" = 'Action'
);

/*
 * 46- Encuentra todos los actores que no han participado en películas.
 */

select 
	a.first_name as nombre_actor,
	a.last_name as apellido_actor
from actor a 
where a.actor_id not in (
	select a.actor_id 
	from film_actor fa 
);

/*
 * 47- Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.
*/

select
	a.first_name as nombre,
	a.last_name as apellido,
	count(fa.film_id ) as total_peliculas
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id , a.first_name , a.last_name 
order by total_peliculas desc;

/*
 * 48- Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.
 */

create view actor_num_peliculas as
select
	a.first_name as nombre,
	a.last_name as apellido,
	count(fa.film_id ) as total_peliculas
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id , a.first_name , a.last_name;

select *
from actor_num_peliculas anp;

/*
 * 49- Calcula el número total de alquileres realizados por cada cliente.
 */

select
	c.customer_id ,
	c.first_name as nombre_cliente,
	c.last_name as apellido_cliente,
	count(r.rental_id ) as total_alquileres
from rental r 
left join customer c 
	on r.customer_id = c.customer_id
group by c.customer_id , c.first_name , c.last_name 
order by total_alquileres desc;

/*
 * 50- Calcula la duración total de las películas en la categoría 'Action'.
 */

select 
	SUM(f.length ) as duracion_total
from film f 
where f.film_id in (
	select fc.film_id 
	from film_category fc 
	join category c 
		on fc.category_id = c.category_id 
		where c."name" ='Action'
);

/*
 * 51- Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.
 */

create temp table cliente_rentas_temporal as
select 
	c.customer_id ,
	c.first_name as nombre_cliente,
	c.last_name as apellido_cliente,
	count(R.rental_id ) as total_alquileres
from customer c 
left join rental r 
	on c.customer_id = r.customer_id
group by c.customer_id , c.first_name , c.last_name;

select *
from cliente_rentas_temporal;

/*
 * 52- Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.
 */

create temp table peliculas_alquiladas as
select
	film_id ,
	title as titulo
from film
where film_id in (
	select i.film_id
	from inventory i 
	join rental r 
		on i.inventory_id = r.inventory_id 
	group by i.film_id 
	having count(r.rental_id ) >= 10
);

select *
from peliculas_alquiladas;

/*
 * 53- Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre 
 ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título 
 de película.
 */

select distinct 
	f.title as titulo
from film f 
where EXISTS (
	select 1
	from customer c 
	join rental r 
		on c.customer_id = r.customer_id 
	join inventory i 
		on r.inventory_id = i.inventory_id 
	where c.first_name = 'TAMMY'
		and c.last_name = 'SANDERS'
		and r.return_date is null
		and i.film_id = f.film_id 
)
order by titulo asc;

/*
 * 54- Encuentra los nombres de los actores que han actuado en al menos una película que 
pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
 */

select distinct 
	a.first_name as nombre_actor,
	a.last_name as apellido_actor
from actor a 
where a.actor_id in (
	select fa.actor_id 
	from film_actor fa
	where fa.film_id in (
		select fc.film_id 
		from film_category fc 
		join category c 
			on fc.category_id = c.category_id 
		where c.name = 'Sci-Fi'
	)
)
order by apellido_actor asc;

/*
 * 55- Encuentra el nombre y apellido de los actores que han actuado en películas que se
alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez.
Ordena los resultados alfabéticamente por apellido.
 */

select distinct 
	a.first_name as nombre_actor, 
	a.last_name as apellido_actor
from actor a
join film_actor fa 
	on a.actor_id = fa.actor_id
join film f 
	on fa.film_id = f.film_id
join inventory i 
	on f.film_id = i.film_id
join rental r 
	on i.inventory_id = r.inventory_id
where r.rental_date > (
    select MIN(r2.rental_date)
    from rental r2
    join inventory i2 
    	on r2.inventory_id = i2.inventory_id
    join film f2 
    	on i2.film_id = f2.film_id
    where f2.title = 'SPARTACUS CHEAPER'
)
order by apellido_actor;

/*
 * 56- Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.
 */

select
	a.first_name as nombre_actor, 
	a.last_name as apellido_actor
from actor a
where not exists (
    select 1
    from film_actor fa
    join film_category fc 
    	on fa.film_id = fc.film_id
    join category c 
    	on fc.category_id = c.category_id
    where fa.actor_id = a.actor_id
      and c.name = 'Music'
)
order by apellido_actor;

/*
 * 57- Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.
 */

select distinct 
	f.title as titulo
from film f
join inventory i 
	on f.film_id = i.film_id
join rental r 
	on i.inventory_id = r.inventory_id
where extract 
	(day from (r.return_date - r.rental_date)) > 8
order by titulo asc;

/*
 * 58- Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.
 */

select 
	f.title as titulo
from film f
join film_category fc 
	on f.film_id = fc.film_id
where fc.category_id = (
    select category_id
    from category
    where name = 'Animation'
)
order by titulo asc;

/*
 * 59- Encuentra los nombres de las películas que tienen la misma duración que la película 
con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
 */

select 
	title as titulo
from film
where length = (
    select length as duracion_pelicula
    from film
    where title = 'DANCING FEVER'
)
and title  <> 'DANCING FEVER'
order by titulo asc;

/*
 * 60- Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.
 */

select
	c.first_name as nombre_cliente, 
	c.last_name as apellido_cliente
from customer c
join rental r 
	on c.customer_id = r.customer_id
join inventory i 
	on r.inventory_id = i.inventory_id
group by c.customer_id, c.first_name, c.last_name
having COUNT(distinct i.film_id) >= 7
order by apellido_cliente asc;

/*
 * 61- Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.
 */

select 
	c.name as categoria, 
	COUNT(r.rental_id) as total_alquileres
from category c
join film_category fc 
	on c.category_id = fc.category_id
join inventory i 
	on fc.film_id = i.film_id
join rental r 
	on i.inventory_id = r.inventory_id
group by c.name
order by total_alquileres desc;

/*
 * 62- Encuentra el número de películas por categoría estrenadas en 2006.
 */

select 
	c.name as categoria, 
	COUNT(f.film_id) as total_peliculas
from category c
join film_category fc 
	on c.category_id = fc.category_id
join film f 
	on fc.film_id = f.film_id
where f.release_year = 2006
group by c.name
order by total_peliculas desc;

/*
 * 63- Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.
 */

select 
	s.staff_id, 
	s.first_name as nombre, 
	s.last_name as apellido,
   st.store_id
from staff s
cross join store st;

/*
 * 64- Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.
 */

select c.customer_id,
       c.first_name as nombre_cliente,
       c.last_name as apellido_cliente,
       COUNT(r.rental_id) AS total_peliculas_alquiladas
from customer c
join rental r 
	on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_peliculas_alquiladas desc;