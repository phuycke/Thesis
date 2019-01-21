####
# Plot the data from experiment 2
# Data cleaning and editing script used in this script to plot
# First load "EXP2_1_clean.R", then plotting can be done
####

# load source file
####

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/EXP_2")
source("EXP2_1_clean.R")

# set working directory
####

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try")

#
##
#

# Plot mean reaction time in function of trial number (1) 
####

# tiff("exp2_ggplot_average_rt_trialnumber.tiff", width = 1360, height = 650)
print(ggplot(average_rt_trialnumber, aes(TrialNumber,Mean)) + geom_point() + geom_smooth(method = "loess", color = "red") 
      + scale_x_continuous(name="Trial number (larger = further in experiment)")  
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time per trial across participants", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5)))
# dev.off()

# Plot mean reaction time in function of trial number (2) 
####

# tiff("exp2_loess_average_rt_trialnumber.tiff", width = 1360, height = 650)
lw1 = loess(Mean ~ TrialNumber, data = average_rt_trialnumber, pch = 19)
plot(Mean ~ TrialNumber, data=average_rt_trialnumber,pch=19,cex = .5,type=c("p"), 
     main = "Mean reaction time per trial across participants", 
     xlab = "Trial number (larger = further in experiment)", ylab = "Mean reaction time (in ms)")
j = order(average_rt_trialnumber$TrialNumber)
lines(average_rt_trialnumber$TrialNumber[j],lw1$fitted[j],col="red",lwd=3)
# dev.off()

#
##
#

# Plot median in function of trial number (1)
####

# tiff("exp2_ggplot_median_rt_trialnumber.tiff", width = 1360, height = 650)
print(ggplot(median_rt_trialnumber, aes(TrialNumber,Median)) 
          + geom_point() 
          + geom_smooth(method = "loess", color = "red") 
          + scale_x_continuous(name="Trial number (larger = further in experiment)") 
          + scale_y_continuous(name="Median of reaction time (in ms)")
          + labs(title = "Median of reaction time per trial across participants", subtitle = "Experiment 1")
          + theme(plot.title = element_text(hjust = 0.5))
          + theme(plot.subtitle = element_text(hjust = 0.5)))
# dev.off()

# Plot median in function of trial number (2)
####

# tiff("exp2_loess_median_rt_trialnumber.tiff", width = 1360, height = 650)
lw1 = loess(Median ~ TrialNumber, data = median_rt_trialnumber, pch = 19)
plot(Median ~ TrialNumber, data=median_rt_trialnumber,pch=19,cex = .5,type=c("p"), main = "Median of reaction time per trial across participants", 
     xlab = "Trial number (larger = further in experiment)", ylab = "Median of reaction time (in ms)")
j = order(median_rt_trialnumber$TrialNumber)
lines(median_rt_trialnumber$TrialNumber[j],lw1$fitted[j],col="red",lwd=3)
# dev.off()

#
##
#

# Plot mean reaction time in function of subject number (1)
####

# tiff("exp2_ggplot_mean_rt_per_subject.tiff", width = 1360, height = 650)
average_rt_subject$SubjectNr = as.numeric(as.factor(average_rt_subject$SubjectNr))
print(ggplot(average_rt_subject, aes(SubjectNr,Mean)) + geom_point() + geom_smooth(method = "loess", color = "red") 
      + scale_x_continuous(name="Subject number", breaks=average_rt_subject$SubjectNr,labels = as.factor(average_rt_subject$SubjectNr), minor_breaks = NULL) 
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time for each subject (in ms)", subtitle = "Experiment 2")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5)))
# dev.off()

# Plot mean reaction time in function of subject number (2)
####

# tiff("exp2_loess_mean_rt_per_subject.tiff", width = 1360, height = 650)
lw1 = loess(Mean ~ SubjectNr, data = average_rt_subject, pch = 19)
plot(Mean ~ SubjectNr, data = average_rt_subject, col = "black", pch = 19,cex=1, type=c("p"), xlab = "Subject number", 
     ylab = "Mean reaction time (in ms)", main = "Mean reaction time for each subject (in ms)", ylim = c(200,1100))
j = order(average_rt_subject$SubjectNr)
lines(average_rt_subject$SubjectNr[j],lw1$fitted[j],col="red",lwd=3)
# dev.off()

#
##
#

# Plot mean reaction time in function of the displayed price (catergory) (1)
####

# tiff("exp2_ggplot_mean_rt_per_price_categorical.tiff", width = 1360, height = 650)
print(ggplot(average_rt_prijs, aes(Prijs,Mean)) + geom_point(color = "black", cex=2)
      + scale_x_discrete(name="Price category (left = cheap / right = expensive)") 
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time in function of price category", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5))
      + expand_limits(y=c(600, 850)))
# dev.off()

# Plot mean reaction time in function of the displayed price (catergory) (2)
####

# tiff("exp2_xyplot_mean_rt_per_price_categorical.tiff", width = 1360, height = 650)
print(xyplot(Mean ~ Prijs, data = average_rt_prijs, col = "black", pch = 19, type=c("g","p"), xlab = "Price category (left = cheap / right = expensive)", 
             ylab = "Mean reaction time (in ms)", main = "Mean reaction time in function of price category", 
             ylim = c(600,850), auto.key=list(corner=c(0.1,0.9),lines=T)))
# dev.off()

#
##
#

# Plot mean reaction time in function of the block number (1)
####

# tiff("exp2_ggplot_mean_rt_per_blocknumber.tiff", width = 1360, height = 650)
ggplot(average_blockrt_blocknr, aes(BlockNumber,Mean)) + geom_point(cex = 2)
# dev.off()

# Plot mean reaction time in function of the block number (2)
####

# tiff("exp2_xyplot_mean_rt_per_blocknumber.tiff", width = 1360, height = 650)
print(xyplot(Mean ~ BlockNumber, data = average_blockrt_blocknr, col = "black", pch = 19, type=c("g","p"), xlab = "Block number", 
             ylab = "Mean block reaction time (in ms)", main = "Mean reaction time for each consecutive block", 
             auto.key=list(corner=c(0.1,0.9),lines=T)))
# dev.off()

#
##
#

# Plot latency 
####

# tiff("exp2_barplot_overview_of_latency.tiff", width = 900, height = 450)
dataset$TooLate[dataset$TooLate == 0] = 'in time'
dataset$TooLate[dataset$TooLate == 1] = 'too late'
numbers = table(dataset$TooLate)
text(barplot(numbers, main = "overview of latency across participants", ylab = "number of times pressed (across participants)", 
             col = c("cyan3","brown2"), ylim = c(0,12000)), as.vector(numbers), labels = as.vector(numbers), pos = 3)
legend("topright", c("answered in time", "answered too late"), col = c("cyan3","brown2"), lwd=10)
# dev.off()

#
##
#

# Plot times each response key was used (across entire experiment)
####

# tiff("exp2_barplot_overview_of_pressed_keys.tiff", width = 900, height = 450)
numbers = table(dataset$Key)[1:2]
text(barplot(numbers, main = "overview of key responses across participants", ylab = "number of times pressed (across participants)", 
             col = c("deepskyblue","darkorchid"), ylim = c(0,11760)), as.vector(numbers), labels = as.vector(numbers), pos = 3)
legend("topright", c("Left key pressed ('It's cheap!')", "Right key pressed ('It's expensive!')"), col = c("deepskyblue","darkorchid"), lwd=10)
# dev.off()

#
##
#

# Plot responses in function of the price
####

# tiff("exp2_barplot_price_pressed_keys_interaction.tiff", width = 1360, height = 650)
key_price = xtabs(~Prijs + Key,dataset)
key_price = matrix(key_price, nrow = 8, ncol = 3)
key_price = data.frame(key_price)
key_price$X3 = NULL
key_price = key_price[1:7,]
colnames(key_price) = c('left','right')
barplot(t(as.matrix(key_price)), main = "key presses in function of price", ylab = "number of times pressed (across participants)",
        xlab = "price label (low = low price / high = high price)", col = c("lightgreen","red"), ylim = c(0,1800), beside=TRUE)
legend("topright", c("Left key pressed ('It's cheap!')", "Right key pressed ('It's expensive!')"), col = c("lightgreen","red"), lwd=10)
# dev.off()

#
##
#

#########################
## SUBJECT INTERACTION ##
#########################

# Plot mean reaction times in function of the displayed prices (across subjects)
####

print(xyplot(Mean ~ SubjectNr, data = average_rt_subject_prijs, groups = Prijs, pch = 19, type = c("g","l"), xlab = "Subject number", ylab = "Mean reaction time during learning phase (in ms)", 
             main = "Reaction time in function of number of answer options", scales = "free", auto.key=list(cex = .85, corner=c(.98,.98))))

## ggplot(average_rt_subject_prijs, aes(SubjectNr,Mean)) + geom_point()

#
##
#

# Calculate difference in mean reaction time between the cheapest and the most expensive price (price in categories)
####

average_rt_subject_product_zero = average_rt_subject_product[average_rt_subject_product$Product == "product0", ]
average_rt_subject_product_seven = average_rt_subject_product[average_rt_subject_product$Product == "product7", ]

difference_expensive_cheap = data.frame(average_rt_subject_product_seven$Mean - average_rt_subject_product_zero$Mean)
difference_expensive_cheap$SubjectNr = c(36:70)
colnames(difference_expensive_cheap) = c('difference_score','SubjectNr')
print(difference_expensive_cheap)

#
##
#

# Plot the difference in mean reaction time between cheapest and most expensive product (across subjects) (1)
####

# tiff("exp2_ggplot_difference_score_rt_extremes.tiff", width = 1360, height = 650)
difference_expensive_cheap$SubjectNr = as.numeric(as.factor(difference_expensive_cheap$SubjectNr))
difference_expensive_cheap$difference_score = as.numeric(as.factor(difference_expensive_cheap$difference_score))
print(ggplot(difference_expensive_cheap, aes(SubjectNr,difference_score)) + geom_point(color = "black", cex=2) +geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="subject number",  breaks=difference_expensive_cheap$SubjectNr,labels = as.factor(difference_expensive_cheap$SubjectNr), minor_breaks = NULL) 
      + scale_y_continuous(name="Difference score (in ms)")
      + labs(title = "Difference between mean reaction times considering extreme prices", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5))
      + expand_limits(y=c(-20, 50)))
