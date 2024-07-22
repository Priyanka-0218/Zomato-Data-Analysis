create database Zomato_Analysis;
use Zomato_Analysis;
select * from zomato1;
select * from country;
select count('RestaurantName') from zomato1;

insert into country values (	30	 ,'	Brazil	 ');
insert into country values (	37	 ,'	Canada	 ');
insert into country values (	94	, '	Indonesia	 ');
insert into country values (	148	 ,'	New Zealand	 ');
insert into country values (	162	 ,'	Philippines	 ');
insert into country values (	166	 ,'	Qatar	 ');
insert into country values (	184	 ,'	Singapore	 ');
insert into country values (	189	 ,'	South Africa	 ');
insert into country values (	191	, '	Sri Lanka	 ');
insert into country values (	208	, '	Turkey	 ');
insert into country values (	214	 ,'	United Arab Emirates	 ');
insert into country values (	215	 ,'	United Kingdom	 ');
insert into country values (	216	, '	United States of America	 ');

#2.
select year(Datekey_Opening) years,
month(Datekey_Opening)  months,
day(datekey_opening) day ,
monthname(Datekey_Opening) monthname,Quarter(Datekey_Opening)as quarter,
concat(year(Datekey_Opening),'-',monthname(Datekey_Opening)) yearmonth, 
weekday(Datekey_Opening) weekday,
dayname(datekey_opening)dayname, 

case when monthname(datekey_opening) in ('January' ,'February' ,'March' )then 'Q1'
when monthname(datekey_opening) in ('April' ,'May' ,'June' )then 'Q2'
when monthname(datekey_opening) in ('July' ,'August' ,'September' )then 'Q3'
else  'Q4' end as quarters,

case when monthname(datekey_opening)='January' then 'FM10' 
when monthname(datekey_opening)='January' then 'FM11'
when monthname(datekey_opening)='February' then 'FM12'
when monthname(datekey_opening)='March' then 'FM1'
when monthname(datekey_opening)='April'then'FM2'
when monthname(datekey_opening)='May' then 'FM3'
when monthname(datekey_opening)='June' then 'FM4'
when monthname(datekey_opening)='July' then 'FM5'
when monthname(datekey_opening)='August' then 'FM6'
when monthname(datekey_opening)='September' then 'FM7'
when monthname(datekey_opening)='October' then 'FM8'
when monthname(datekey_opening)='November' then 'FM9'
when monthname(datekey_opening)='December'then 'FM10'
end Financial_months,
case when monthname(datekey_opening) in ('January' ,'February' ,'March' )then 'Q4'
when monthname(datekey_opening) in ('April' ,'May' ,'June' )then 'Q1'
when monthname(datekey_opening) in ('July' ,'August' ,'September' )then 'Q2'
else  'Q3' end as financial_quarters

from zomato1;


#3.Find the Numbers of Resturants based on City and Country.
select country.countryname,zomato1.city,count(restaurantid)no_of_restaurants
from zomato1 inner join country 
on zomato1.countrycode=country.countryid 
group by country.countryname,zomato1.city;

#4.Numbers of Resturants opening based on Year , Quarter , Month.
select year(datekey_opening)year,quarter(datekey_opening)quarter,monthname(datekey_opening)monthname,count(restaurantid)as no_of_restaurants 
from zomato1 group by year(datekey_opening),quarter(datekey_opening),monthname(datekey_opening) 
order by year(datekey_opening),quarter(datekey_opening),monthname(datekey_opening) ;

#5. Count of Resturants based on Average Ratings.
select case when rating <=2 then "0-2" when rating <=3 then "2-3" when rating <=4 then "3-4" when Rating<=5 then "4-5" end rating_range,count(restaurantid) 
from zomato1 
group by rating_range 
order by rating_range;

#6. Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets
select case when price_range=1 then "0-500" when price_range=2 then "500-3000" when Price_range=3 then "3000-10000" when Price_range=4 then ">10000" end price_range,count(restaurantid)
from zomato1 
group by price_range
order by Price_range;

#7.Percentage of Resturants based on "Has_Table_booking"
SELECT
    Has_Table_booking,
    COUNT(*) AS Num_Restaurants,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM zomato1)) * 100, 2) AS Percentage
FROM
    zomato1
GROUP BY
    Has_Table_booking;


#8.Percentage of Resturants based on "Has_Online_delivery"
SELECT
    Has_Online_delivery,
    COUNT(*) AS Num_Restaurants,
    ROUND((COUNT(*)  / (SELECT COUNT(*) FROM zomato1)) * 100, 2) AS Percentage
FROM
    zomato1
GROUP BY
    Has_Online_delivery;
    
    
#9.Develop Charts based on Cusines, City, Ratings

SELECT
    'Cuisine' AS Category,
    Cuisines AS Label,
    COUNT(*) AS Count
FROM
    zomato1
GROUP BY
    Cuisines

UNION ALL

SELECT
    'City' AS Category,
    City AS Label,
    COUNT(*) AS Count
FROM
    zomato1
GROUP BY
    City

UNION ALL

SELECT
    'Rating' AS Category,
    CAST(Rating AS CHAR) AS Label,
    COUNT(*) AS Count
FROM
    zomato1
GROUP BY
    Rating;


