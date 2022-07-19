
Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From covid_deaths
where continent is not null
order by 1,2;

Select location, SUM(new_deaths) as TotalDeathCount
From covid_deaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc;


Select Location, Population,e_date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid_deaths
Group by Location, Population,e_date
order by PercentPopulationInfected desc;

desc total_cases

Select dea.continent, dea.location, dea.e_date, dea.population
, MAX(vac.total_vaccinations) as RollingPeopleVaccinated
From covid_deaths dea
Join covid_vaccinations vac
	On dea.location = vac.location
	and dea.E_date = vac.E_date
where dea.continent is not null 
group by dea.continent, dea.location, dea.E_date, dea.population
order by 1,2,3;




-- 
Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From covid_deaths
where continent is not null 
order by 1,2;


-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International"  Location

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(new_deaths) as TotalDeathCount
From covid_deaths
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc;



-- 

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid_deaths
Group by Location, Population
order by PercentPopulationInfected desc;



-- took the above query and added population
Select Location, e_date, population, total_cases, total_deaths
From Covid_Deaths
where continent is not null 
order by 1,2;


--  


With PopvsVac (Continent, Location, e_Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.e_date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.e_Date) as RollingPeopleVaccinated
From Covid_Deaths dea
Join Covid_Vaccinations vac
	On dea.location = vac.location
	and dea.e_date = vac.e_date
where dea.continent is not null 
)
Select PopvsVac.*, (RollingPeopleVaccinated/Population)*100 as PercentPeopleVaccinated
From PopvsVac;


-- 

Select Location, Population,e_date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid_deaths
Group by Location, Population, e_date
order by PercentPopulationInfected desc;

--Import Excel files in sql developer and then connect the db to tableau
--join the tables and build relationships
--filter continent where it's null and remove World', 'European Union', 'International' from location
--change location DT to geo

--Create calculated fields
/* 
1. Death %--> SUM([New Deaths])/SUM([New Cases])*100.....format will be custom and suffix would be %
2. PercentPopulationInfected--> MAX([Total Cases])/MAX([Population])*100    
*/
