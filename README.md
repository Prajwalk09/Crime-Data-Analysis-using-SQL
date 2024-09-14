# SQL Crime Data Analysis Project

## Project Description

This project involves a comprehensive analysis of crime data from various states over a span of 20 years. The goal is to gain insights into crime trends, compare crime statistics across different regions, and identify key patterns and anomalies in the data. Using SQL, this project addresses a series of queries to analyze total crime counts, year-over-year changes, state-specific trends, and more.

## Dataset

The dataset used in this project is titled "Crimes Against Women in India: A 20-Year Analysis" and is available on [Kaggle](https://www.kaggle.com/datasets/harigoshika/crimes-against-women-in-india-a-20-year-analysis/data). 

### Attributes:

- **`STATE`**: Name of the state or union territory.
- **`YEAR`**: The year for which the crime data is reported.
- **`RAPE`**: Number of reported rape cases.
- **`KIDNAP_ASSAULT`**: Number of reported kidnapping and assault cases.
- **`DOWRY_DEATHS`**: Number of reported dowry deaths.
- **`ASSAULT_AGAINST_WOMEN`**: Number of reported assaults against women.
- **`ASSAULT_AGAINST_MODESTY_OF_WOMEN`**: Number of reported assaults against the modesty of women.
- **`DOMESTIC_VIOLENCE`**: Number of reported domestic violence cases.
- **`WOMEN_TRAFFICKING`**: Number of reported women trafficking cases.

## Project Objective

The objective of this project is to perform an in-depth analysis of crime data across various states and years to uncover significant patterns and trends. Specifically, the project aims to:

1. **Analyze Crime Totals by Type**:
   - Calculate the total number of reported cases for each type of crime across all states, providing a comprehensive overview of crime distribution.

2. **Identify High Crime States**:
   - List states where the cumulative number of reported crimes exceeded 10,000 in any given year to identify regions with exceptionally high crime rates.

3. **Yearly Crime Trends**:
   - Determine the total number of crimes reported each year across all states to understand annual crime trends and fluctuations.

4. **Delhi Crime Statistics**:
   - Compute the total number of reported crimes in Delhi over the 20-year period to assess crime trends specific to this major city.

5. **Lowest Crime States in 2020**:
   - Identify the top 5 states with the lowest number of reported crimes in the year 2020 to highlight regions with minimal crime reports.

6. **Year-over-Year Crime Comparison**:
   - Calculate the difference in the total number of reported crimes between the years 2019 and 2020 to assess how crime rates have changed between these two years.

7. **Top 5 States by Year**:
   - Identify the top 5 states with the highest total number of reported crimes for each year, providing insights into annual crime hotspots.

8. **Consistent Top-Ranking States**:
   - Find states that have consistently ranked in the top 5 for the highest number of reported crimes over the years to identify persistent high-crime regions.

9. **Northern vs. Southern Crime Comparison**:
   - Compare the total number of reported crimes between Northern and Southern states for each year to explore regional crime disparities.

10. **Crime Leaders by Type in 2020**:
    - Determine which state reported the highest number of cases for each type of crime in 2020 to pinpoint the most affected regions for specific crimes.

11. **Population-Based Crime Trends**:
    - Analyze crime trends in states with the highest populations compared to states with the lowest populations to understand the relationship between population size and crime rates.




## Files and Directory

- **`SQL_Files/`**: Contains SQL scripts addressing each of the queries mentioned above.


## Acknowledgements

- Dataset: [Crimes Against Women in India: A 20-Year Analysis](https://www.kaggle.com/datasets/harigoshika/crimes-against-women-in-india-a-20-year-analysis/data)

For more details, please refer to the SQL files in the `SQL_Files` directory.
