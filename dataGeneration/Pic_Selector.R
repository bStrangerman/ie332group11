# This script assigns a random number of pictures to each warehouse in the database
num_of_warehouse <- 932
num_of_pictures <- 150
warehouse <- 1:num_of_warehouse 
pictures <- 1:num_of_pictures
warehouse_pic <- matrix(0,1,200)
for (i in 1:length(warehouse)){
z <- sample(seq(1,150),1, replace = TRUE)
warehouse_pic[i] <- pictures[z]
print(paste0("(",i,",",z,")")) # print out the sql insert into values
}
