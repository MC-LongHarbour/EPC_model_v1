-- where uprn is not matched we try address.

with uprn as (

    select 
    up.LISTING_ID,
    CHANGE_DATE,
    up.ADDRESSID,
    up.ADDRESS_1,
    up.ADDRESS_2,
    FULL_POSTCODE,
    up.UPRN,
    LOCAL_AUTHORITY_CODE,
    LOCAL_AUTHORITY,
    GOV_REGION_CODE,
    FLOOR_AREA,
    FLOOR_LEVEL,
    BEDROOM,
    PROPERTY_TYPE_1,
    PROPERTY_TYPE_2,
    COMBINED_PROPERTY_TYPE,
 -- need to sleect the same fields as address match
    CASE WHEN ad.ADDRESSID is null then 'NO' ELSE 'YES' end as MATCH_EPC,
    ad.ADDRESSID AS EPC_ADDRESSID,
    ad.UPRN AS EPC_UPRN

     from {{ ref('no_uprn_match') }} up
    left join {{ ref('dim_addressid') }} ad on up.ADDRESSID = ad.ADDRESSID
    and up.FULL_POSTCODE = ad.POSTCODE
   
)

SELECT * FROM UPRN

