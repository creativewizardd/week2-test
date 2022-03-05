with tbl1 as(
	select *, (fiscal_year % 10000) as year from dividend
), 

tbl2 as(
	select 
		company,
		year, 
		lead( year,1) over( partition by company order by year) first_year,
		lead( year,2) over( partition by company order by year) second_year               
	from tbl1
),

tbl3 as(
	select 
		company 
	from tbl2
		where year = first_year - 1 and year= second_year - 2 
	order by company
)
SELECT JSONB_AGG(DISTINCT company) FROM tbl3

