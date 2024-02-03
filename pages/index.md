---
title: Strava Data
---

```sql activities_by_month
select
  date_trunc('month', date_dt) as month,
  count(*) as number_of_activities,
  sum(activity_hours) as activity_hours,
  sum(activity_distance / 1000) as distance_km 
from activities
where date_dt >= '2022-01-01'
group by 1 order by 1 desc
```
## Activity by Month

<LineChart 
    data={activities_by_month} 
    x=month
    y=activity_hours 
    y2=distance_km
    y2SeriesType=bar
/>

```sql activities_by_sport_month
select
  date_trunc('month', date_dt) as month,
  modified_sport as sport,
  count(*) as number_of_activities,
  sum(activity_hours) as activity_hours
from activities
where date_dt >= '2022-01-01'
group by 1,2 order by 1 desc, 2
```

## Sport Stats by Month
<BarChart 
    data={activities_by_sport_month} 
    x=month
    series=sport
    y=activity_hours 
/>

## 100km Challenge
In February, we want to run 100 km. Create a visualization for this here:

```sql running_by_day
select
*, 
sum(running_km) OVER (order by date asc) as cumulative_distance
from (
select
  date_dt,
  date,
  sum(activity_distance/1000) as running_km,
  sum(activity_hours) as activity_hours
from dates
full outer join activities
on dates.date = activities.date_dt
and activities.modified_sport = 'Run' 
where date between '2024-02-01' and current_date()
group by 1,2
)
```

<LineChart data={running_by_day} x=date y=cumulative_distance yMax=105.0 yAxisTitle="Running Distance (km)">
    <ReferenceLine y=100.0 label="Target"/>
</LineChart>