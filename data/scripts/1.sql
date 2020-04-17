--Q1: What range of years does the provided database cover?

--select min(birthyear), max(birthyear),min(deathyear),max(deathyear)
--from people
-- 1820-2017

--select min(year), max(year)
--from homegames
-- 1871-2016

--Q2: Find the name and height of the shortest player in the database. 
-- SELECT Concat(namefirst,' ', namelast) as fullname, MIN(height) as shortest_player
-- FROM people
-- GROUP BY fullname
-- ORDER BY shortest_player desc
-- Limit 1

--How many games did he play in? 
--What is the name of the team for which he played?

-- Cat's Code:
-- SELECT teamid, g_all, namefirst, namelast, MIN(height) as shortest_player
-- FROM people
-- LEFT JOIN appearances on appearances.playerid = people.playerid
-- GROUP BY teamid, g_all, namefirst, namelast
-- ORDER BY shortest_player
-- LIMIT 1;


-- Question 6
-- 

-- Select namelast, namefirst, sb, cs, (sb::numeric+cs::numeric) as total_attempts, cast(sb::numeric/(sb::numeric+cs::numeric) as decimal(5,4)) as percent_stolen
-- FROM batting inner join people on batting.playerid = people.playerid 
-- where cs >0
-- and (sb::numeric+cs::numeric) >= 20
-- order by percent_stolen desc


-- Question 7
-- 7a: what is the largest number of wins for a team that did not win the world series?
-- Answer: 116

-- SELECT teamid, yearid, w, wswin
-- FROM teams
-- WHERE wswin = 'N'
-- ORDER BY w desc

-- 7b: What is the smallest number of wins for a team that did win the world series?

-- SELECT teamid, yearid, w, wswin
-- FROM teams
-- WHERE wswin = 'Y'
-- ORDER BY w asc
-- Answer: 63 (1981 players strike, less games in the year)

--7c: Doing this(7b) will probably result in an unusually small number of wins for a world series champion – determine why this is the case. 
--	  Then redo your query, excluding the problem year.

-- SELECT distinct teamid, w,
-- 		max(w) OVER (PARTITION BY yearid) as max_wins,
-- 		wswin, yearid		
-- FROM teams 
-- where yearid >= '1970' and yearid <= '2016' and yearid <>'1981'
-- Order BY wswin desc, w asc

--1981 was a players strike
--Answer: 83, team: SLN 2006

-- 7d: How often from 1970 – 2016 was it the case that a team with the most wins also won the world series?

-- WITH ws_winners as (SELECT teamid, yearid
-- 				   FROM teams where wswin = 'Y')
-- SELECT ws_winners.teamid, ws_winners.yearid,
-- 		max(w) OVER (PARTITION BY teams.yearid)=w as wswinns_equal_maxwins,
-- 		w, wswin 		
-- FROM teams inner join ws_winners on teams.yearid = ws_winners.yearid
-- where ws_winners.yearid >= '1970' and ws_winners.yearid <= '2016' and ws_winners.yearid <>'1981' and ws_winners.yearid <>1994
-- Order BY wswin desc, wswinns_equal_maxwins desc --yearid, w desc
-- limit 45

--7e: What percentage of the time?
-- 12/45 = 26.6%