# dev.off()

# Plot the difference in mean reaction time between cheapest and most expensive product (across subjects) (2)
####

# tiff("exp2_loess_difference_score_rt_extremes.tiff", width = 1360, height = 650)
lw1 = loess(difference_score ~ SubjectNr, data = difference_expensive_cheap, pch = 19)
plot(difference_score ~ SubjectNr, data = difference_expensive_cheap, pch = 19, type = c("p"), col = "black", xlab = "subject number", ylab = "Difference score (in ms)", 
     main = "Difference between mean reaction times considering extreme prices", ylim = c(-20,50))
j = order(average_rt_subject$SubjectNr)
lines(average_rt_subject$SubjectNr[j],lw1$fitted[j],col="red",lwd=3)
# dev.off()

#
##
#

# Plot mean reaction time per price category (across subjects)
####

print(xyplot(Mean ~ Prijs, data = average_rt_subject_prijs, groups = SubjectNr, pch = 19, type = c("g","l"), xlab = "Subject number", ylab = "Mean reaction time during learning phase (in ms)", 
             main = "Reaction time in function of number of answer options", scales = "free"))

## ggplot(average_rt_subject_prijs, aes(Prijs,Mean)) + geom_point()

#
##
#

# Plot mean reaction time in function of displayed price (across subjects)
####

