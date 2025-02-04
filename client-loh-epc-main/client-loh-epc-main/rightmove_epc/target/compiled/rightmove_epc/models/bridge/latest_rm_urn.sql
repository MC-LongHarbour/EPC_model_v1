with rm as (

    select * from ANALYTICS_DEV.dbt_melissa_rm_epc.stg_rightmove
    where UPRN IS NOT NULL
),

change_date AS (
    SELECT 
        UPRN AS UPRN_CD, 
        MAX(CHANGE_DATE) AS MAX_CHANGE_DATE 
    FROM rm
    GROUP BY UPRN
),

rm_latest as (

    SELECT distinct * FROM rm
    LEFT JOIN change_date cd
    ON rm.UPRN = cd.UPRN_CD
    WHERE cd.MAX_CHANGE_DATE = rm.CHANGE_DATE 
 --  and UPRN = 100090588560
    
)

select DISTINCT * from rm_latest

/*
select uprn, count(*) from rm_latest
group by 1
having count(*) >1
*/