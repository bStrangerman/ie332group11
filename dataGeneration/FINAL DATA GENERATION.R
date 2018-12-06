

####### This scipt generates data for all of the main entities represented in our database. 
#Additional R functions and CSV files in the DATA GENERATION folder are needed to successfully run this code. #########



################# USER DATA#################
#All information generated in this section is data for both Owners and Lessees, which is separated upon SQL injection###

##The following functions are taken from an R-project package generator
#REFERENCE: Hendricks, P. (2015, Aug). Package 'generator'. R Project. Retrieved from https://cran.r-project.org/web/packages/generator/generator.pdf

n = 1000 #number of users to generate

#Create n random credit card numbers
r_credit_card_numbers <- function(n) {
  return(paste(sample(1000:9999, size = n, replace = TRUE),
               sample(1000:9999, size = n, replace = TRUE),
               sample(1000:9999, size = n, replace = TRUE),
               sample(1000:9999, size = n, replace = TRUE), sep = "-"))
}

#Create n random birthdays
r_date_of_births <- function(n, start = as.Date("1918-01-01"), end = Sys.Date()) {
  as.Date(sample.int(end - start, size = n,replace=TRUE), origin = start)
}

#Create n random email addresses
r_email_addresses <- function(n) {
  build_email_address <- function() {
    first_length <- sample(1:10, size = 1)
    second_length <- sample(1:10, size = 1)
    third_array <- c('com','org','edu','net')
    first_part <- paste0(sample(letters, size = first_length), collapse = "")
    second_part <- paste0(sample(letters, size = second_length), collapse = "")
    third_part <- paste0(sample(third_array,1))
    return(paste0(first_part, "@", second_part, ".", third_part))
  }
  return(replicate(n, build_email_address()))
}

#Create n random full names
r_full_names <- function(n) {
  CommonNames <- read.csv("Most Common Names.csv") #Read CSV file of most common names 
  names <- CommonNames[3:1002,18]
  surnames <- CommonNames[3:502,1]
  first_names <- names[c(sample(1:length(names), size = n, replace = TRUE))]
  return(paste(first_names, surnames[c(sample(1:length(surnames), size = n, replace = TRUE))], sep = " "))
}

#Select n random full names from Most Common Names CSV
r_first_names <- function(n){
  CommonNames <- read.csv("Most Common Names.csv")
  names <- CommonNames[3:1002,18]
  first_names <- names[c(sample(1:length(names),size=n,replace=TRUE))]
  return(paste(first_names))
}

#Select n random last names from Most Common Names CSV
r_last_names <- function(n){
  CommonNames <- read.csv("Most Common Names.csv")
  surnames <- CommonNames[3:502,1]
  last_names <- surnames[c(sample(1:length(surnames),size=n,replace=TRUE))]
  return(paste(last_names))
}

#Generate n random phone numbers
r_phone_numbers <- function(n, use_hyphens = FALSE, use_parentheses = FALSE, use_spaces = FALSE) {
  left_paren <- ""
  right_paren <- ""
  if(use_parentheses) {
    left_paren <- "("
    right_paren <- ")"
  }
  hyphen <- ""
  if(use_hyphens) hyphen <- "-"
  space <- ""
  if(use_spaces) space <- " "
  build_phone_number <- function(l, r, h, s) {
    paste0(l, paste0(sample(1:9, size = 3), collapse = ""), r, h, s,
           paste0(sample(1:9, size = 3), collapse = ""), h, s,
           paste0(sample(1:9, size = 4), collapse = ""),
           collapse = "")
  }
  
  
  return(replicate(n, build_phone_number(l = left_paren,
                                         r = right_paren,
                                         h = hyphen,
                                         s = space)))
}

install.packages(digest)
library(digest)

#Create n random encrypted passwords
r_passwords <- function(n){
  samp<-c(2:9,letters,LETTERS,"!", "$", "%", "&", "(", ")", "*")
  password<- function(){
    basic <- paste(sample(samp,8),collapse="") #Create generic password
    encrypted <- digest(basic,"md5",serialize=FALSE) #Encrypt password
    paste(encrypted)
  }
  return(replicate(n,password()))
}


#Generate n random usernames
r_usernames <- function(n){
  build_username <- function(){
    first_length <- sample(2:7, size = 1)
    second_length <- sample(3:8, size = 1)
    first_part <- paste0(sample(letters, size = first_length), collapse = "")
    second_part <- paste0(sample(letters, size = second_length), collapse = "")
    paste0(first_part, second_part)
  }
  return(replicate(n, build_username()))
}

