####
# in this script, the data is read, and edited to make it ready for plotting
# the data is cleaned (extreme values are removed), and extra columns with new variables are created
# at the end of the script, a new file with the edited data is written to an external folder
####

# set working directory
####

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis/Data_Thesis_EXP2")

# read data
####

data = read.table("Data_Thesis_EXP2_All.txt", fill = T, header = F, sep = "\t",  na.strings = "")
  nameRow = data[1,  ]
  print(nameRow)
  numRow = dim(data)[1]
  numRow = as.numeric(numRow)
  data = data[2:numRow,  ]

dataset = data.frame(data, row.names = NULL)
dataset$V1 = NULL
dataset$V3 = NULL
subjectnr = rep(c(36:70), each = (dim(dataset)[1] / 35))
print(length(subjectnr) == dim(dataset)[1])
dataset$SubjectNr = matrix(subjectnr, nrow = dim(dataset)[1], ncol = 1)

columnNames = c("BlockNumber","Product","Prijs","Key","RT_in_ms","BlockRT","SD","RespThreshold","TooLate", "SubjectNr")
colnames(dataset) = columnNames
print(dataset)

# start exploring data 
####

xtabs(~BlockNumber,   dataset)
xtabs(~Product,	      dataset) 
xtabs(~Prijs, 	      dataset)
xtabs(~Key,	          dataset)
xtabs(~RT_in_ms,      dataset)
xtabs(~BlockRT,       dataset)
xtabs(~SD,            dataset)
xtabs(~RespThreshold, dataset)
xtabs(~TooLate,       dataset)  
xtabs(~SubjectNr,     dataset)

# deeper exploration
####

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

# reshaping and melting the data 
####

library(car)
library(reshape)
library(lattice)
library(ggplot2)

print(class(dataset$RT_in_ms))
print(class(dataset$BlockRT))
print(class(dataset$TooLate))

firstTrials = dataset[dataset$SD == '0.0', ]
dataset = dataset[!dataset$SD == '0.0', ]

trialnumbers = c(1:328)
allTrialnumbers = rep(trialnumbers, times = 35)
dataset$TrialNumber = allTrialnumbers

dataset <- dataset[c("BlockNumber","Product","Prijs","Key","RT_in_ms","BlockRT","SD","RespThreshold","TooLate","SubjectNr","TrialNumber")]
dataset <- dataset[,c("SubjectNr","TrialNumber","BlockNumber","Product","Prijs","Key","RT_in_ms","BlockRT","SD","RespThreshold","TooLate")]

dataset$TrialNumber = as.numeric(as.character(dataset$TrialNumber))
dataset$RT_in_ms = as.numeric(as.character(dataset$RT_in_ms))
dataset$BlockRT = as.numeric(as.character(dataset$BlockRT))
dataset$TooLate = as.numeric(as.character(dataset$TooLate))

print(class(dataset$TrialNumber))
print(class(dataset$RT_in_ms))
print(class(dataset$BlockRT))
print(class(dataset$TooLate))

head(dataset)
tail(dataset)

# mean reaction time in the first phase 
####

cat("The mean reaction time equals:", print(mean(dataset$RT_in_ms)))

# variance and standard deviation of reaction time 
####

cat("The variance of the reaction time equals:", print(var(dataset$RT_in_ms)))
cat("The variance of the reaction time equals:", print(sd(dataset$RT_in_ms)))

# ONE VARIABLE 
####

# compute mean reaction time across subjects
####

