--Q1: What range of years does the provided database cover?

select min(birthyear), max(birthyear),min(deathyear),max(deathyear)
from people
--1820-2017

-- select min(year), max(year)
-- from homegames
-- 1871-2016