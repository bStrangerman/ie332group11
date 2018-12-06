#Truncate Function(Space Avail/Build Size/ Price)

#This function takes in synthesized data and eliminates data outside the first and third quartile ranges of the real-world data.


truncate<- function(matrix,size_min,size_max,n){
  for (i in 1:n)
    {if (matrix[i]<size_min)
      matrix[i]=NaN
    else if (matrix[i]>size_max)
      matrix[i]=NaN
    else
      matrix[i]=matrix[i]}
  return(matrix)
}