#Pull n random companies from a CSV file containing a list of Fortune 500 companies
r_companies <- function(n){
  CompanyData <- read.csv("Fortune500Companies.csv")
  companies <- CompanyData[2:501,1]
  paste(sample(companies,1000,replace=TRUE))
}

#Compile and save user data, and write data to CSV file titled 'USERS'
user_data <- data.frame(r_usernames(n),r_first_names(n),r_last_names(n),r_passwords(n),r_email_addresses(n),r_phone_numbers(n),r_companies(n))
write.table(user_data,file = "USERS.csv", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = TRUE)

########## USER ROLES ##############
#This code assigns each user a role
# Warehouse Owner = 3
# Lessee = 5

warehouseOwners <- c(1:400) #Designate first 400 random users as owners
ownerRoles <- rep(3,length(warehouseOwners))

lessees <- c(401:1000) #Designate last 600 random users as lessees
lesseeRoles <- rep(5,length(lessees))

userIDs <- c(warehouseOwners, lessees)
roleIDs <- c(ownerRoles,lesseeRoles)

userRoles_data <- data.frame(userIDs,roleIDs)
write.table(userRoles_data,file="USER_ROLES.csv",append=F,quote=F,sep=",",row.names=F,col.names=T)

########### WAREHOUSE DATA ####################

##ADDRESS##
randomAddresses <- read.csv("randomAddresses.csv") #Pull addresses from CSV containing randomly generated addresses (see Address_creator)
houseNumber <- randomAddresses[ ,21]
streetName <- randomAddresses[ ,22]
addresses <- paste(houseNumber,streetName,sep=" ")

##OWNER ID##
ownerID <- sample(1:400,length(addresses),replace=T) #First 400 Users designated as Owners 

##ZIP CODE##
zipcodes <- randomAddresses[ ,2]

##CITIES##
cities <- randomAddresses[ ,4]

##STATES##
states<- randomAddresses[ ,5]

##LATITUDES AND LONGITUDES##
latitudes <- randomAddresses[ ,7]
longitudes <- randomAddresses[ ,8]

### WAREHOUSE descriptive statistics taken from real warehouses at LoopNet.com
#REFERENCE: Loopnet commercial real estate. (n.d.). CoStar Group Inc. Retrieved from http://www.loopnet.com/

##BUILDING SIZE##
n=length(addresses)
#Building Size Variables
size_build_min = 1300 #SF
size_build_max = 604095 #SF
size_build_mean = 50777.02 #SF
size_build_sd = 91662.87 #SF
size_build_Q1 = 10000 #SF
size_build_Q3 = 40800 #SF
########## BUILDING SIZE SYNTHESIZE ##########
size_build = floor(rnorm(10000, mean = size_build_mean, sd = size_build_sd))
size_build = truncate(size_build,size_build_Q1,size_build_Q3)
size_build = size_build[!is.nan(size_build)]
size_build = size_build[1:length(addresses)]

#Compile and save warehouse data, and write data to CSV file titled 'WAREHOUSES'
warehouse_data <- data.frame(ownerID, addresses,zipcodes,cities,states,latitudes,longitudes,size_build)
write.table(warehouse_data,file = "WAREHOUSES.csv", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = FALSE)

############# SPACE DATA ##########################

##WAREHOUSE ID##
#random number greater than 2000
randomAddresses <- read.csv("randomAddresses.csv") #pull addresses from CSV of length 809
addresses <- randomAddresses[ ,1]
warehouseID <- sample(158:932,1400,replace=T)

##SPACE SIZE##
#Size Variables
size_avail_min = 500 #SF
size_avail_max = 304514 #SF
size_avail_mean = 14780.79 #SF
size_avail_sd = 28588.10 #SF
size_avail_Q1 = 3020 #SF
size_avail_Q3 = 14605 #SF
##### SIZE AVAILABLE SYNTHESIZE #####
size_avail = floor(rnorm(10000, mean = size_avail_mean, sd = size_avail_sd))
size_avail = truncate(size_avail,size_avail_Q1,size_avail_Q3)
size_avail = size_avail[!is.nan(size_avail)]
size_avail = size_avail[1:1400]


##VERIFY BUILDING SIZE >= SPACE SIZE##
for (i in 1:length(addresses)){
  if (size_build[i] < size_avail[i]){
    size_build[i]=size_avail[i]
  }
  else{
    size_build[i]=size_build[i]
  }
}

