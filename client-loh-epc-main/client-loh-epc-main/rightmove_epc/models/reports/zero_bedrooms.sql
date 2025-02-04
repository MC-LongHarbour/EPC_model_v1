with houses as (

    select * from {{ ref('houses_report') }}
    where BEDROOM = 0
),

flats as (

    select * from {{ ref('flats_report') }}
        where BEDROOM = 0

)

select * from flats
union all
select * from houses

