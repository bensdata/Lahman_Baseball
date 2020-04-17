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