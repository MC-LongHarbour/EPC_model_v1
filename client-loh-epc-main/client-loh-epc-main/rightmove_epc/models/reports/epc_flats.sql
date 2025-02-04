with epc as (

    select * from {{ ref('latest_epc_urn') }}

),

flat_epc as (

    select uprn,
    count(BUILDING_REFERENCE_NUMBER) as building_ref_count
    from epc
    group by 1
    having count(BUILDING_REFERENCE_NUMBER) >1

),

match_flat_epc as (

    select epc.*,
    building_ref_count
    from epc
    inner join flat_epc on epc.uprn = flat_epc.uprn

)

select * from match_flat_epc