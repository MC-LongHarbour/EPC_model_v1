
  
    

        create or replace transient table ANALYTICS_DEV.dbt_melissa_rm_epc.zero_bedrooms
         as
        (with houses as (

    select * from ANALYTICS_DEV.dbt_melissa_rm_epc.houses_report
    where BEDROOM = 0
),

flats as (

    select * from ANALYTICS_DEV.dbt_melissa_rm_epc.flats_report
        where BEDROOM = 0

)

select * from flats
union all
select * from houses
        );
      
  