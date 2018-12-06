

###### IMPORTANT: This code uses an online database for which an account is needed. My account information is included below.
###### This code takes an extremely long time to run, as finding real-world addresses is a tedious process. 
###### However, the code only needs to run as long as it takes to find how many addresses you want.
###### Each time a new address is found, a statement is printed. The code can be stopped at any time.
###### This code was only meant to be run one time. The addresses acquired for our website using this code can be found in 
    ## the randomAddresses.csv file, which is used throughout the FINAL DATA GENERATION algorithm



install.packages("geonames")     

library(geonames)

cat("\f")      

zipCodeData <- read.csv("ZipCodeData.csv")   #this is our table that includes lats and longs
options(geonamesUsername="arastovs")    #username used 
newZipCodeData <- data.frame()

n <- 1000   #Number of addresses to find
address <- 1
i <- 1

while(i <= n){
    
    AddressExists <- FALSE
    
    while(AddressExists == FALSE){
      AddressExists <- FALSE
      x <- round(runif(1, 2, 81179))
      latitude <- zipCodeData[x,7] 
      longitude <- zipCodeData[x,8] 
      tempAddress <- GNfindNearestAddress(latitude, longitude)
    
    if(length(tempAddress) != 0){ 
      if((tempAddress["street"] != "") & (tempAddress["streetNumber"] != "")){
        AddressExists <- TRUE
      }
    }
  }
  write.table(rbind(newZipCodeData, cbind(zipCodeData[x,], tempAddress["streetNumber"], tempAddress["street"])), file = "randomAddresses.csv", sep = ",", row.names = FALSE, col.names = FALSE, append=TRUE)
  print(paste("New address number: ", address))
  address <- address + 1
  i <- i+1
}
