-- SQL CODE of chapter 6
select category,count(*) from posts group by category order by category;
select category, count(*) over (partition by category) from posts order by category;
select category, count(*) over (partition by category),count(*) over () from posts order by category; 
select distinct category, count(*) over (partition by category),count(*) over () from posts order by category;
select distinct category, count(*) over w1 ,count(*) over W2 from posts WINDOW w1 as (partition by category),W2 as () order by category;
select generate_series(1,5);
select category, row_number() over w from posts WINDOW w as (partition by category) order by category;
select category,row_number() over w,title from posts WINDOW w as (partition by category order by title) order by category;
select category,row_number() over w,title,first_value(title) over w from posts WINDOW w as (partition by category order by category) order by category;
select category,row_number() over w,title,last_value(title) over w from posts WINDOW w as (partition by category order by category) order by category;
select pk,title,author,rank() over () from posts ;
select pk,title,author,rank() over (order by author) from posts ;
select pk,title,author,rank() over (partition by author order by author) from posts ;
select pk,title,author,dense_rank() over (order by author) from posts order by category;
select x from (select generate_series(1,5) as x) V ;
select x,lag(x) over w from (select generate_series(1,5) as x) V WINDOW w as (order by x) ;
select x,lag(x,2) over w from (select generate_series(1,5) as x) V WINDOW w as (order by x) ;
select x,lead(x) over w from (select generate_series(1,5) as x) V WINDOW w as (order by x) ;
select x,lead(x,2) over w from (select generate_series(1,5) as x) V WINDOW w as (order by x) ;
select x,cume_dist() over w from (select generate_series(1,5) as x) V WINDOW w as (order by x) ;
select x,ntile(2) over w from (select generate_series(1,6) as x) V WINDOW w as (order by x) ;
select x,ntile(3) over w from (select generate_series(1,6) as x) V WINDOW w as (order by x) ;
select distinct category, count(*) over (partition by category) from posts order by category;
select distinct category, count(*) over w1 from posts WINDOW w1 as (partition by category RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) order by category;
select x from (select generate_series(1,5) as x) V WINDOW w as (order by x) ;
SELECT x, SUM(x) OVER w FROM (select generate_series(1,5) as x) V WINDOW w AS (ORDER BY x ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW);
SELECT x, SUM(x) OVER w FROM (select generate_series(1,5) as x) V WINDOW w AS (ORDER BY x RANGE BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT x, SUM(x) OVER w FROM (select generate_series(1,5) as x) V WINDOW w AS (ORDER by x ROWS UNBOUNDED PRECEDING);
SELECT x, SUM(x) OVER w FROM (select generate_series(1,5) as x) V WINDOW w AS (ORDER BY X ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
select generate_series(1,8) % 4 as x order by 1;
SELECT x, row_number() OVER w, SUM(x) OVER w FROM (select generate_series(1,8) % 4 as x) V WINDOW w AS (ORDER BY x ROWS BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT x, row_number() OVER w, SUM(x) OVER w FROM (select generate_series(1,8) % 4 as x) V WINDOW w AS (ORDER BY x RANGE BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT x,row_number() OVER w, dense_rank() OVER w,sum(x) OVER w FROM (select generate_series(1,8) % 4 as x) V WINDOW w AS (ORDER BY x desc RANGE BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT x,row_number() OVER w, dense_rank() OVER w,sum(x) OVER w FROM (select generate_series(1,8) % 4 as x) V WINDOW w AS (ORDER BY x desc ROWS BETWEEN 1 PRECEDING AND CURRENT ROW);


