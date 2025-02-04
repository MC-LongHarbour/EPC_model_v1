Data Model of RightMove and EPC data for Total Floor Area

### Project Goals

1. match RightMove data to EPC data for Total Floor Area per Property
2. Create reports to help investigations into anomalies

### Be aware of the following

1. UID for EPC data is not UPRN. It is BUILDING_REFERENCE_NUMBER
2. UPRN is not always populated for both RightMove and EPC data
3. Address and UPRN are the only fields we can join on to get the level of granularity needed
4. Only the latest records for EPC and RightMove data should be used to avoid duplicate and incorrect floor size totals
5. there can be multiple listings for one RightMove UPRN i.e. multiple branches, webites - therefore lISTING ID is not requierd in the final tables and unique address' / URPNs are provided instead.

### Key Tables:

- rm_all_matches
  includes all RightMove records that have matched to EPC, either by UPRN or ADDRESSID. 'MATCH ADDRESS NO MATCH TO EPC UPRN' means that RM UPRN did not match EPC at first so address was used after.

- epc_flats
  includes ALL address' with multiple UPRN's per BUILDING_REFRENCE_NUMBER. This means that the RPC Cert has inspected one building which contains multiple units i.e. sold as rooms or flats.

- zero_bedrooms
  this report shows all rightmove listings with 0 bedrooms. This could include addresses that have more than 0 bedrooms i.e. data quality issues. if there is a UPRN and ADDRESSID that matches EPC then we can still get the floor area and sanity check against bedroom.

- houses_report
  this report includes all houses with total floor area.

- flats_report
  this report includes all flats/apartment with total floor area. Note that where an EPC report has multiple UPRNS per BUILDING_REFRENCE_NUMBER, has MATCH_TYPE = MULTIUPRN_EPC

### Other Tables:

- rm_no_matches
  all rm listings that did not match epc

- rm_listings
  all rightmove listings with a count

- epc_remove
  all epc data that is not valid for this analysis
