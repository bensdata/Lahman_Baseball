-- Question 6: Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful. 
--(A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted at least 20 stolen bases.
-- 

Select namelast, namefirst, sb, cs, (sb::numeric+cs::numeric) as total_attempts, cast(sb::numeric/(sb::numeric+cs::numeric) as decimal(5,4)) as percent_stolen
FROM batting inner join people on batting.playerid = people.playerid 
where cs >0
and (sb::numeric+cs::numeric) >= 20
order by percent_stolen desc

