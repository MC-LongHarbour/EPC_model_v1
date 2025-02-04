
  create or replace   view ANALYTICS_DEV.dbt_melissa_rm_epc.epc_flats_count
  
   as (
    with epc as (

    select * from ANALYTICS_DEV.dbt_melissa_rm_epc.latest_epc_urn

),

flat_epc as (

    select uprn,
    count(BUILDING_REFERENCE_NUMBER) as building_ref_count
    from epc
    group by 1
    having count(BUILDING_REFERENCE_NUMBER) >1

)

select * from flat_epc
  );

