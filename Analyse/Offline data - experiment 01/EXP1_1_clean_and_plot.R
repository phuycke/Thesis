setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis/Data_Thesis_EXP1")

data = read.table("Data_Thesis_EXP1_All.txt", fill = T, header = F, sep = "\t",  na.strings = "")
  nameRow = data[1,  ]
  print(nameRow)
  numRow = dim(data)[1]
  numRow = as.numeric(numRow)
  data = data[2:numRow,  ]

dataset = data.frame(data, row.names = NULL)
dataset$V1 = NULL
columnNames = c("BlockNumber","SubjectNr","Product","Prijs","Key","RT_in_ms","BlockRT","TooLate")
colnames(dataset) = columnNames
print(dataset)

## start exploring data ##
xtabs(~SubjectNr,   dataset)
xtabs(~BlockNumber, dataset)
xtabs(~Product,	    dataset) 
xtabs(~Prijs, 	    dataset)
xtabs(~Key,	        dataset)
xtabs(~RT_in_ms,    dataset)
xtabs(~BlockRT,     dataset) 
xtabs(~TooLate,     dataset)  

## deeper exploration
xtabs(~SubjectNr + Key,     dataset)
xtabs(~SubjectNr + TooLate, dataset)
xtabs(~Product + Prijs,     dataset)
xtabs(~Product + Key,       dataset)
xtabs(~Prijs + Key,         dataset)
xtabs(~Product + Key,       dataset)
xtabs(~Product + TooLate,   dataset)
xtabs(~Prijs + TooLate,     dataset)

head(dataset)
tail(dataset)

## Reshapen en melten van de data ##         
library(car)
library(reshape)
library(lattice)
library(ggplot2)

print(class(dataset$RT_in_ms))
print(class(dataset$BlockRT))
print(class(dataset$TooLate))

oefenblocks = dataset[dataset$BlockRT == 'oefenblok', ]
head(oefenblocks)
tail(oefenblocks)

dataset = dataset[!(dataset$BlockRT == 'oefenblok'), ]

trialnumbers = c(1:329)
allTrialnumbers = rep(trialnumbers, times = 35)
dataset$TrialNumber = allTrialnumbers

dataset <- dataset[c("SubjectNr","BlockNumber","Product","Prijs","Key","RT_in_ms","BlockRT","TooLate","TrialNumber")]
dataset <- dataset[,c("SubjectNr","TrialNumber","BlockNumber","Product","Prijs","Key","RT_in_ms","BlockRT","TooLate")]

head(dataset)
tail(dataset)

dataset$TrialNumber = as.numeric(as.character(dataset$TrialNumber))
dataset$RT_in_ms = as.numeric(as.character(dataset$RT_in_ms))
dataset$BlockRT = as.numeric(as.character(dataset$BlockRT))
dataset$TooLate = as.numeric(as.character(dataset$TooLate))

print(class(dataset$TrialNumber))
print(class(dataset$RT_in_ms))
print(class(dataset$BlockRT))
print(class(dataset$TooLate))

## Gemiddelde reactietijd in de eerste phase ##
print(mean(dataset$RT_in_ms))
  # 554.0585

## variantie en standaardfout in eerste fase ##
print(var(dataset$RT_in_ms))
  # 148414
print(sd(dataset$RT_in_ms))
  # 385.2454

## ONE VARIABLE ##

