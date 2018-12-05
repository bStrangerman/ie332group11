###WAREHOUSE INFORMATION###
###This section prints SQL queries for appending the Warehouse Information column
#to the already produced WAREHOUSES data###

warehousesID <- c(667:932)
possible_warehouse_information <- c('\'The immediate area is primarily comprised of Agricultural land though numerous residential developments, both planned and existing, can be found.It is home to one of the most active residential submarkets within the county. Additionally the interstate is located just 2 miles to the east.\''
                          ,'\'Only a few blocks from the park and surrounded by restaurants, shopping & entertainment. Only 2 Blocks to the train station.\''
                          ,'\'Located almost on the same block as the museum. Easily accessible by all major highways. Daytime population of over 350,000 within a three-mile radius.\''
                          ,'\'Rents are below comparable properties and seller is currently paying for all water at the property, opportunity for future owner to increase rents by charge back for water. Accompany showing is required. No showing without accepted contract. Contact the listing agent to request the detail information. Please do not disturbing leasing office.\''
                          ,'\'Exceptional Visibility and Signage Opportunity on street. Extensive 10 in. glass line. Nearby development projects are aggressively pushing rental rates.\'')

for (i in warehousesID[1]:warehousesID[length(warehousesID)]){
  x = sample(possible_warehouse_information,1)
  print('UPDATE Warehouses')
  print(paste('SET WarehouseInformation=',x))
  print(paste('WHERE WarehouseID = ',i,';'))
}
