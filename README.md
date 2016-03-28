# NearPredict
Set of R and ArcGIS Python tools used to create a predictive model based on distance to map features

The python code is explained in the pdf document above. The example it oulines is for a project I'm working on which attempts to predict 
the number of violent incidents in Philadelphia schools. However, the code is generalizable enough to work with any shapefiles, as long as there
are at least two shapefiles, and the distance to one is a predictor variable for an attribute of the other. The code works for either Ordinary Least Squares or 
Geographically Weighted Regression.

The R code is far more generalizable. Instead of requiring 2 shapefiles, the R code takes 2 CSVs. 
Each CSV must have the same column names. The first CSV is the training set, from which the best predictive variables are tested and choosen by using Pearson Correlation.
The second CSV is the test set, on which the model is tested using McFadden's Statistic, generating a Confusion Matrix, and Reciever Operating Curve.
