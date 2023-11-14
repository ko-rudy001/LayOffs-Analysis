select * FROM [Layoffs].[dbo].[layoffs];

select count(company) FROM [Layoffs].[dbo].[layoffs];

select count(company) FROM [Layoffs].[dbo].[layoffs]
where total_laid_off is NULL;

/*Top 5 companies with maximum layoffs...*/
select top (5) company, max(total_laid_off) as MaxLayoffs
FROM [Layoffs].[dbo].[layoffs]
group by company
order by MaxLayoffs desc;


/*Bottom 5 companies with maximum layoffs...*/
select top(5) company, max(total_laid_off) as MinLayoffs
FROM [Layoffs].[dbo].[layoffs]
where total_laid_off is not null
group by company
order by MinLayoffs;


/* stage contain 1 null value, Layoff by stage...*/
select stage, (sum(total_laid_off) * 100.0 / (select sum(total_laid_off) FROM [Layoffs].[dbo].[layoffs])) as Percentage_LayOff_Per_Stage
FROM [Layoffs].[dbo].[layoffs]
where stage is not null 
group by stage
order by Percentage_LayOff_Per_Stage desc;


/*Top 5 countries with maximu Layoff ...*/
select top(5) country, (sum(total_laid_off) * 100.0 / (select sum(total_laid_off) FROM [Layoffs].[dbo].[layoffs])) as Percentage_Layoff_Per_Country 
FROM [Layoffs].[dbo].[layoffs]
group by country
order by Percentage_Layoff_Per_Country desc;


/*Layoff by industry...*/
select industry, sum(total_laid_off) as Total_LayOffs
FROM [Layoffs].[dbo].[layoffs]
where industry is not null 
group by industry
order by Total_LayOffs desc;



select * FROM [Layoffs].[dbo].[layoffs]

/*Layoff by year...*/
select YEAR(date) as Year, sum(total_laid_off) as Total_Layoff
FROM [Layoffs].[dbo].[layoffs]
group by Year(date)
order by Total_Layoff desc

/*Layoff by year and quarter...*/
select YEAR(date) as Year, DATEPART(QUARTER, date) as Quarter, sum(total_laid_off) as Total_Layoffs 
FROM [Layoffs].[dbo].[layoffs]
group by
	Year(date), DATEPART(QUARTER, date)
order by Total_Layoffs desc


/*Layoff by year and country...*/
select Year(date) as Year, country, sum(total_laid_off) as Total_Layoff
FROM [Layoffs].[dbo].[layoffs]
where total_laid_off is not null
group by Year(date), country
order by Total_Layoff desc



/* Total Fund Raised as per industry and stage...*/
select industry, stage, sum(funds_raised) as Total_FundRaised
FROM [Layoffs].[dbo].[layoffs]
where funds_raised is not null
group by industry, stage
order by Total_FundRaised desc