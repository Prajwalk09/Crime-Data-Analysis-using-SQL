/*
Which states have consistently ranked in the top 5 for the highest number of crimes reported over the years?
Identify the crime type that saw the largest drop in occurrences from one year to the next.
Compare the total number of crimes between Northern and Southern states for each year.
For each type of crime, find which state reported the highest number of cases in 2020.
What is the trend in the number of crimes in states with the highest populations versus states with the lowest populations?
*/

-- 7. TOP 5 STATES (YEAR WISE) BASED ON TOTAL CRIMES
WITH YEAR_WISE_CRIMES AS (
	SELECT 
		STATE, 
		YEAR, 
		SUM(RAPE) + SUM(KIDNAP_ASSAULT) + SUM(DOWRY_DEATHS) + SUM(ASSAULT_AGAINST_WOMEN) +
		SUM(ASSAULT_AGAINST_MODESTY_OF_WOMEN) + SUM(DOMESTIC_VIOLENCE) + SUM(WOMEN_TRAFFICKING) AS TOTAL_CRIMES
	FROM CRIME_DETAILS
	GROUP BY 1,2
)
SELECT *
FROM (
	SELECT *, 
		DENSE_RANK() OVER(PARTITION BY YEAR ORDER BY TOTAL_CRIMES DESC) AS CRIME_RANKINGS
	FROM YEAR_WISE_CRIMES) AS SUBQUERY
WHERE CRIME_RANKINGS BETWEEN 1 AND 5;


-- 8. States that have consistently ranked in the top 5 for the highest number of crimes reported over the years
WITH YEAR_WISE_CRIMES AS (
	SELECT 
		STATE, 
		YEAR, 
		SUM(RAPE) + SUM(KIDNAP_ASSAULT) + SUM(DOWRY_DEATHS) + SUM(ASSAULT_AGAINST_WOMEN) +
		SUM(ASSAULT_AGAINST_MODESTY_OF_WOMEN) + SUM(DOMESTIC_VIOLENCE) + SUM(WOMEN_TRAFFICKING) AS TOTAL_CRIMES
	FROM CRIME_DETAILS
	GROUP BY 1,2
)
SELECT STATE, 
	   COUNT(*) AS TOP_5_APPEARENCE_COUNT
FROM (
	SELECT *, 
			DENSE_RANK() OVER(PARTITION BY YEAR ORDER BY TOTAL_CRIMES DESC) AS CRIME_RANKINGS
	FROM YEAR_WISE_CRIMES
) AS SUBQUERY
WHERE CRIME_RANKINGS BETWEEN 1 AND 5
GROUP BY 1;


-- 9. Compare the total number of crimes between Northern and Southern states for each year.
SELECT 
	COUNT(DISTINCT STATE)
FROM CRIME_DETAILS;


SELECT 
	CASE 
		WHEN STATE IN ('Delhi UT','Haryana','Himachal Pradesh', 'Jammu & Kashmir' , 'West Bengal',
							'Punjab', 'Rajasthan', 'Uttar Pradesh' , 'Uttarakhand' , 'Jharkhand') THEN "Northern"
		WHEN STATE IN ('Andhra Pradesh' , 'Goa' , 'Karnataka', 'Kerala',
						'Tamil Nadu' , 'Telangana' , 'Puducherry' , 'Lakshadweep') THEN 'Southern'
		WHEN STATE IN ('Arunachal Pradesh', 'Assam', 'Manipur', 
						'Meghalaya', 'Mizoram', 'Nagaland', 'Sikkim', 'Tripura') THEN 'Northeastern'
		WHEN STATE IN ('Bihar', 'Chhattisgarh', 'Gujarat', 
						'Madhya Pradesh', 'Maharashtra', 'Odisha') THEN 'Central'
		WHEN STATE IN ('A & N Islands', 'Chandigarh', 'Daman & Diu', 
						'Lakshadweep', 'Puducherry', 'Delhi UT') OR STATE LIKE'%Haveli%' THEN 'Union Territories'
		END AS STATE_CATEGORY,
	SUM(RAPE) + SUM(KIDNAP_ASSAULT) + SUM(DOWRY_DEATHS) + SUM(ASSAULT_AGAINST_WOMEN) +
	SUM(ASSAULT_AGAINST_MODESTY_OF_WOMEN) + SUM(DOMESTIC_VIOLENCE) + SUM(WOMEN_TRAFFICKING) AS TOTAL_CRIMES
FROM CRIME_DETAILS
GROUP BY 1
ORDER BY 2;


-- 10. For each type of crime, find which state reported the highest number of cases in 2020.
SELECT *
FROM CRIME_DETAILS;