## Melt reactietijd per subject ##
rt_subject = melt(dataset, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
average_rt_subject = cast(rt_subject, SubjectNr ~ ., mean)
colnames(average_rt_subject) = c("SubjectNr", "Mean")
summary(average_rt_subject)

## Melt standaarddeviatie per subject ##
rt_subject = melt(dataset, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
sd_rt_subject = cast(rt_subject, SubjectNr ~ ., sd)
colnames(sd_rt_subject) = c("SubjectNr", "SD")
summary(sd_rt_subject)


for (i in 1:dim(dataset)[1]){
  
  specific_mean = average_rt_subject[average_rt_subject$SubjectNr == dataset$SubjectNr[i],]
  specific_sd = sd_rt_subject[sd_rt_subject$SubjectNr == dataset$SubjectNr[i],]
  
  needed_mean = specific_mean$Mean
  needed_sd = specific_sd$SD
  
  specific_threshold = needed_mean + 3*needed_sd
  
  if (dataset$RT_in_ms[i] > specific_threshold){
    dataset$RT_in_ms[i] = 1000000000
  }
  if (dataset$RT_in_ms[i] < 200){
    dataset$RT_in_ms[i] = 1000000000
  }
}

cleaned_data = dataset[dataset$RT_in_ms != 1000000000, ]

rows_original = dim(dataset)[1]
rows_cleaned = dim(cleaned_data)[1]

rows_deleted = rows_original - rows_cleaned
rows_deleted_percentage = (rows_deleted / rows_original) * 100

cat("Number of entries that were deleted:", rows_deleted)
cat("In percentages, this corresponds to", rows_deleted_percentage, "% of the rows deleted")

dataset = cleaned_data

###############
## NEW START ##
###############

## Melt reactietijd per subject ##
rt_subject = melt(dataset, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
average_rt_subject = cast(rt_subject, SubjectNr ~ ., mean)
colnames(average_rt_subject) = c("SubjectNr", "Mean")
summary(average_rt_subject)

## Melt standaarddeviatie per subject ##
rt_subject = melt(dataset, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
sd_rt_subject = cast(rt_subject, SubjectNr ~ ., sd)
colnames(sd_rt_subject) = c("SubjectNr", "SD")
summary(sd_rt_subject)

## Melt reactietijd per trialnumber (MEAN)##
rt_trialnumber = melt(dataset, id.vars = c("TrialNumber"), measure.vars = c("RT_in_ms"))  
average_rt_trialnumber = cast(rt_trialnumber, TrialNumber ~ ., mean)
colnames(average_rt_trialnumber) = c("TrialNumber", "Mean")
summary(average_rt_trialnumber)

## Melt reactietijd per trialnumber (MEDIAN)##
rt2_trialnumber = melt(dataset, id.vars = c("TrialNumber"), measure.vars = c("RT_in_ms"))  
median_rt_trialnumber = cast(rt2_trialnumber, TrialNumber ~ ., median)
colnames(median_rt_trialnumber) = c("TrialNumber", "Median")
summary(median_rt_trialnumber)

## Melt reactietijd per product ##
rt_product = melt(dataset, id.vars = c("Product"), measure.vars = c("RT_in_ms"))  
average_rt_product = cast(rt_product, Product ~ ., mean)
colnames(average_rt_product) = c("Product", "Mean")
summary(average_rt_product)

## Melt reactietijd per prijs ##
rt_prijs = melt(dataset, id.vars = c("Prijs"), measure.vars = c("RT_in_ms"))  
average_rt_prijs = cast(rt_prijs, Prijs ~ ., mean)
colnames(average_rt_prijs) = c("Prijs", "Mean")
summary(average_rt_prijs)

## Melt reactietijd per toets ##
rt_key = melt(dataset, id.vars = c("Key"), measure.vars = c("RT_in_ms"))  
average_rt_key = cast(rt_key, Key ~ ., mean)
colnames(average_rt_key) = c("Key", "Mean")
summary(average_rt_key)

## Melt reactietijd & laatheid ##
dataset$TooLate = as.factor(dataset$TooLate)
rt_late = melt(dataset, id.vars = c("TooLate"), measure.vars = c("RT_in_ms"))  
average_rt_late = cast(rt_late, TooLate ~ ., mean)
colnames(average_rt_late) = c("TooLate", "Mean")
summary(average_rt_late)

## Melt toets & laatheid ##
dataset$TooLate = as.numeric(as.character(dataset$TooLate))
key_late = melt(dataset, id.vars = c("Key"), measure.vars = c("TooLate"))  
average_key_late = cast(key_late, Key ~ ., mean)
colnames(average_key_late) = c("Key", "Mean")
summary(average_key_late)

## Melt block RT per block ##
blockrt_blocknr = melt(dataset, id.vars = c("BlockNumber"), measure.vars = c("BlockRT"))  
average_blockrt_blocknr = cast(blockrt_blocknr, BlockNumber ~ ., mean)
colnames(average_blockrt_blocknr) = c("BlockNumber", "Mean")
summary(average_blockrt_blocknr)

## SUBJECT INTERACTION ##

## Melt reactietijd per product voor ieder subject ##
rt_subject_product = melt(dataset, id.vars = c("SubjectNr", "Product"), measure.vars = c("RT_in_ms"))  
average_rt_subject_product = cast(rt_subject_product, SubjectNr + Product ~ ., mean)
colnames(average_rt_subject_product) = c("SubjectNr", "Product", "Mean")
summary(average_rt_subject_product)

## Melt reactietijd per prijs voor ieder subject ##
rt_subject_prijs = melt(dataset, id.vars = c("SubjectNr", "Prijs"), measure.vars = c("RT_in_ms"))  
average_rt_subject_prijs = cast(rt_subject_prijs, SubjectNr + Prijs ~ ., mean)
colnames(average_rt_subject_prijs) = c("SubjectNr", "Prijs", "Mean")
summary(average_rt_subject_prijs)

## Melt reactietijd per toets voor ieder subject ##
rt_subject_key = melt(dataset, id.vars = c("SubjectNr", "Key"), measure.vars = c("RT_in_ms"))  
average_rt_subject_key = cast(rt_subject_key, SubjectNr + Key ~ ., mean)
colnames(average_rt_subject_key) = c("SubjectNr", "Key", "Mean")
summary(average_rt_subject_key)

## Melt reactietijd & laatheid voor ieder subject ##
dataset$TooLate = as.numeric(as.character(dataset$TooLate))
rt_subject_late = melt(dataset, id.vars = c("SubjectNr", "TooLate"), measure.vars = c("RT_in_ms"))  
average_rt_subject_late = cast(rt_subject_late, SubjectNr + TooLate ~ ., mean)
colnames(average_rt_subject_late) = c("SubjectNr", "TooLate", "Mean")
summary(average_rt_subject_late)

## Melt toets & laatheid voor ieder subject ##
dataset$TooLate = as.numeric(as.character(dataset$TooLate))
key_subject_late = melt(dataset, id.vars = c("SubjectNr", "Key"), measure.vars = c("TooLate"))  
average_key_subject_late = cast(key_subject_late, SubjectNr + Key ~ ., mean)
colnames(average_key_subject_late) = c("SubjectNr", "Key", "Mean")
summary(average_key_subject_late)

## Melt block RT per block voor ieder subject ##
blockrt_subject_blocknr = melt(dataset, id.vars = c("SubjectNr", "BlockNumber"), measure.vars = c("BlockRT"))  
average_blockrt_subject_blocknr = cast(blockrt_subject_blocknr, SubjectNr + BlockNumber ~ ., mean)
colnames(average_blockrt_subject_blocknr) = c("SubjectNr", "BlockNumber", "Mean")
summary(average_blockrt_subject_blocknr)

## look at the mean reaction time across different products
  # Do we see the same interaction between price and products as we see generally speaking?
test = melt(dataset, id.vars = c("Product", "Prijs"), measure.vars = c("RT_in_ms"))  
retest = cast(test, Product + Prijs ~ ., mean)
colnames(retest) = c("Product", "Prijs", "Mean")
summary(retest)
head(retest)

firstnums = seq(1, 55, by = 7)
lastnums = seq(7, 56, by = 7)

par(mfrow =c(2, 4))
for (i in 1:8){
    x_axis = (1:7)
    y_axis = retest$Mean[firstnums[i]:lastnums[i]]
    plot(x_axis, y_axis, pch=19,cex = 1, type=c("b"), main = sprintf("Plot created for product %i", i), 
         xlab = "Price (lowest = cheapest)", ylab = "Mean reaction time (in ms)", ylim = c(450, 620))
}

#########
# Plots #
#########

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try")

# If the error
# Error in .Call.graphics(C_palette2, .Call(C_palette2, NULL)) : 
# invalid graphics state
# appears, run '# dev.off()', and you can plot again. 

## Plotten van de gemiddelde reactietijd in functie van het trialnummer ##
# tiff("exp1_ggplot_average_rt_trialnumber.tiff", width = 1360, height = 650)
print(ggplot(average_rt_trialnumber, aes(TrialNumber,Mean)) + geom_point() + geom_smooth(method = "loess", color = "red") 
      + scale_x_continuous(name="Trial number (larger = further in experiment)")  
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time per trial across participants", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5)))
# dev.off()

## Plotten van de gemiddelde reactietijd in functie van het trialnummer ##
# tiff("exp1_loess_average_rt_trialnumber.tiff", width = 1360, height = 650)
lw1 = loess(Mean ~ TrialNumber, data = average_rt_trialnumber, pch = 19)
plot(Mean ~ TrialNumber, data=average_rt_trialnumber,pch=19,cex = 1,type=c("p"), main = "Mean reaction time per trial across participants", 
     xlab = "Trial number (larger = further in experiment)", ylab = "Mean reaction time (in ms)")
j = order(average_rt_trialnumber$TrialNumber)
lines(average_rt_trialnumber$TrialNumber[j],lw1$fitted[j],col="red",lwd=3)
# dev.off()

## Plotten van de mediaan van de reactietijd in functie van het trialnummer  ##
# tiff("exp1_ggplot_median_rt_trialnumber.tiff", width = 1360, height = 650)
print(ggplot(median_rt_trialnumber, aes(TrialNumber,Median)) + geom_point() + geom_smooth(method = "loess", color = "red") 
      + scale_x_continuous(name="Trial number (larger = further in experiment)") 
      + scale_y_continuous(name="Median of reaction time (in ms)")
      + labs(title = "Median of reaction time per trial across participants", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5)))
# dev.off()

## Plotten van de gemiddelde reactietijd in functie van het trialnummer ##
# tiff("exp1_loess_median_rt_trialnumber.tiff", width = 1360, height = 650)
lw1 = loess(Median ~ TrialNumber, data = median_rt_trialnumber, pch = 19)
plot(Median ~ TrialNumber, data=median_rt_trialnumber,pch=19,cex = 1,type=c("p"), main = "Median of reaction time per trial across participants", 
     xlab = "Trial number (larger = further in experiment)", ylab = "Median of reaction time (in ms)")
j = order(median_rt_trialnumber$TrialNumber)
lines(median_rt_trialnumber$TrialNumber[j],lw1$fitted[j],col="red",lwd=3)
# dev.off()

## Plotten van de gemiddelde reactietijd in functie van het subject nummer ##
# tiff("exp1_ggplot_mean_rt_per_subject.tiff", width = 1360, height = 650)
average_rt_subject$SubjectNr = as.numeric(as.factor(average_rt_subject$SubjectNr))
print(ggplot(average_rt_subject, aes(SubjectNr,Mean)) + geom_point() + geom_smooth(method = "loess", color = "red") 
      + scale_x_continuous(name="Subject number", breaks=average_rt_subject$SubjectNr,labels = as.factor(average_rt_subject$SubjectNr), minor_breaks = NULL) 
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time for each subject (in ms)", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5)))
# dev.off()

# tiff("exp1_loess_mean_rt_per_subject.tiff", width = 1360, height = 650)
lw1 = loess(Mean ~ SubjectNr, data = average_rt_subject, pch = 19)
plot(Mean ~ SubjectNr, data = average_rt_subject, col = "black", pch = 19,cex=1, type=c("p"), xlab = "Subject number", 
     ylab = "Mean reaction time (in ms)", main = "Mean reaction time for each subject (in ms)", ylim = c(200,1100))
j = order(average_rt_subject$SubjectNr)
lines(average_rt_subject$SubjectNr[j],lw1$fitted[j],col="red",lwd=3)
# dev.off()

## Plotten van de gemiddelde reactietijd in functie van de getoonde prijs  ##
# tiff("exp1_ggplot_mean_rt_per_price_categorical.tiff", width = 1360, height = 650)
print(ggplot(average_rt_prijs, aes(Prijs,Mean)) + geom_point(color = "black", cex=2)
      + scale_x_discrete(name="Price category (left = cheap / right = expensive)") 
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time in function of price category", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5))
      + expand_limits(y=c(450, 600)))
# dev.off()

# tiff("exp1_xyplot_mean_rt_per_price_categorical.tiff", width = 1360, height = 650)
print(xyplot(Mean ~ Prijs, data = average_rt_prijs, col = "black", pch = 19, type=c("g","p"), xlab = "Price category (left = cheap / right = expensive)", 
             ylab = "Mean reaction time (in ms)", main = "Mean reaction time in function of price category", 
             ylim = c(500,625), auto.key=list(corner=c(0.1,0.9),lines=T)))
# dev.off()

## Plotten van de gemiddelde block RT in functie van het block nr  ##
# tiff("exp1_ggplot_mean_rt_per_blocknumber.tiff", width = 1360, height = 650)
ggplot(average_blockrt_blocknr, aes(BlockNumber,Mean)) + geom_point(cex = 2)
# dev.off()

# tiff("exp1_xyplot_mean_rt_per_blocknumber.tiff", width = 1360, height = 650)
print(xyplot(Mean ~ BlockNumber, data = average_blockrt_blocknr, col = "black", pch = 19, type=c("g","p"), xlab = "Block number", 
             ylab = "Mean block reaction time (in ms)", main = "Mean reaction time for each consecutive block", 
             auto.key=list(corner=c(0.1,0.9),lines=T)))
# dev.off()

## Plotten van de traagheid  ##
# tiff("exp1_barplot_overview_of_latency.tiff", width = 900, height = 450)
dataset$TooLate[dataset$TooLate == 0] = 'in time'
dataset$TooLate[dataset$TooLate == 1] = 'too late'
numbers = table(dataset$TooLate)
text(barplot(numbers, main = "overview of latency across participants", ylab = "number of times pressed (across participants)", 
             col = c("cyan3","brown2"), ylim = c(0,11760)), as.vector(numbers), labels = as.vector(numbers), pos = 3)
legend("topright", c("answered in time", "answered too late"), col = c("cyan3","brown2"), lwd=10)
# dev.off()

## Plotten van de responses  ##
# tiff("exp1_barplot_overview_of_pressed_keys.tiff", width = 900, height = 450)
numbers = table(dataset$Key)[1:2]
text(barplot(numbers, main = "overview of key responses across participants", ylab = "number of times pressed (across participants)", 
             col = c("deepskyblue","darkorchid"), ylim = c(0,11760)), as.vector(numbers), labels = as.vector(numbers), pos = 3)
legend("topright", c("Left key pressed ('It's cheap!')", "Right key pressed ('It's expensive!')"), col = c("deepskyblue","darkorchid"), lwd=10)
# dev.off()

# Plotten van de responses in functie van de prijs  #
# tiff("exp1_barplot_price_pressed_keys_interaction.tiff", width = 1360, height = 650)
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

## SUBJECT INTERACTION ##

## Plotten van de gemiddelde reactietijd in functie van de getoonde prijs (over subjecten heen) ##
print(xyplot(Mean ~ SubjectNr, data = average_rt_subject_prijs, groups = Prijs, pch = 19, type = c("g","l"), xlab = "Subject number", ylab = "Mean reaction time during learning phase (in ms)", 
             main = "Reaction time in function of number of answer options", scales = "free", auto.key=list(cex = .85, corner=c(.98,.98))))

## ggplot(average_rt_subject_prijs, aes(SubjectNr,Mean)) + geom_point()

## Bereken het verschil in gemiddelde reactietijd tussen de duurste prijs en de meest goedkope prijs ##
average_rt_subject_product_zero = average_rt_subject_product[average_rt_subject_product$Product == "product0", ]
average_rt_subject_product_seven = average_rt_subject_product[average_rt_subject_product$Product == "product7", ]

difference_expensive_cheap = data.frame(c(1:35), average_rt_subject_product_seven$Mean - average_rt_subject_product_zero$Mean)
colnames(difference_expensive_cheap) = c('SubjectNr', 'difference_score')
print(difference_expensive_cheap)

## Plot het verschil in gemiddelde reactietijd tussen duurste en meest goedkope prijs per subject ##
# tiff("exp1_ggplot_difference_score_rt_extremes.tiff", width = 1360, height = 650)
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

# tiff("exp1_loess_difference_score_rt_extremes.tiff", width = 1360, height = 650)
lw1 = loess(difference_score ~ SubjectNr, data = difference_expensive_cheap, pch = 19)
plot(difference_score ~ SubjectNr, data = difference_expensive_cheap, pch = 19, type = c("p"), col = "black", xlab = "subject number", ylab = "Difference score (in ms)", 
     main = "Difference between mean reaction times considering extreme prices", ylim = c(-20,50))
j = order(average_rt_subject$SubjectNr)
lines(average_rt_subject$SubjectNr[j],lw1$fitted[j],col="red",lwd=3)
# dev.off()

## Plot van de gemiddelde reactietijd per prijscategorie over subjecten heen ##
print(xyplot(Mean ~ Prijs, data = average_rt_subject_prijs, groups = SubjectNr, pch = 19, type = c("g","l"), xlab = "Subject number", ylab = "Mean reaction time during learning phase (in ms)", 
             main = "Reaction time in function of number of answer options", scales = "free"))

## ggplot(average_rt_subject_prijs, aes(Prijs,Mean)) + geom_point()

## Plotten van de gemiddelde reactietijd in functie van het getoonde product (over subjecten heen) ##
print(xyplot(Mean ~ SubjectNr, data = average_rt_subject_product, groups = Product, pch = 19, type = c("g","l"), xlab = "Subject number", ylab = "Mean reaction time during learning phase (in ms)", 
             main = "Reaction time in function of number of answer options", scales = "free", auto.key=list(cex = .85, corner=c(.98,.98))))

## ggplot(average_rt_subject_product, aes(SubjectNr,Mean)) + geom_point()

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try/mean_rt_price_plots")

for (i in 1:35){
  needed_subset = average_rt_subject_prijs[average_rt_subject_prijs$SubjectNr == i, ]
  # tiff(sprintf("mean_rt_price_subject_%i.tiff", i), width = 1360, height = 650)
  print(xyplot(Mean ~ Prijs, data = needed_subset, pch = 19, type = c("g","l","p"), col = "black", xlab = "price label (left = cheap / right = expensive)", ylab = "mean reaction time (in ms)", 
               main = "reaction time in function of price categories", scales = "free"))
  # dev.off()
}

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try/rt_trialnumber_subject/loess_fit")

for (i in 1:35){
  needed_subset = dataset[dataset$SubjectNr == i, ]
  # tiff(sprintf("rt_trialnumber_subject_%i.tiff", i), width = 1360, height = 650)
  lw1 = loess(RT_in_ms ~ TrialNumber, data = needed_subset, pch = 19)
  plot(RT_in_ms ~ TrialNumber, data=needed_subset,pch=19,cex = 1,type=c("p"), main = sprintf("Reaction time in function of trial number for subject %i", i),
       xlab = "Trial number (larger = further in experiment)", ylab = "Reaction time (in ms)")
  j = order(needed_subset$TrialNumber)
  lines(needed_subset$TrialNumber[j],lw1$fitted[j],col="red",lwd=3)
  # dev.off()
}

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try/rt_trialnumber_subject/ggplot_loess_fit")

for (i in 1:35){
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

## Alter original dataset ##
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

dataset$ActualPrice = rep(c(''), times = dim(dataset)[1])

for (i in 1:dim(dataset)[1]){
  ProductIndex = as.numeric(as.character(substr(dataset$Product[i],8,8)))
  PriceIndex = as.numeric(as.character(substr(dataset$Prijs[i],6,6)))
  
  print(ProductIndex)
  print(PriceIndex)
  
  index1 = ProductIndex + 1
  index2 = PriceIndex + 1
  
  dataset$ActualPrice[i] = all_prod[index1,index2]
}

print(all_prod)

head(dataset)
tail(dataset)

dataset$ActualPrice = as.numeric(dataset$ActualPrice)
print(dataset$ActualPrice[1])

## Melt reactietijd per echte prijs (MEAN) ##
rt_actual = melt(dataset, id.vars = c("ActualPrice"), measure.vars = c("RT_in_ms"))  
average_rt_actual = cast(rt_actual, ActualPrice ~ ., mean)
colnames(average_rt_actual) = c("ActualPrice", "Mean")
summary(average_rt_actual)

## Melt reactietijd per echte prijs (MEDIAN) ##
rt_actual = melt(dataset, id.vars = c("ActualPrice"), measure.vars = c("RT_in_ms"))  
median_rt_actual = cast(rt_actual, ActualPrice ~ ., median)
colnames(median_rt_actual) = c("ActualPrice", "Median")
summary(median_rt_actual)

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try")

## Plot reactietijd per echte prijs (MEAN) ##
# tiff("exp1_ggplot_mean_rt_actual_prices.tiff", width = 1600, height = 850)
print(ggplot(average_rt_actual, aes(ActualPrice,Mean)) + geom_point(color = "black", cex=2) + geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Displayed product price", breaks=dataset$ActualPrice,labels = as.factor(dataset$ActualPrice), minor_breaks = NULL)
      + scale_y_continuous(name="Mean reaction time (in ms)")
      + labs(title = "Mean reaction time for different displayed prices across participants (in ms)", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5), 
              plot.subtitle = element_text(hjust = 0.5), 
              axis.text.x = element_text(angle = 90, vjust = 0.5, size = 9, hjust = 1),
              plot.background = element_rect(fill = "white"))
      + expand_limits(y=c(475, 600)))
# dev.off()

## Plot reactietijd per echte prijs (MEDIAN) ##
# tiff("exp1_ggplot_median_rt_actual_prices.tiff", width = 1600, height = 850)
print(ggplot(median_rt_actual, aes(ActualPrice,Median)) + geom_point(color = "black", cex=2) + geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Displayed product price", breaks=dataset$ActualPrice,labels = as.factor(dataset$ActualPrice), minor_breaks = NULL)
      + scale_y_continuous(name="Median reaction time (in ms)")
      + labs(title = "Median reaction time for different displayed prices across participants (in ms)", subtitle = "Experiment 1")
      + theme(plot.title = element_text(hjust = 0.5), 
              plot.subtitle = element_text(hjust = 0.5), 
              axis.text.x = element_text(angle = 90, vjust = 0.5, size = 9, hjust = 1),
              plot.background = element_rect(fill = "white")))
# dev.off()


## Creation of category 'label' ##
dataset$Label = rep(c(''), times = dim(dataset)[1])

for (i in 1:dim(dataset)[1]){
  PriceIndex = as.numeric(as.character(substr(dataset$Prijs[i],6,6)))
  
  if(PriceIndex <= 2){
    dataset$Label[i] = 'cheap'
  }
  if(PriceIndex >= 4){
    dataset$Label[i] = 'expensive'
  }
  if(PriceIndex == 3){
    dataset$Label[i] = 'reference'
  }
}

head(dataset)
tail(dataset)

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try")

## Melt reactietijd per echte prijs (MEAN) ##
rt_label = melt(dataset, id.vars = c("Label"), measure.vars = c("RT_in_ms"))  
average_rt_label = cast(rt_label, Label ~ ., mean)
colnames(average_rt_label) = c("Label", "Mean")
summary(average_rt_label)

# tiff("exp1_barchart_mean_rt_label.tiff", width = 1300, height = 650)
numbers = c(547.8433, 561.6125, 557.7646)
label = c("cheap", "reference", "expensive")
text(barplot(numbers, main = "Distribution of mean reaction time for each label", ylab = "Mean reaction time (in ms)", 
             col = c('mediumspringgreen', 'lightsteelblue1', 'tomato'), ylim = c(0,600), names.arg=label), as.vector(numbers), labels = as.vector(numbers), pos = 3)
# dev.off()

## Melt reactietijd per echte prijs (MEDIAN) ##
rt_label = melt(dataset, id.vars = c("Label"), measure.vars = c("RT_in_ms"))  
median_rt_label = cast(rt_label, Label ~ ., median)
colnames(median_rt_label) = c("Label", "Median")
summary(median_rt_label)

# tiff("exp1_barchart_median_rt_label.tiff", width = 1300, height = 650)
numbers = c(484, 499, 484)
label = c("cheap", "reference", "expensive")
text(barplot(numbers, main = "Distribution of median reaction time for each label", ylab = "Median reaction time (in ms)", 
             col = c('mediumspringgreen', 'lightsteelblue1', 'tomato'), ylim = c(0,600), names.arg=label), as.vector(numbers), labels = as.vector(numbers), pos = 3)
# dev.off()

# write edited data to external folder

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis/Data_Thesis_EXP1")

write.table(dataset, file = "Data_Thesis_EXP1_edited.txt", append = FALSE, quote = FALSE, sep = "\t", na = "NA", 
            row.names = FALSE, col.names = TRUE)

#########
## END ##
#########
