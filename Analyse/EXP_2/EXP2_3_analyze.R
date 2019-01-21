#-----------
# read data
#-----------

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis/Data_Thesis_EXP2")
dataset = read.table("Data_Thesis_EXP2_edited.txt", fill = T, header = T, sep = "\t",  na.strings = "")
head(dataset)

#----------------
# read packages
#----------------
library(ggplot2)

library(reshape)
library(lattice)
library(car)
library(lme4)
library(leaps)
library(MASS)
library(gdata)
library(mlmRev)

library(lmerTest) 
library(multcomp)
library(MuMIn)

#----------
# lm fits
#----------

# calculate the difference between the displayed price and the reference price
#### 

product0 = c(.72,1.41,2.08,2.31,2.54,3.23,3.95)
product1 = c(.54,1.06,1.61,1.71,1.83,2.50,3.04)
product2 = c(.61,1.18,1.83,2.00,2.21,2.82,3.38)
product3 = c(.76,1.50,2.28,2.53,2.78,3.57,4.31)
product4 = c(.37,.75,1.12,1.24,1.37,1.74,2.11)
product5 = c(.43,.85,1.28,1.42,1.56,1.97,2.42)
product6 = c(1.12,2.24,3.34,3.74,4.11,5.22,6.36)
product7 = c(1.01,2.07,3.12,3.48,3.82,4.87,5.93)

allProducts = rbind(product0, product1, product2, product3, product4, product5, product6, product7)
all_prod = matrix(allProducts, nrow = 8, ncol = 7)

dataset$difference = rep(c(''), times = dim(dataset)[1])

# for loop to calculate the difference price
####

for (i in 1:dim(dataset)[1]){
  
  ProductIndex = as.numeric(as.character(substr(dataset$Product[i],8,8)))
  PriceIndex = as.numeric(as.character(substr(dataset$Prijs[i],6,6)))
  
  index1 = ProductIndex + 1
  index2 = PriceIndex + 1
  
  dataset$difference[i] = all_prod[index1,index2] -  all_prod[index1,4]
}

head(dataset)

# for loop to center the data: mean-centering
####

mean_of_price = mean(dataset$ActualPrice)
cat('The mean value of the variable price is: ', mean_of_price)

dataset$CenteredPrice = scale(dataset$ActualPrice, scale = FALSE)
dataset$StandardisedPrice = scale(dataset$ActualPrice)

head(dataset)

#--------------
# fit model 1 
#--------------

par(mfrow =c(3, 1))

# melt data accordingly (Actual price)
####

rt_subject_actual = melt(dataset, id.vars = c("ActualPrice"), measure.vars = c("RT_in_ms"))  
mean_rt = cast(rt_subject_actual,ActualPrice ~ ., mean)
colnames(mean_rt) = c("ActualPrice", "Mean")
summary(mean_rt)
head(mean_rt)

plot(mean_rt$ActualPrice, mean_rt$Mean, pch=16, ylab = "reaction time ", xlab = "prices", cex.lab = 1.3, col = "red" )

# melt data accordingly (Centered price)
####

rt_subject_centered = melt(dataset, id.vars = c("CenteredPrice"), measure.vars = c("RT_in_ms"))  
centered_rt = cast(rt_subject_centered,CenteredPrice ~ ., mean)
colnames(centered_rt) = c("CenteredPrice", "Mean")
summary(centered_rt)
head(centered_rt)

plot(centered_rt$CenteredPrice, centered_rt$Mean, pch=16, ylab = "reaction time ", xlab = "prices", cex.lab = 1.3, col = "red" )

# melt data accordingly (standardised price)
####

rt_subject_standardised = melt(dataset, id.vars = c("StandardisedPrice"), measure.vars = c("RT_in_ms"))  
standardised_rt = cast(rt_subject_standardised,StandardisedPrice ~ ., mean)
colnames(standardised_rt) = c("StandardisedPrice", "Mean")
summary(standardised_rt)
head(standardised_rt)

plot(standardised_rt$StandardisedPrice, standardised_rt$Mean, pch=16, ylab = "reaction time ", xlab = "prices", cex.lab = 1.3, col = "red" )

# show the tendency in the data (normal prices)
####

par(mfrow =c(3, 1))

print(ggplot(mean_rt, aes(ActualPrice,Mean)) + geom_point() + geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Prices", breaks=mean_rt$ActualPrice,
                           labels = as.factor(round(mean_rt$ActualPrice, digits = 2)), minor_breaks = NULL) 
      + theme(axis.text.x=element_text(angle=90,hjust=1)))

