
  create or replace   view ANALYTICS_DEV.dbt_melissa_rm_epc.rm_listings_count
  
   as (
    with rm as (

    select * from ANALYTICS_DEV.dbt_melissa_rm_epc.latest_rm_urn

),

false_rm as (

    select 
    uprn,
    count(LISTING_ID) listing_count
    from rm
    group by 1
   -- having count(LISTING_ID) >1

)

select * from false_rm
  );

