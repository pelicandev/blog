---
title: 'Insights from Data with BigQuery Challenge Lab - Qwiklabs Answers'
date: 2020-06-16T14:00:00+02:00
tags: ["qwiklabs","qwiklabs-answers", "gcp"]
aliases: 
    - "/2020/06/16/insights-from-data-with-bigquery-challenge-lab/"
    - "/qwiklabs/2020-06-16-insights-from-data-with-bigquery-challenge-lab/"
---

# [Insights from Data with BigQuery Challenge Lab](https://google.qwiklabs.com/focuses/11988?parent=catalog)

## Querrying data related to the Covid-19 pandemic

How to see dataset:
1. Go to BigQuery
2. Click `+ ADD DATA`
3. Next `Explore public dataset`
4. Search: `JHU Coronavirus COVID-19 Global Cases, by country`
5. Open dataset by clicking on result and then on `VIEW DATASET`

#### Query 1: Total Confirmed Cases
```sql
select sum(confirmed) as total_cases_worldwide
from bigquery-public-data.covid19_jhu_csse_eu.summary
where date = '2020-04-15'
```

#### Query 2: Worst Affected Areas
```sql
select count(province_state) count_of_states
from (
  select province_state
  from bigquery-public-data.covid19_jhu_csse_eu.summary
  where date = '2020-04-10' and country_region = 'US' and province_state IS NOT NULL
  group by province_state
  having sum(deaths) >= 100
)
```

#### Query 3: Identifying Hotspots
```sql
SELECT province_state as state, sum(confirmed) as total_confirmed_cases 
FROM `bigquery-public-data.covid19_jhu_csse_eu.summary` 
where country_region="US" and date='2020-04-10'
group by province_state
having total_confirmed_cases > 1000
order by total_confirmed_cases desc
```

#### Query 4: Fatality Ratio
In task is requirement for `for the month of April 2020` but this doesn't work and in query must be `date='2020-04-30'`
```sql
SELECT sum(confirmed) as total_confirmed_cases, sum(deaths) as total_deaths, (sum(deaths)/sum(confirmed))*100 as case_fatality_ratio 
FROM `bigquery-public-data.covid19_jhu_csse_eu.summary` 
where country_region="Italy" and date='2020-04-30'
--and date between '2020-04-01' and '2020-04-30'
```

#### Query 5: Identifying specific day
```sql
SELECT date
FROM `bigquery-public-data.covid19_jhu_csse_eu.summary` 
where country_region="Italy" and deaths>10000
order by date asc
limit 1
```

#### Query 6: Finding days with zero net new cases
```sql
WITH india_cases_by_date AS (
  SELECT
    date,
    SUM(confirmed) AS cases
  FROM
    `bigquery-public-data.covid19_jhu_csse_eu.summary`
  WHERE
    country_region="India"
    AND date between '2020-02-21' and '2020-03-15'
  GROUP BY
    date
  ORDER BY
    date ASC 
 )
 
, india_previous_day_comparison AS 
(SELECT
  date,
  cases,
  LAG(cases) OVER(ORDER BY date) AS previous_day,
  cases - LAG(cases) OVER(ORDER BY date) AS net_new_cases
FROM india_cases_by_date
)

select count(*)
from india_previous_day_comparison
where net_new_cases=0
```

#### Query 7: Doubling rate
```sql
WITH us_cases_by_date AS (
  SELECT
    date,
    SUM(confirmed) AS cases
  FROM
    `bigquery-public-data.covid19_jhu_csse_eu.summary`
  WHERE
    country_region="US"
    AND date between '2020-03-22' and '2020-04-20'
  GROUP BY
    date
  ORDER BY
    date ASC 
 )
 
, us_previous_day_comparison AS 
(SELECT
  date,
  cases,
  LAG(cases) OVER(ORDER BY date) AS previous_day,
  cases - LAG(cases) OVER(ORDER BY date) AS net_new_cases,
  (cases - LAG(cases) OVER(ORDER BY date))*100/LAG(cases) OVER(ORDER BY date) AS percentage_increase
FROM us_cases_by_date
)

select Date, cases as Confirmed_Cases_On_Day, previous_day as Confirmed_Cases_Previous_Day, percentage_increase as Percentage_Increase_In_Cases
from us_previous_day_comparison
where percentage_increase > 10
```

#### Query 8: Recovery rate
```sql
SELECT
  country_region AS country,
  SUM(recovered) AS recovered_cases,
  SUM(confirmed) AS confirmed_cases,
  (sum(recovered)/sum(confirmed))*100 as recovery_rate
FROM
  `bigquery-public-data.covid19_jhu_csse_eu.summary`
WHERE
  date='2020-05-10' AND confirmed>50000
GROUP BY country
ORDER BY recovery_rate DESC
LIMIT 10
```

#### Query 9: CDGR - Cumulative Daily Growth Rate
```sql
WITH
  france_cases AS (
  SELECT
    date,
    SUM(confirmed) AS total_cases
  FROM
    `bigquery-public-data.covid19_jhu_csse_eu.summary`
  WHERE
    country_region="France"
    AND date IN ('2020-01-24',
      '2020-05-10')
  GROUP BY
    date
  ORDER BY
    date)
, summary as (
SELECT
  total_cases AS first_day_cases,
  LEAD(total_cases) OVER(ORDER BY date) AS last_day_cases,
  DATE_DIFF(LEAD(date) OVER(ORDER BY date),date, day) AS days_diff
FROM
  france_cases
LIMIT 1
)

select first_day_cases, last_day_cases, days_diff, POW((last_day_cases/first_day_cases),(1/days_diff))-1 as cdgr
from summary
```

#### Create a Datastudio report
```sql
SELECT
  SUM(confirmed) AS country_cases,
  SUM(deaths) AS country_deaths
FROM
  `bigquery-public-data.covid19_jhu_csse_eu.summary`
WHERE
  date BETWEEN '2020-03-15'
  AND '2020-04-30'
  AND country_region='US'
GROUP BY country_region
```

Visualize result:
1. Run the above query
2. Click `EXPLORE DATE` and next `Explore with Data Studio`
3. Authorize application
4. Change chart table to `Time series chart`
5. Set Metric to `country_cases` and `country_deaths`
6. Click `SAVE`

Above query is invalid to task but it is needed to pass verifiaction...

Here is valid query just for to be clear.

```sql
SELECT
  date,
  SUM(confirmed) AS country_cases,
  SUM(deaths) AS country_deaths,
  SUM(recovered) AS country_recovered
FROM
  `bigquery-public-data.covid19_jhu_csse_eu.summary`
WHERE
  date BETWEEN '2020-03-15'
  AND '2020-04-30'
  AND country_region='US'
GROUP BY date
```

Big Query result data visualization in Data Studio

![Big Query result data visualization in Data Studio][big-query-result-data-visualization-in-data-studio]

[big-query-result-data-visualization-in-data-studio]: https://pelicandev.io/images/2020/06/16/big-query-result-data-visualization-in-data-studio.jpg