# show the tendency in the data (standardised prices)
####

print(ggplot(standardised_rt, aes(StandardisedPrice, Mean)) + geom_point() + geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="standardized prices", breaks=standardised_rt$StandardisedPrice,
                           labels = as.factor(round(standardised_rt$StandardisedPrice, digits = 2)), minor_breaks = NULL) 
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time (in ms) for each standardized price", subtitle = "Experiment 2")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5))
      + theme(axis.text.x=element_text(angle=90,hjust=1)))

# show the tendency in the data (centered prices)
####

print(ggplot(centered_rt, aes(CenteredPrice, Mean)) + geom_point() + geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Centered prices", breaks=centered_rt$CenteredPrice,
                           labels = as.factor(round(centered_rt$CenteredPrice, digits = 2)), minor_breaks = NULL) 
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time (in ms) for each centered price", subtitle = "Experiment 2")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5))
      + theme(axis.text.x=element_text(angle=90,hjust=1)))

mean(dataset$ActualPrice)
sd(dataset$ActualPrice)
range(dataset$ActualPrice)

# add new variable called 'ActualPrice2'
####

mean_rt$ActualPrice2 = (mean_rt$ActualPrice ^ 2)

# create models with and without the squared ActualPrice
####

linearmodel1 = lm(Mean ~ ActualPrice, data = mean_rt)
summary(linearmodel1)

linearmodel2 <-lm(Mean ~ ActualPrice + ActualPrice2, data = mean_rt)
summary(linearmodel2)

# plot the original data, and add the predictions made by the models
####

plot(mean_rt$ActualPrice, mean_rt$Mean, 
     pch=16, 
     main = "Fit between displayed price and reaction time",
     ylab = "Mean reaction time (in ms)", 
     xlab = "Displayed price (in euro)", 
     cex.lab = 1.3, 
     col = "black" )

predictions1 = predict(linearmodel1)
lines(mean_rt$ActualPrice, predictions1, lwd=3, col = "firebrick3")

predictions2 = predict(linearmodel2)
lines(mean_rt$ActualPrice, predictions2, lwd=3, col = "chartreuse4")

# add an extra legend to the data
####

axis(1, at = mean_rt$ActualPrice, labels = factor(mean_rt$ActualPrice))

legend(4.6, 805, legend=c("predicted by linear fit", "predicted by quadratic fit"),
       col=c("firebrick3", "chartreuse4"), lty=1:2, cex=0.8)

#--------------
# fit model 2
#--------------

# melt data accordingly
####

rt_difference_price = melt(dataset, id.vars = c("difference"), measure.vars = c("RT_in_ms"))  
diff_rt = cast(rt_difference_price,difference ~ ., mean)
colnames(diff_rt) = c("difference", "Mean")
summary(diff_rt)
head(diff_rt)

diff_rt$difference = as.numeric(as.character(diff_rt$difference))

plot(diff_rt$difference, diff_rt$Mean, pch=16, ylab = "reaction time (in ms)", 
     xlab = "difference scores", cex.lab = 1.3, col = "black" )

# show the tendency in the data
####

