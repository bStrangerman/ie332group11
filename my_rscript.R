print("Before!")
args <- commandArgs(TRUE)    
N <- args[1]    
# N<-821
x <- rnorm(N,0,1)     
png(filename="temp.png", width=500, height=500)
hist(x, col="lightblue")    
print("After!")
dev.off()
