#Truncate Function(Space Avail/Build Size/ Price)
truncate<- function(matrix,size_min,size_max,n){
  #i=0
  for (i in 1:n)
    {if (matrix[i]<size_min)
      matrix[i]=NaN
    else if (matrix[i]>size_max)
      matrix[i]=NaN
    else
      matrix[i]=matrix[i]}
  return(matrix)
}