print(xyplot(Mean ~ SubjectNr, data = average_rt_subject_product, groups = Product, pch = 19, type = c("g","l"), xlab = "Subject number", ylab = "Mean reaction time during learning phase (in ms)", 
             main = "Reaction time in function of number of answer options", scales = "free", auto.key=list(cex = .85, corner=c(.98,.98))))

## ggplot(average_rt_subject_product, aes(SubjectNr,Mean)) + geom_point()

############################
## SUBJECT SPECIFIC PLOTS ##
############################

#
##
#

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try/mean_rt_price_plots2")

for (i in 36:70){
  needed_subset = average_rt_subject_prijs[average_rt_subject_prijs$SubjectNr == i, ]
  # tiff(sprintf("mean_rt_price_subject_%i.tiff", i), width = 1360, height = 650)
  print(xyplot(Mean ~ Prijs, data = needed_subset, pch = 19, type = c("g","l","p"), col = "black", xlab = "price label (left = cheap / right = expensive)", ylab = "mean reaction time (in ms)", 
               main = sprintf("reaction time in function of price categories for participant %i", i), scales = "free"))
  # dev.off()
}

#
##
#

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try/rt_trialnumber_subject2/loess_fit")

for (i in 36:70){
  needed_subset = dataset[dataset$SubjectNr == i, ]
  # tiff(sprintf("rt_trialnumber_subject_%i.tiff", i), width = 1360, height = 650)
  lw1 = loess(RT_in_ms ~ TrialNumber, data = needed_subset, pch = 19)
  plot(RT_in_ms ~ TrialNumber, data=needed_subset,pch=19,cex = 1,type=c("p"), main = sprintf("Reaction time in function of trial number for subject %i", i),
       xlab = "Trial number (larger = further in experiment)", ylab = "Reaction time (in ms)")
  j = order(needed_subset$TrialNumber)
  lines(needed_subset$TrialNumber[j],lw1$fitted[j],col="red",lwd=3)
  # dev.off()
}

