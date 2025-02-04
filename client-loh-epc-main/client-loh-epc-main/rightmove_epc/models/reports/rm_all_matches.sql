with addr as (

    select distinct
  --  LISTING_ID,
    ADDRESSID, 
    ADDRESS_1,
    ADDRESS_2,
    FULL_POSTCODE, --- DOESNT LOOK CORRECT
    UPRN,
    LOCAL_AUTHORITY_CODE,
    LOCAL_AUTHORITY,
    GOV_REGION_CODE,
    FLOOR_AREA,
    FLOOR_LEVEL,
    EPC_UPRN,
    EPC_ADDRESSID
    
    from {{ ref('address_match') }}
    where MATCH_EPC = 'YES' 
),

uprn_addr as (

    select 
    distinct
  --  LISTING_ID,
    ADDRESSID, 
    ADDRESS_1,
    ADDRESS_2,
    FULL_POSTCODE, --- DOESNT LOOK CORRECT
    UPRN,
    LOCAL_AUTHORITY_CODE,
    LOCAL_AUTHORITY,
    GOV_REGION_CODE,
    FLOOR_AREA,
    FLOOR_LEVEL,
    EPC_UPRN,
    EPC_ADDRESSID
    
    from {{ ref('uprn_address_match') }}
    where MATCH_EPC = 'YES' 
),

uprn as (

    select 
    distinct
  --  LISTING_ID,
    ADDRESSID, 
    ADDRESS_1,
    ADDRESS_2,
    FULL_POSTCODE, --- DOESNT LOOK CORRECT
    UPRN,
    LOCAL_AUTHORITY_CODE,
    LOCAL_AUTHORITY,
    GOV_REGION_CODE,
    FLOOR_AREA,
    FLOOR_LEVEL,
    EPC_UPRN::VARCHAR AS EPC_UPRN,
    EPC_ADDRESSID

    from {{ ref('uprn_match') }}
    where MATCH_EPC = 'YES'
),

final as (

select 'ADDRESS AND POSTCODE MATCH' AS MATCH_RESULT, * from addr
union all
select 'UPRN MATCH' AS MATCH_RESULT, * from uprn
union all
select 'MATCH ADDRESS NO MATCH TO EPC UPRN' AS MATCH_RESULT, * from uprn_addr
)

select distinct * from final