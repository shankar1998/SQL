# total number of trips
select count(distinct tripid) from oladata.trips;

# total drivers
select count(distinct driverid) from oladata.trips;

# total earnings
select sum(fare) from oladata.trips;

# Total completed trips
select count(distinct tripid) from oladata.trips;

# Total searches
select sum(searches) from oladata.trips_details4;

# Total searches got estimate
select sum(searches_got_estimate) from oladata.trips_details4;

# Total searches got quotes
select sum(searches_got_quotes ) from oladata.trips_details4;

# Total drivers cancelled
select count(*) - sum(driver_not_cancelled) from oladata.trips_details4;

# Total OTP entered
select sum(otp_entered ) from oladata.trips_details4;

# Total end ride
select sum(end_ride ) from oladata.trips_details4;

# Average distance per trip
select avg(distance) from oladata.trips;

# Average fare per trip
select avg(fare) from oladata.trips;

#  distance travelled
select sum(distance) from oladata.trips;

# Most used payment method
select a.method from oladata.payment a join
(select faremethod,count(faremethod) from oladata.trips group by faremethod order by 2 desc limit 1) b on a.id=b.faremethod;

# highest payment through which instrument
select a.method from oladata.payment a join 
(select * from oladata.trips order by fare desc limit 1) b on a.id=b.faremethod;

# Which location has most trips

select a.assembly1 from oladata.loc a join 

 (select * from 
 (select *, dense_rank() over(order by cn desc) rnk from 
 (select loc_from,loc_to,count(tripid) cn from oladata.trips group by 1,2 order by 3 desc )a)b where rnk=1)b
on a.id=b.loc_from or a.id=b.loc_to;  

 # Top 5 earning drivers
 select driverid from (select *,dense_rank() over (order by total desc)rnk from(select driverid,sum(fare)total from oladata.trips group by driverid )a)b where rnk<6 ;
 
 # which duration has most trips
 select a.duration from oladata.duration a join
 (select duration from (select *,row_number() over(order by a desc)rnk from (select duration,count(tripid)a from oladata.trips group by duration)d)q where rnk=1) b
 on a.id=b.duration;

# driver,customer pair has more orders
select * from ((select *, rank() over (order by a desc)rnk from(select driverid,custid,count(tripid)a from oladata.trips group by 1,2)b))c where rnk=1 ;

# search estimte rate/quote rates/acceptance rate
select sum(searches_got_estimate)*100/sum(searches) from oladata.trips_details4;
select sum(searches_got_quotes)*100/sum(searches) from oladata.trips_details4;
select sum(end_ride)*100/sum(searches) from oladata.trips_details4;

# which area has highest trips in which duration
select * from(select * ,rank() over (partition by duration order by no_of_trips desc)rnk from 
(select duration,loc_from,count(tripid)no_of_trips from oladata.trips group by 1,2  )a)b where rnk=1;
select * from oladata.trips;