#1. Install a bunch of libraries
library(AppliedPredictiveModeling)
library(randomForest)
library(popbio)
library(caret)
library(pscl)
library(ROCR)
library(ggmap)
library(AUC)
library(pROC)
library(gplots)
library(Hmisc)
library(gmodels)

#2. Connect to datasets
simulatedTrain <- read.csv('##location of training set')
simulatedTest <- read.csv('##location of test set')

#3. Run a regression 
lrModel <- glm(PF2 ~ Streets,family="binomial", data = simulatedTrain)
l
summary(lrModel)
#4. Run the pR2 (pseudo r-squared), get the McFadden statistic
pR2(lrModel)

# Predict the test set probabilities using the training set model
ClassProbs1 <- predict(lrModel, simulatedTest, type="response")
#ignore the warning message

#put these into a data frame
testProbs1 <- data.frame(Class = simulatedTest$PF2, Probs = ClassProbs1)
#ignore the warning message

#Prob Distrobution Plot
adminPropsPlot1 <- ggplot(testProbs1, aes(x = Probs, fill=Class)) + geom_density(binwidth = 0.02) +
  facet_grid(Class ~ .) + xlab("Probability") 
adminPropsPlot1

#Choose a cut off value (.2 is not always appropriate)
testProbs1$predClass  = ifelse(testProbs1$Probs > .2 ,1,0)

#create Confusion Matrix
#table(factor(testProbs1$predClass, levels=min(testProbs1$Class):max(testProbs1$Class)),factor(testProbs1$Class, levels=min(testProbs1$Class):max(testProbs1$Class)))
confusionMatrix(testProbs1$Class ,testProbs1$predClass)

#ROC Curve
pred1 <- prediction( testProbs1$Probs, testProbs1$Class)
perf1 <- performance(pred1,"tpr","fpr")
plot(perf1)
abline(a=0, b= 1)

#Area Under Curve
auc(testProbs1$Class, testProbs1$Probs)


#Tabulate training data set
PF2.tab <- table(simulatedTrain$PF2)
prop.table(PF2.tab)

#Get Chi-Squared Value and Crosstable for each predictor
CrossTable(simulatedTrain$PF2, simulatedTrain$Assaults, prop.r=FALSE, prop.t=FALSE, prop.chisq=FALSE, chisq=TRUE)

#T-test
t.test(simulatedTrain$lognearabandbuild~ simulatedTrain$PF2)

#All Predictor Variables
#Binary Predictors
AllBiPredictors <- cbind("#predictors go here")
#Hone down to chi squared significant predictors
X2SigPredictors <- cbind("# X2 Significant predictors")
#Generalized Linear Model Significant Predictors
GlmSigBiPredictors <- cbind("# GLM Significant predictors")
#T-Test Significant Predictors
ttestsigpredictors <- cbind("# T-test Significant predictors")
#See if log transformed versions of predictors are significant
logttestsigpredictors <- cbind("# Log Transformed Significant predictors")

#All significant predictors
SigPredictors <- cbind("# All Significant predictors")
#Final Pearson correlation table
rcorr(SigPredictors, type = c("pearson"))