#
##
#

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try/rt_trialnumber_subject2/ggplot_loess_fit")

for (i in 36:70){
  needed_subset = dataset[dataset$SubjectNr == i, ]
  # tiff(sprintf("ggplot_rt_trialnumber_subject_%i.tiff", i), width = 1360, height = 650)
  print(ggplot(needed_subset, aes(TrialNumber,RT_in_ms)) + geom_point(color = "black", cex=1.5) + geom_smooth(method = "loess", color = "red")
        + scale_x_continuous(name="Trial number (larger = further in experiment)") 
        + scale_y_continuous(name="Reaction time (in ms)")
        + labs(title = sprintf("Reaction time in function of trial number for subject %i", i), subtitle = "Experiment 1")
        + theme(plot.title = element_text(hjust = 0.5))
        + theme(plot.subtitle = element_text(hjust = 0.5)))
  # dev.off()
}

#
##
#

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try")

# Plot mean reaction time for the real price (numerical)
####

# tiff("exp2_ggplot_mean_rt_actual_prices.tiff", width = 1600, height = 850)
print(ggplot(average_rt_actual, aes(ActualPrice,Mean)) + geom_point(color = "black", cex=2) + geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Displayed product price", breaks=dataset$ActualPrice,labels = as.factor(dataset$ActualPrice), minor_breaks = NULL)
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time for different displayed prices across participants (in ms)", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5), 
              plot.subtitle = element_text(hjust = 0.5), 
              axis.text.x = element_text(angle = 90, vjust = 0.5, size = 9, hjust = 1),
              plot.background = element_rect(fill = "white")))
# dev.off()

#
##
#

# Plot median reaction time for the real price (numerical)
####

# tiff("exp2_ggplot_median_rt_actual_prices.tiff", width = 1600, height = 850)
print(ggplot(median_rt_actual, aes(ActualPrice,Median)) + geom_point(color = "black", cex=2) + geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Displayed product price", breaks=dataset$ActualPrice,labels = as.factor(dataset$ActualPrice), minor_breaks = NULL)
      + scale_y_continuous(name="Median reaction time (in ms)")
      + labs(title = "Median reaction time for different displayed prices across participants (in ms)", subtitle = "Experiment 2")
      + theme(plot.title = element_text(hjust = 0.5), 
              plot.subtitle = element_text(hjust = 0.5), 
              axis.text.x = element_text(angle = 90, vjust = 0.5, size = 9, hjust = 1),
              plot.background = element_rect(fill = "white")))
# dev.off()

#
##
#

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try")

# Melt mean reaction time for the real (numerical) price
####

rt_label = melt(dataset, id.vars = c("Label"), measure.vars = c("RT_in_ms"))  
average_rt_label = cast(rt_label, Label ~ ., mean)
colnames(average_rt_label) = c("Label", "Mean")
summary(average_rt_label)

# tiff("exp2_barchart_mean_rt_label.tiff", width = 1300, height = 650)
numbers = c(719.9413, 775.3954, 715.8764)
label = c("cheap", "reference", "expensive")
text(barplot(numbers, main = "Distribution of mean reaction time for each label", ylab = "Mean reaction time (in ms)", 
             col = c('mediumspringgreen', 'lightsteelblue1', 'tomato'), ylim = c(0,850), names.arg=label), as.vector(numbers), labels = as.vector(numbers), pos = 3)
# dev.off()

#
##
#

# Melt median reaction time for the real (numerical) price
####

rt_label = melt(dataset, id.vars = c("Label"), measure.vars = c("RT_in_ms"))  
median_rt_label = cast(rt_label, Label ~ ., median)
colnames(median_rt_label) = c("Label", "Median")
summary(median_rt_label)

# tiff("exp2_barchart_median_rt_label.tiff", width = 1300, height = 650)
numbers = c(624, 671, 624)
label = c("cheap", "reference", "expensive")
text(barplot(numbers, main = "Distribution of median reaction time for each label", ylab = "Median reaction time (in ms)", 
             col = c('mediumspringgreen', 'lightsteelblue1', 'tomato'), ylim = c(0,700), names.arg=label), as.vector(numbers), labels = as.vector(numbers), pos = 3)
# dev.off()

#########
## END ##
#########
