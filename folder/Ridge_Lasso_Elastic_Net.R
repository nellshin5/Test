install.packages("ISLR")
install.packages("glmnet")
library(glmnet)

data(Hitters, package = "ISLR")
head(Hitters)
dim(Hitters)

#missing data check
sum(is.na(Hitters$Salary))
Hitters = na.omit(Hitters)
sum(is.na(Hitters))
names(Hitters)

X = model.matrix(Salary ~ ., Hitters)[, -1]
y = Hitters$Salary

fit = lm(Salary ~ ., Hitters)
coef(fit)

sum(abs(coef(fit)[-1])) #intercept »©°í predictor coefficient ´Ù ´õÇÔ
sum(coef(fit)[-1] ^ 2)