WITH CRIME_TOTALS AS (
	SELECT 
		STATE, 
        SUM(RAPE) AS TOTAL_RAPE, 
        SUM(KIDNAP_ASSAULT) AS TOTAL_KIDNAP_ASSAULT,
        SUM(DOWRY_DEATHS) AS TOTAL_DOWRY_DEATHS, 
        SUM(ASSAULT_AGAINST_WOMEN) AS TOTAL_ASSAULT_AGAINST_WOMEN, 
        SUM(ASSAULT_AGAINST_MODESTY_OF_WOMEN) AS TOTAL_ASSAULT_AGAINST_MODESTY_OF_WOMEN,
        SUM(DOMESTIC_VIOLENCE) AS TOTAL_DOMESTIC_VIOLENCE, 
        SUM(WOMEN_TRAFFICKING) AS TOTAL_WOMEN_TRAFFICKING
	FROM CRIME_DETAILS
    WHERE YEAR = 2020
    GROUP BY STATE
),
MAX_CRIMES AS (
	SELECT 
		'Rape' as CRIME_TYPE, 
		MAX(TOTAL_RAPE) AS MAX_CASES
	FROM CRIME_TOTALS
    
    UNION ALL 
    SELECT 
		'Kidnap Assault', 
		MAX(TOTAL_KIDNAP_ASSAULT) 
	FROM CRIME_TOTALS
    
    UNION ALL
    SELECT 
		'Dowry Deaths', 
		MAX(TOTAL_DOWRY_DEATHS) 
	FROM CRIME_TOTALS
    
    UNION ALL 
    SELECT 
		'Assault Against Women', 
		MAX(TOTAL_ASSAULT_AGAINST_WOMEN) 
	FROM CRIME_TOTALS
    
    UNION ALL
    SELECT 
		'Assault Against Modesty of Women', 
        MAX(TOTAL_ASSAULT_AGAINST_MODESTY_OF_WOMEN) 
	FROM CRIME_TOTALS
    
    UNION ALL
    SELECT 
		'Domestic Violence', 
		MAX(TOTAL_DOMESTIC_VIOLENCE)
	FROM CRIME_TOTALS
    
    UNION ALL
    SELECT 
		'Women Trafficking', 
		MAX(TOTAL_WOMEN_TRAFFICKING)
	FROM CRIME_TOTALS
)
, 

MAX_CRIME_STATES AS (
	SELECT
		m.CRIME_TYPE, 
        c.STATE AS STATE_WITH_MAX_CRIME,
        CASE 
			WHEN M.CRIME_TYPE = 'Rape' THEN C.TOTAL_RAPE
            WHEN M.CRIME_TYPE = 'Kidnap Assault' THEN C.TOTAL_KIDNAP_ASSAULT
            WHEN M.CRIME_TYPE = 'Dowry Deaths' THEN C.TOTAL_DOWRY_DEATHS
            WHEN M.CRIME_TYPE = 'Assault Against Women' THEN C.TOTAL_ASSAULT_AGAINST_WOMEN
            WHEN M.CRIME_TYPE = 'Assault Against Modesty of Women' THEN C.TOTAL_ASSAULT_AGAINST_MODESTY_OF_WOMEN
            WHEN M.CRIME_TYPE = 'Domestic Violence' THEN C.TOTAL_DOMESTIC_VIOLENCE
            WHEN M.CRIME_TYPE = 'Women Trafficking' THEN C.TOTAL_WOMEN_TRAFFICKING
		END AS MAX_CASES 
	FROM MAX_CRIMES AS M 
	JOIN CRIME_TOTALS AS C ON (M.CRIME_TYPE = 'Rape' and C.TOTAL_RAPE = M.MAX_CASES) OR 
								(M.CRIME_TYPE = 'Kidnap Assault' and C.TOTAL_KIDNAP_ASSAULT = M.MAX_CASES) OR 
                                (M.CRIME_TYPE = 'Dowry Deaths' and C.TOTAL_DOWRY_DEATHS = M.MAX_CASES) OR 
                                (M.CRIME_TYPE = 'Assault Against Women' and C.TOTAL_ASSAULT_AGAINST_WOMEN = M.MAX_CASES) OR 
                                (M.CRIME_TYPE = 'Assault Against Modesty of Women' and C.TOTAL_ASSAULT_AGAINST_MODESTY_OF_WOMEN = M.MAX_CASES) OR 
                                (M.CRIME_TYPE = 'Domestic Violence' and C.TOTAL_DOMESTIC_VIOLENCE = M.MAX_CASES) OR 
                                (M.CRIME_TYPE = 'Women Trafficking' and C.TOTAL_WOMEN_TRAFFICKING = M.MAX_CASES)
)
SELECT
	CRIME_TYPE,
    STATE_WITH_MAX_CRIME, 
    MAX_CASES
FROM MAX_CRIME_STATES
ORDER BY 3 DESC;



-- 11. What is the trend in the number of crimes in states with the highest populations versus states with the lowest populations?
WITH CRIME_RATE_BY_POPULATION AS (
	SELECT 
		STATE, 
		CASE 
			-- States with a population of 30 Million or above are categorized as highly populated states (17 States)
			WHEN STATE IN ('Uttar Pradesh', 'Maharashtra', 'Bihar', 'West Bengal', 
							'Madhya Pradesh', 'Tamil Nadu', 'Rajasthan', 'Karnataka', 
							'Gujarat', 'Andhra Pradesh', 'Odisha', 'Telangana', 'Assam', 
							'Punjab', 'Jharkhand', 'Kerala', 'Haryana') THEN 'High Population' 
			-- Other states are categorized as low populated states (19 States)
			ELSE 'Low Population'
			END AS Population_Category,
		SUM(RAPE) + SUM(KIDNAP_ASSAULT) + SUM(DOWRY_DEATHS) + SUM(ASSAULT_AGAINST_WOMEN) +
		SUM(ASSAULT_AGAINST_MODESTY_OF_WOMEN) + SUM(DOMESTIC_VIOLENCE) + SUM(WOMEN_TRAFFICKING) AS TOTAL_CRIMES
	FROM crime_details
	GROUP BY 1,2
)
SELECT 
	POPULATION_CATEGORY, 
    SUM(TOTAL_CRIMES) AS TOTAL_CRIMES
FROM CRIME_RATE_BY_POPULATION
GROUP BY 1
ORDER BY 2;