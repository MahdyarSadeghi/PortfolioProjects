-- Looking at total Cases, Deaths and fuuly-Vaccinated and boosted given people for each country
with total_data_table as
(Select c.location, MAX(v.population) as population,
	SUM(new_cases) as cases,
	SUM(cast(new_deaths as numeric)) as deaths,
	MAX(cast(people_fully_vaccinated as numeric)) as fully_vaccinations,
	MAX(cast(total_boosters as numeric)) as booster_given
From dbo.CovidDeaths c
Join dbo.CovidVaccinations v
On (c.date = v.date) and (c.location = v.location)
Where c.continent is not null
	and v.continent is not null
Group By c.location)

Select location, population, cases, deaths, fully_vaccinations, booster_given,
	cases/population as case_percent,
	deaths/population as deaths_percent,
	fully_vaccinations/population as vaccination_percent,
	booster_given/population as booster_percent
From total_data_table

-- Creating Total-Data view for later visualization
Create View total_data as

with total_data_table as
(Select c.location, MAX(v.population) as population,
	SUM(new_cases) as cases,
	SUM(cast(new_deaths as numeric)) as deaths,
	MAX(cast(people_fully_vaccinated as numeric)) as fully_vaccinations,
	MAX(cast(total_boosters as numeric)) as booster_given
From dbo.CovidDeaths c
Join dbo.CovidVaccinations v
On (c.date = v.date) and (c.location = v.location)
Where c.continent is not null
	and v.continent is not null
Group By c.location)

Select location, population, cases, deaths, fully_vaccinations, booster_given,
	cases/population as case_percent,
	deaths/population as deaths_percent,
	fully_vaccinations/population as vaccination_percent,
	booster_given/population as booster_percent
From total_data_table
