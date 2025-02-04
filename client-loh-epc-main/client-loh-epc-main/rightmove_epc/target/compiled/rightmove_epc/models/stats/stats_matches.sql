WITH matches AS (
    SELECT 
        MATCH_RESULT,
        COUNT(*) AS count,
        COUNT(DISTINCT addressid) AS count_distinct_address,
        COUNT(addressid) AS count_address,
        COUNT(DISTINCT uprn) AS count_distinct_uprn,
        COUNT(uprn) AS count_uprn
    FROM ANALYTICS_DEV.dbt_melissa_rm_epc.rm_all_matches -- Replace with your actual table name or reference
    GROUP BY MATCH_RESULT

),
no_matches AS (
    SELECT 
        MATCH_RESULT,
        COUNT(*) AS count,
        COUNT(DISTINCT addressid) AS count_distinct_address,
        COUNT(addressid) AS count_address, -- This is redundant as it's the same as COUNT(*)
        COUNT(DISTINCT uprn) AS count_distinct_uprn,
        COUNT(uprn) AS count_uprn
    FROM ANALYTICS_DEV.dbt_melissa_rm_epc.rm_no_matches -- Replace with your actual table name or reference
    GROUP BY MATCH_RESULT
)

SELECT 'match' result, *  FROM matches
UNION ALL
SELECT 'no match' result,* FROM no_matches
order by result