WITH rm AS (
    SELECT * FROM ANALYTICS_DEV.dbt_melissa_rm_epc.latest_rm_urn
    -- WHERE UPRN = 100013137 -- This line is commented out, but could be used to filter the dataset.
),
false_rm AS (
    SELECT 
        UPRN,
        COUNT(LISTING_ID) AS listing_count
    FROM rm
    GROUP BY UPRN
    -- HAVING COUNT(LISTING_ID) > 1 -- This is commented out but would filter to only UPRNs with more than one listing.
),
get_false AS (
    SELECT 
        rm.*,
        listing_count
    FROM rm
    INNER JOIN false_rm ON rm.UPRN = false_rm.UPRN
)
SELECT * FROM get_false