##PRICES##
randomStates <- randomAddresses[ ,5]
states <- rep(c("AK","AL","AR","AZ","CA","CO","CT","DE","FL","GA","HI","IA","ID", "IL","IN","KS","KY","LA","MA","MD","ME","MI","MN","MO","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY", "OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VA","VT","WA","WI","WV","WY"),28)
amenities <- matrix(0,1,1400)
RPPs <- c(1.054,0.866,0.959,0.869,1.144,1.03,1.087,1.002,0.997,0.921,1.184,0.93,0.989,0.903,0.902,0.905,0.878,0.904,0.984,1.095,1.078,0.933,0.975,0.864,0.895,0.941,0.905,0.974,1.059,1.132,0.936,1.156,0.909,0.915,0.893,0.89,0.998,0.984,0.996,0.903,0.883,0.902,0.969,0.973,1.106,1.023,1.055,0.876,0.928,0.967)

###### PRICE SYNTHESIZE ######
#Price Variables
price_min = .08 #$/SF/month
price_max = 4.00 #$/SF/month
price_mean = .94 #$/SF/month
price_sd = .51 #$/SF/month
price_Q1 = .58 #$/SF/month
price_Q3 = 1.17 #$/SF/month

price = round(rnorm(10000, mean = price_mean, sd = price_sd), digits = 2)
price = truncate(price,price_Q1,price_Q3)
price = price[!is.nan(price)]
price = price[1:1400]

#Adjust Price based on number of warehouse amenities and warehouse attributes
for (i in 1:1400){
  binaryStates <- matrix(0,1,50)
  x <- randomStates[warehouseID[i]-157]
  y<- which(x == states)[[1]]
  binaryStates[y] = 1
  z <- sample(c(0,1,2,3,4,5,6),1,replace=FALSE,prob=c(0.4925,0.2289,0.1343,0.0597,0.0299,0.0299,0.0149))
  amenities[i] = z
  price[i] = round(price[i]*sum(binaryStates*RPPs),digits=2)+z*0.15
}

#Compile and save spaces data, and write data to CSV file titled 'SPACES'
spaces_data <- data.frame(warehouseID, size_avail, price)
write.table(spaces_data,file = "SPACES.csv", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = FALSE)

################## ATTRIBUTE DATA ################
##NUMBER OF ATTRIBUTES##
amenities #vector of number of amenities for space i

##SPACE ID##
space_ID_part1 = c(1:length(amenities))


space_id_part2 = rep(0,sum(amenities))
k=1

for (i in 1:length(amenities)){
  if (amenities[i]>0){
    for (j in 1:amenities[i]){
      space_id_part2[k] = i
      k=k+1
    }
  }
}

space_ID = c(space_ID_part1,space_id_part2)

##ATTRIBUTES##

#ATTRIBUTE TYPE#
types <- c(1,2,3)
attribute_types <- rep(0,length(amenities))
attribute_types <- sample(types,length(amenities),replace=T)

#ATTRIBUTES#
possible_attributes <- c(4,5,6,7,8,9,10,11,12,13,14,15,16,17)
attributes <- sample(possible_attributes,length(space_id_part2),replace=T)

attributes_and_types <- c(attribute_types,attributes)

#Compile and save attributes data, and write data to CSV file titled 'ATTRIBUTES'
attributes_data <- data.frame(space_ID,attributes_and_types)
write.table(attributes_data,file = "ATTRIBUTES.csv", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = FALSE)

############### CONTRACTS DATA ########################
n = 2000 #Number of contracts to generate

##SPACE ID##
spaceID <- sample(1:1400,n,replace=T) #randomize spaceID to which the contract belongs

##LESSEE ID##
lesseeID <- sample(350:1000,n,replace=T) #randomize lesseeID to which the contract belongs

spaceID <- sort(spaceID, decreasing = FALSE) #sort spaceIDs in increasing order

##START DATE AND END DATE##

#Initialize start date and end date vectors
start <- rep(as.Date('1900-01-01'),n)
end <- rep(as.Date('1900-01-01'),n)
start_date <- rep(0,n)
end_date <- rep(0,n)
start_date[1] <- sample(seq(1, 2165, by=1), 1)
end_date[1] <- start_date[1] + sample(14:365)
start[1] <-  as.Date(start_date[1],origin="2012-12-31")
end[1] <- as.Date(end_date[1],origin="2012-12-31")

#Assign start dates and end dates to each space
for (i in 2:length(spaceID)){
  if (spaceID[i] == spaceID[i-1]){ #Ensure two contracts for the same space do not overlap in the schedule  
    start_date[i] <- sample(seq(end_date[i-1], end_date[i-1]+sample(14:365,1)), 1)
    end_date[i] = start_date[i] + sample(14:365) #Ensure end date > start date
  }
  else {
    start_date[i] <- sample(seq(1, 2165, by=1), 1)
    end_date[i] = start_date[i] + sample(14:730) #Ensure end date > start date
  }
  start[i] <- as.Date(start_date[i],origin="2012-12-31")
  end[i] <- as.Date(end_date[i],origin="2012-12-31")
}