rt_subject = melt(dataset, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
average_rt_subject = cast(rt_subject, SubjectNr ~ ., mean)
colnames(average_rt_subject) = c("SubjectNr", "Mean")
summary(average_rt_subject)

# compute standard deviation of reaction times across subjects
####

rt_subject = melt(dataset, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
sd_rt_subject = cast(rt_subject, SubjectNr ~ ., sd)
colnames(sd_rt_subject) = c("SubjectNr", "SD")
summary(sd_rt_subject)

# delete all the trials where the participants were slower than 200 ms, or faster than their mean reaction time + 3*SD
####

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

# assess how many trials were deleted
####

cat("Number of entries that were deleted:", rows_deleted)
cat("In percentages, this corresponds to", rows_deleted_percentage, "% of the rows deleted")

# replace the cleaned dataset with the original one
####

dataset = cleaned_data

###############
## NEW START ##
###############

# compute mean reaction time per subject
####

rt_subject = melt(dataset, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
average_rt_subject = cast(rt_subject, SubjectNr ~ ., mean)
colnames(average_rt_subject) = c("SubjectNr", "Mean")
summary(average_rt_subject)

# compute standard deviations of reaction time per subject
####

rt_subject = melt(dataset, id.vars = c("SubjectNr"), measure.vars = c("RT_in_ms"))  
sd_rt_subject = cast(rt_subject, SubjectNr ~ ., sd)
colnames(sd_rt_subject) = c("SubjectNr", "SD")
summary(sd_rt_subject)

# compute mean reaction time in function of trial number
####

rt_trialnumber = melt(dataset, id.vars = c("TrialNumber"), measure.vars = c("RT_in_ms"))  
average_rt_trialnumber = cast(rt_trialnumber, TrialNumber ~ ., mean)
colnames(average_rt_trialnumber) = c("TrialNumber", "Mean")
summary(average_rt_trialnumber)

# compute median reaction time in function of trial number
####

rt2_trialnumber = melt(dataset, id.vars = c("TrialNumber"), measure.vars = c("RT_in_ms"))  
median_rt_trialnumber = cast(rt2_trialnumber, TrialNumber ~ ., median)
colnames(median_rt_trialnumber) = c("TrialNumber", "Median")
summary(median_rt_trialnumber)

# compute mean reaction time per product
####

rt_product = melt(dataset, id.vars = c("Product"), measure.vars = c("RT_in_ms"))  
average_rt_product = cast(rt_product, Product ~ ., mean)
colnames(average_rt_product) = c("Product", "Mean")
summary(average_rt_product)

# compute mean reaction time per price
####

rt_prijs = melt(dataset, id.vars = c("Prijs"), measure.vars = c("RT_in_ms"))  
average_rt_prijs = cast(rt_prijs, Prijs ~ ., mean)
colnames(average_rt_prijs) = c("Prijs", "Mean")
summary(average_rt_prijs)

# mean reaction time per key (response key)
####

rt_key = melt(dataset, id.vars = c("Key"), measure.vars = c("RT_in_ms"))  
average_rt_key = cast(rt_key, Key ~ ., mean)
colnames(average_rt_key) = c("Key", "Mean")
summary(average_rt_key)

# mean reaction time in function of 'too late or in time'
####

dataset$TooLate = as.factor(dataset$TooLate)
rt_late = melt(dataset, id.vars = c("TooLate"), measure.vars = c("RT_in_ms"))  
average_rt_late = cast(rt_late, TooLate ~ ., mean)
colnames(average_rt_late) = c("TooLate", "Mean")
summary(average_rt_late)

# what key pressed in function of 'too late or in time'
####

dataset$TooLate = as.numeric(as.character(dataset$TooLate))
key_late = melt(dataset, id.vars = c("Key"), measure.vars = c("TooLate"))  
average_key_late = cast(key_late, Key ~ ., mean)
colnames(average_key_late) = c("Key", "Mean")
summary(average_key_late)

# compute mean block reaction time in function of the block number
####

blockrt_blocknr = melt(dataset, id.vars = c("BlockNumber"), measure.vars = c("BlockRT"))  
average_blockrt_blocknr = cast(blockrt_blocknr, BlockNumber ~ ., mean)
colnames(average_blockrt_blocknr) = c("BlockNumber", "Mean")
summary(average_blockrt_blocknr)

# SUBJECT INTERACTION
####

# mean reaction time per product across subjects
####

rt_subject_product = melt(dataset, id.vars = c("SubjectNr", "Product"), measure.vars = c("RT_in_ms"))  
average_rt_subject_product = cast(rt_subject_product, SubjectNr + Product ~ ., mean)
colnames(average_rt_subject_product) = c("SubjectNr", "Product", "Mean")
summary(average_rt_subject_product)

# mean reaction time per price across subjects
####

rt_subject_prijs = melt(dataset, id.vars = c("SubjectNr", "Prijs"), measure.vars = c("RT_in_ms"))  
average_rt_subject_prijs = cast(rt_subject_prijs, SubjectNr + Prijs ~ ., mean)
colnames(average_rt_subject_prijs) = c("SubjectNr", "Prijs", "Mean")
summary(average_rt_subject_prijs)

# mean reaction time per key pressed across subjects
####

rt_subject_key = melt(dataset, id.vars = c("SubjectNr", "Key"), measure.vars = c("RT_in_ms"))  
average_rt_subject_key = cast(rt_subject_key, SubjectNr + Key ~ ., mean)
colnames(average_rt_subject_key) = c("SubjectNr", "Key", "Mean")
summary(average_rt_subject_key)

# mean reaction time in function of latency and subject number
####

dataset$TooLate = as.numeric(as.character(dataset$TooLate))
rt_subject_late = melt(dataset, id.vars = c("SubjectNr", "TooLate"), measure.vars = c("RT_in_ms"))  
average_rt_subject_late = cast(rt_subject_late, SubjectNr + TooLate ~ ., mean)
colnames(average_rt_subject_late) = c("SubjectNr", "TooLate", "Mean")
summary(average_rt_subject_late)

# mean latency in function of subject number and key pressed
####

dataset$TooLate = as.numeric(as.character(dataset$TooLate))
key_subject_late = melt(dataset, id.vars = c("SubjectNr", "Key"), measure.vars = c("TooLate"))  
average_key_subject_late = cast(key_subject_late, SubjectNr + Key ~ ., mean)
colnames(average_key_subject_late) = c("SubjectNr", "Key", "Mean")
summary(average_key_subject_late)

# mean block reaction time in function of block number and subject number
####

blockrt_subject_blocknr = melt(dataset, id.vars = c("SubjectNr", "BlockNumber"), measure.vars = c("BlockRT"))  
average_blockrt_subject_blocknr = cast(blockrt_subject_blocknr, SubjectNr + BlockNumber ~ ., mean)
colnames(average_blockrt_subject_blocknr) = c("SubjectNr", "BlockNumber", "Mean")
summary(average_blockrt_subject_blocknr)

# replace the digits 0 and 1 in the variable 'TooLate' with the words 'in time' & too late' respectively
####

dataset$TooLate[dataset$TooLate == 0] = 'in time'
dataset$TooLate[dataset$TooLate == 1] = 'too late'

# replace the price labels (such as price0, price1 ...) with the actual prices (based on the product variable)
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

dataset$ActualPrice = rep(c(''), times = dim(dataset)[1])

# replace the price labels by the real values
####

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

# check new data set
####

head(dataset)
tail(dataset)

dataset$ActualPrice = as.numeric(dataset$ActualPrice)
print(dataset$ActualPrice[1])

# compute mean reaction time in function of the actual price displayed (the numerical value)
####

rt_actual = melt(dataset, id.vars = c("ActualPrice"), measure.vars = c("RT_in_ms"))  
average_rt_actual = cast(rt_actual, ActualPrice ~ ., mean)
colnames(average_rt_actual) = c("ActualPrice", "Mean")
summary(average_rt_actual)

# compute median reaction time in function of the actual price displayed (the numerical value)
####

rt_actual = melt(dataset, id.vars = c("ActualPrice"), measure.vars = c("RT_in_ms"))  
median_rt_actual = cast(rt_actual, ActualPrice ~ ., median)
colnames(median_rt_actual) = c("ActualPrice", "Median")
summary(median_rt_actual)

# create a category called 'label' that has the value:
  # 'cheap' if the price is below the reference
  # 'reference' if the price is the reference price
  # 'expensive' if the price is higher than the reference
  ####

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

# write edited data to external folder
####

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis/Data_Thesis_EXP2")

# write.table(dataset, file = "Data_Thesis_EXP2_edited.txt", append = FALSE, quote = FALSE, sep = "\t", na = "NA", 
#             row.names = FALSE, col.names = TRUE)

#########
## END ##
#########
