with epc_max_date as (

    select uprn as UPRN_EPC,
    MAX(LODGEMENT_DATE) AS MAX_LODGEMENT_DATE,
    from  ANALYTICS_DEV.dbt_melissa_rm_epc.stg_epc_certs
    group by 1


),

latest_epc as (

    select * from ANALYTICS_DEV.dbt_melissa_rm_epc.stg_epc_certs epc
    inner join epc_max_date on epc.uprn = epc_max_date.UPRN_EPC
    where MAX_LODGEMENT_DATE = LODGEMENT_DATE
   -- and uprn = 200073066

)

select DISTINCT * from latest_epc


/*
select uprn, count(*) from latest_epc
group by 1
having count(*) >1
*/