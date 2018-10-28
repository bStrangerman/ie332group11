  train <- data.frame(SpaceID = c(1,2,3),
    State = c("WY","WY","MT"),                 
    Fencing = c(FALSE, FALSE, TRUE),
    LoadingDock = c(TRUE, FALSE, TRUE),
    Bathroom = c(TRUE, TRUE, TRUE),
    # Activity = factor(c("active", "very active", "very active", "inactive", "very inactive", "inactive", "very inactive", "active", "active", "very active"),
    # levels=c("very inactive", "inactive", "active", "very active"),ordered=TRUE),
    Price = c(1.06, 1, 0.5))
  train
  
  mytree <- rpart(Fencing ~ State + LoadingDock + Bathroom, data = train, method = "class", minsplit = 2, minbucket = 1, cp=-1)
  fancyRpartPlot(mytree)
  
  
  
  test <- data.frame(SpaceID = c(1,2,3),
                      State = c("MT","WY","WY"),                 
                      Fencing = c(TRUE, TRUE, TRUE),
                      LoadingDock = c(FALSE, TRUE, TRUE),
                      Bathroom = c(TRUE, FALSE, TRUE))
  test
  
  test$PriceClass <- predict(mytree, newdata = test, type="class") #Returns the predicted class
  test$PriceProb <- predict(mytree, newdata = test, type="prob") #Returns a matrix of predicted probabilities
  
  test