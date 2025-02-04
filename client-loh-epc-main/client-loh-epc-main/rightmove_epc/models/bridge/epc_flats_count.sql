with epc as (

    select * from {{ ref('latest_epc_urn') }}

),

flat_epc as (

    select uprn,
    count(BUILDING_REFERENCE_NUMBER) as building_ref_count
    from epc
    group by 1
    having count(BUILDING_REFERENCE_NUMBER) >1

)

select * from flat_epc