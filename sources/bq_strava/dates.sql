select
date 
from unnest(generate_date_array('2020-01-01', last_day(current_date('America/Vancouver')), interval 1 day)) as date