##AMOUNT CHARGED##
fee = 1.05 #Our company fee
amount_charged <- rep(0,length(spaceID))

for (j in 1:length(spaceID)){
  amount_charged[j] = price[spaceID[j]] * as.numeric(end[j]-start[j])/31 * size_avail[spaceID[j]] * fee
}

##Contract Information##
storage_items <- c('chickens','containers','forklifts','trucks', 'electronics','spare parts','machine parts','equipment',
                   'personal items','equipment','personal items','vehicle parts','printed materials','stationery',
                   'telecommunication equipment','trade fair and exhibition exhibits','bulk and packaged goods','glass',
                   'dry and liquid goods','medical supplies','packaged foods and chocolate items','cosmetics and personal hygiene products',
                   'household and industrial appliances','goods under customs control','textiles','dangerous')
contract_information <- rep(0,length(spaceID))

#Give each contract random storage items from the list above
for (k in 1:length(spaceID)){
  contract_information[k] <- sample(storage_items,1)
}

#Compile and save contracts data, and write data to CSV file titled 'CONTRACTS'
contract_data <- data.frame(spaceID,lesseeID,start,end, amount_charged, contract_information)
write.table(contract_data,file = "CONTRACTS.csv", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = FALSE)

########## CONTRACT STATUS ###############

contractID <- sample(1:2000,2000,replace=F) #randomize contractID 
round(contractID, digits=0)

contractStatus <- sample(2:4,2000,replace=T) #randomize the status of the contract
round(contractStatus, digits=0)

#Compile and save contract status data, and write data to CSV file titled 'CONTRACT STATUS'
contract_status_data <- data.frame(contractID, contractStatus)
write.table(contract_status_data,file = "CONTRACT_STATUS.csv", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = FALSE)

######### RATINGS #############

###NUMERIC CONTRACT RATINGS###
n = 1200 #Assume 60% of contracts are given ratings by users

#Initialize contract and rating vectors
k = 1
h = 1
contractID_1 <- rep(0,n)
contractID_2 <- rep(0,n)
numeric_ratingID <- rep(0,n*7)
rating_result_1 <- rep(0,n*7)
text_ratingID <- rep(0,n*5)

#Assign a rating to each category for every contract
for (j in 1:n){
  for (i in 1:7){ #Assign a numeric rating ID
    contractID_1[k] = j
    numeric_ratingID[k] = i
    rating_result_1[k] = sample(1:5,1,replace=T)
    k = k+1
  }
  for(i in 1:5){ #Assign a text rating ID
    contractID_2[h] = j
    text_ratingID[h] = i
    h = h+1
  }
}

#Compile and save Numeric Ratings data, and write data to CSV file titled 'NUMERIC_RATINGS'
numericRatingsData <- data.frame(contractID_1, numeric_ratingID, rating_result_1)
write.table(numericRatingsData,file = "NUMERIC_RATINGS.csv", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = FALSE)


###TEXT CONTRACT RATINGS###
rating_result_2 <- rep(0,n*5)

#For each rating, assign a generic written review based on the numeric review
for (i in 1:(n*5)){
  if (rating_result_1[i] == 1){
    rating_result_2[i] <- sample(c("This experience was terrible.","Worst warehouse ever.","Awful.","Very poor. I regret taking part in this.","Bad company to work with. I would not do so again."),1)
  }
  else if (rating_result_1[i] == 2){
    rating_result_2[i] <- sample(c("This space had a lot of potential but it did not meet my requirements.","Did not have a good time.","Sad!","Could have been much better."),1)
  }
  else if (rating_result_1[i] == 3){
    rating_result_2[i] <- sample(c("Average experience.","It was fine. Nothing special.","Good.","Met my requirements just fine."),1)
  }
  else if (rating_result_1[i] == 4){
    rating_result_2[i] <- sample(c("Very good experience!","Got everything I needed plus some more!","Good company to work with.","Everything was satisfactory."),1)
  }
  else{
    rating_result_2[i] <- sample(c("Could not have been better!","Amazing experience!","10/10 would work with again.","This has been the best trade deal in the history of trade deals maybe ever."),1)
  }
}

#Compile and save Text Ratings data, and write data to CSV file titled 'TEXT_RATINGS'
textRatingsData <- data.frame(contractID_2, text_ratingID, rating_result_2)
write.table(textRatingsData,file = "TEXT_RATINGS.csv", append = FALSE, quote = FALSE, sep = ",", row.names = FALSE, col.names = FALSE)