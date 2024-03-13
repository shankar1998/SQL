# Questions
# matches in season
select substring(date,7,10)year,count(distinct id) number_of_matches from ipl.ipl group by 1;

# most player of match
select count(player_of_match)mom ,player_of_match from ipl.ipl group by 2 order by 1 desc;

# most player of match in one season
select * from (select yr,mom,player_of_match,rank() over (partition by yr order by mom desc)rk from 
(select substring(date,7,10)yr,count(player_of_match)mom ,player_of_match from ipl.ipl group by 3,1 order by 2 desc)a)b where rk=1 ;

# most wins by any team
select winner, count(winner) win from ipl.ipl group by 1 order by 2 desc limit 1;

# Top 5 venues where matches are playes
select venue,count(venue) from ipl.ipl group by 1 order by 2 desc limit 5;

#  Most runs by any batsman
select batsman,sum(batsman_runs) from ipl.ipls group by batsman order by 2 desc limit 1;

# persentage of runs scored by each batsman
 select ( select sum(batsman_runs) from ipl.ipls group by batsman)a  , (select sum(batsman_runs)over( from ipl.ipls group by b)b  ;

# most sixes by any batsman
select batsman, count(batsman_runs)sixes from ipl.ipls WHERE batsman_runs=6 group by batsman order by 2 desc  ;

# most fours by any batsman
select batsman, count(batsman_runs)sixes from ipl.ipls WHERE batsman_runs=4  group by batsman order by 2 desc  ;

# more than 3k runs with highest strike rate
select batsman,a,(a/b)*100 from 
(select batsman,sum(batsman_runs)a,count(ball)b from ipl.ipls  group by batsman having sum(batsman_runs)> 3000)d order by 3 desc ;

# bowler with less economy rate bowled at least 50 overs
select bowler, (runs/balls)*100 from
(select bowler,count(bowler)balls,sum(total_runs)runs from ipl.ipls group by bowler having count(bowler)>300)a order by 2 ;

# matches played till 2020
 select count(id) from ipl.ipl where substring(date,7,10)<2020;
 
# Total number of matchs win by each team
select winner,count(winner) from ipl.ipl group by winner;

select * from ipl.ipl