print(ggplot(diff_rt, aes(difference, Mean)) + geom_point() + geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Prices", breaks=diff_rt$ActualPrice,labels = as.factor(diff_rt$ActualPrice), minor_breaks = NULL) )

# add new variable called 'ActualPrice2'
####

diff_rt$difference2 = diff_rt$difference ^ 2

# create models with and without the squared ActualPrice
####

linearmodel1 = lm(Mean ~ difference, data = diff_rt)
summary(linearmodel1)

linearmodel2 <-lm(Mean ~ difference + difference2, data = diff_rt)
summary(linearmodel2)

# plot the original data, and add the predictions made by the models
####

plot(diff_rt$difference, diff_rt$Mean, 
     pch=16, 
     main = "Fit between the difference price and reaction time",
     ylab = "Mean reaction time (in ms)", 
     xlab = "Difference in euro (displayed - reference)", 
     cex.lab = 1.3, 
     col = "black" )

predictions1 = predict(linearmodel1)
points(diff_rt$difference, predictions1, lwd=3, col = "firebrick3")

predictions2 = predict(linearmodel2)
points(diff_rt$difference, predictions2, lwd=3, col = "chartreuse4")

# add an extra legend to the data
####

axis(1, at = diff_rt$difference, labels = factor(diff_rt$difference))

legend(1.2, 805, legend=c("predicted by linear fit", "predicted by quadratic fit"),
       col=c("firebrick3", "chartreuse4"), lty=1:2, cex=0.8)

#-------------
# ADDITIONAL 
#-------------

dataset$priceSquared = -(dataset$StandardisedPrice ^ 2)

head(dataset)

#----------
# lmer fits
#----------

# fit1 = lmer(RT_in_ms ~ (1|SubjectNr) 					, dataset); anova(fit1); summary(fit1) 
# In this model, a random intercept shared by participants is included, meaning that each participant's regression line
# goes up or down by a random amount. The mean of all the shifts across participants would be 0

# summary(fit1)
# Anova(fit1, type = "III", test.statistic = "F")

# INTERPRETATION
#
# This model keeps in mind the random variation between subjects

###

dataset$Prijs = relevel(dataset$Prijs, ref="price3" )

fit1 = lmer(RT_in_ms ~ (1|SubjectNr) 					, dataset, REML = F); anova(fit1); summary(fit1) 

fit2 = lmer(RT_in_ms ~ Prijs + (1|SubjectNr) 					, dataset, REML = F); anova(fit2); summary(fit2) 
coef(summary(fit2))

fit3 = lmer(RT_in_ms ~ Product + (1|SubjectNr) 					, dataset, REML = F); anova(fit3); summary(fit3) 
coef(summary(fit3))

fit4 = lmer(RT_in_ms ~ Prijs * Product + (1|SubjectNr) 					, dataset, REML = F); anova(fit4); summary(fit4) 
coef(summary(fit4))

fit5 = lmer(RT_in_ms ~ Prijs +
              (1|SubjectNr) + (1|Product)					, dataset, REML = F); anova(fit5); summary(fit5) 
coef(summary(fit5))
r.squaredGLMM(fit5)

# Plotting

tmp <- as.data.frame(confint(glht(fit5))$confint)
tmp$Comparison <- rownames(tmp)
tmp$Comparison = factor(tmp$Comparison, levels = tmp$Comparison[c(2,3,4,1,5,6,7)])
print(ggplot(tmp, aes(x = Comparison, y = Estimate, ymin = lwr, ymax = upr)) 
      + geom_errorbar() 
      + geom_point()
      + scale_x_discrete(name="Level names", labels = c('-70%', '-40%', '-10%', '+0% (reference level)', '+10%', '+40%', '+70%')) 
      + scale_y_continuous(name="Value of the estimates")
      + theme_bw()
      + labs(title = "Coefficient estimates for each (categorical) price level", subtitle = "Experiment 2")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5)))

# -- #

extreme_zero = dataset[c(dataset$Prijs=='price0'),]
extreme_six = dataset[c(dataset$Prijs=='price6'),]

round(mean(extreme_six$RT_in_ms))
round(sd(extreme_six$RT_in_ms))

test_phase = melt(extreme_zero, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
tester = cast(test_phase,SubjectNr ~ ., mean)
colnames(tester) = c("SubjectNr", "Mean")
summary(tester)
head(tester)

test_phase = melt(extreme_six, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
tester2 = cast(test_phase,SubjectNr ~ ., mean)
colnames(tester2) = c("SubjectNr", "Mean")
summary(tester2)
head(tester2)

t.test(tester$Mean, tester2$Mean, paired = TRUE, alternative = "less")

# -- #

fit6 = lmer(RT_in_ms ~ StandardisedPrice +
              (1|SubjectNr) + (1|Product)					, dataset, REML = F); anova(fit6); summary(fit6) 
coef(summary(fit6))

fit7 = lmer(RT_in_ms ~ StandardisedPrice + priceSquared +
              (1|SubjectNr) + (1|Product)					, dataset, REML = F); anova(fit7); summary(fit7) 
coef(summary(fit7))
r.squaredGLMM(fit7)

# -- comparing models -- #
anova(fit1, fit2)
# fit2 significantly better

anova(fit1, fit3)
# fit3 NOT significantly better

anova(fit1, fit4)
# fit4 significantly better

anova(fit2, fit4)
# fit4 significantly better

anova(fit4, fit5)
# fit5 significantly better

# -- model test -- #

anova(fit6, fit7)
# fit7 best fit

anova(fit5, fit7)
# fit7 best fit

#######
# END #
#######
