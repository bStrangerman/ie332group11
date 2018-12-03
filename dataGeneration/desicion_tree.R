  install.packages("rpart")
  install.packages("rattle")
  library(rpart)
  library(rattle)
  library(rpart.plot)
  library(RColorBrewer)

  setwd("C:/xampp/htdocs/ie332group11")
  attributes <- read.csv("attributes.csv")
  attributes[is.na(attributes)] <- FALSE

  
  names(attributes)
  train <- attributes

  tree <- rpart(formula = Price ~ State + Yard + Fenced_Yard + Bay_Doors_Loading_Dock + Sprinkler_System + Bathroom + Customizable + Power + crane + floor_drains + Mezzanine + Kitchen + Air_Conditioning + Security + Auto_Service + New, data = train, cp=-1)
  fancyRpartPlot(tree)

  tree$variable.importance
  printcp(tree)
  plotcp(tree)
  summary(tree)

  plot(tree)
  text(tree)

  test <- data.frame(
                     State = c("Wyoming"),
                     Yard = c(TRUE),
                     Fenced_Yard = c(FALSE),
                     Bay_Doors_Loading_Dock = c(FALSE),
                     Sprinkler_System = c(FALSE),
                     Customizable = c(FALSE),
                     Power = c(TRUE),
                     crane = c(FALSE),
                     floor_drains = c(FALSE),
                     Mezzanine = c(TRUE),
                     Kitchen = c(TRUE),
                     Air_Conditioning = c(TRUE),
                     Security = c(TRUE),
                     Auto_Service = c(FALSE),
                     New = c(FALSE),
                     Bathroom = c(TRUE))

  test$PriceClass <- predict(tree, test, type="class") #Returns the predicted class
  test$PriceProb <- predict(tree, newdata = test, type="prob") #Returns a matrix of predicted probabilities

  test

  new.fit <- prp(tree,snip=TRUE)$obj
  fancyRpartPlot(new.fit)

  install.packages("party")

  # load the package
  library(party)
  # load data
  # fit model
  fit <- ctree(Price~., data=attributes, controls=ctree_control(minsplit=2,minbucket=2,testtype="Univariate"))
  plot(fit)
  text(fit)
  # summarize the fit
  summary(fit)
  # make predictions
  predictions <- predict(fit, attributes[,1:6])
  # summarize accuracy
  mse <- mean((attributes$Price - predictions)^2)
  print(mse)
