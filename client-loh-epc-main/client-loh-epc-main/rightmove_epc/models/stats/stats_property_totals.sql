with houses as (

    select 
    'flat' source,
    count(*) count
    from {{ ref('houses_report') }}

),

flats as (

    select 
    'house' source,
    count(*) count
    from {{ ref('flats_report') }}

)

select * from houses
union all
select * from flats