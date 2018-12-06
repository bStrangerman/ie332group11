#### USER CREATION DATE #####
###This section prints SQL queries for appending the phprbac_users table with random creation dates


for (i in 667:1000){
  x =sample(seq(as.Date('2013-01-01'), as.Date('2018-12-05'), by="day"), 1)
  print('UPDATE phprbac_users')
  print(paste('SET CreationDate=',x))
  print(paste('WHERE UserID = ',i,';'))
}