
  create or replace   view ANALYTICS_DEV.dbt_melissa_rm_epc.stats_property_totals
  
   as (
    with houses as (

    select 
    'flat' source,
    count(*) count
    from ANALYTICS_DEV.dbt_melissa_rm_epc.houses_report

),

flats as (

    select 
    'house' source,
    count(*) count
    from ANALYTICS_DEV.dbt_melissa_rm_epc.flats_report

)

select * from houses
union all
select * from flats
  );

