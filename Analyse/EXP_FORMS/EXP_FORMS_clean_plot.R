setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis")

data = read.csv(file="googleFormsGegevensNeeded.txt", fill = T, header = F, na.strings = "", sep="\t")
  nameRow = data[1,  ]
  print(nameRow)
  numRow = dim(data)[1]
  numRow = as.numeric(numRow)
  data = data[2:numRow,  ]

dataset = data.frame(data, row.names = NULL)


columnNames = c("Tijdstempel","Experiment name","SubjectNr","Geslacht","Leeftijd",
                "OnlangsGekocht0","OnlangsGekocht1","OnlangsGekocht2","OnlangsGekocht3",
                "OnlangsGekocht4","OnlangsGekocht5","OnlangsGekocht6","OnlangsGekocht7",
                "RedelijkGeprijsd0","WaarVoorGeld0","GoedProductVoorPrijs0","ZouVoordeligZijn0",
                "RedelijkGeprijsd1","WaarVoorGeld1","GoedProductVoorPrijs1","ZouVoordeligZijn1",
                "RedelijkGeprijsd2","WaarVoorGeld2","GoedProductVoorPrijs2","ZouVoordeligZijn2",
                "RedelijkGeprijsd3","WaarVoorGeld3","GoedProductVoorPrijs3","ZouVoordeligZijn3",
                "RedelijkGeprijsd6","WaarVoorGeld6","GoedProductVoorPrijs6","ZouVoordeligZijn6",
                "RedelijkGeprijsd4","WaarVoorGeld4","GoedProductVoorPrijs4","ZouVoordeligZijn4",
                "RedelijkGeprijsd5","WaarVoorGeld5","GoedProductVoorPrijs5","ZouVoordeligZijn5",
                "RedelijkGeprijsd7","WaarVoorGeld7","GoedProductVoorPrijs7","ZouVoordeligZijn7")

colnames(dataset) = columnNames

head(dataset)
tail(dataset)

xtabs(~Geslacht,        dataset)
xtabs(~leeftijd,	      dataset)

xtabs(~OnlangsGekocht0, dataset)
xtabs(~OnlangsGekocht1,	dataset)
xtabs(~OnlangsGekocht2, dataset)
xtabs(~OnlangsGekocht3, dataset)
xtabs(~OnlangsGekocht4, dataset)
xtabs(~OnlangsGekocht5, dataset)
xtabs(~OnlangsGekocht6, dataset)  
xtabs(~OnlangsGekocht7, dataset)

xtabs(~RedelijkGeprijsd0, dataset)
xtabs(~RedelijkGeprijsd1,	dataset)
xtabs(~RedelijkGeprijsd2, dataset)
xtabs(~RedelijkGeprijsd3, dataset)
xtabs(~RedelijkGeprijsd4, dataset)
xtabs(~RedelijkGeprijsd5, dataset)
xtabs(~RedelijkGeprijsd6, dataset)  
xtabs(~RedelijkGeprijsd7, dataset)

xtabs(~WaarVoorGeld0, dataset)
xtabs(~WaarVoorGeld1,	dataset)
xtabs(~WaarVoorGeld2, dataset)
xtabs(~WaarVoorGeld3, dataset)
xtabs(~WaarVoorGeld4, dataset)
xtabs(~WaarVoorGeld5, dataset)
xtabs(~WaarVoorGeld6, dataset)  
xtabs(~WaarVoorGeld7, dataset)

xtabs(~GoedProductVoorPrijs0, dataset)
xtabs(~GoedProductVoorPrijs1,	dataset)
xtabs(~GoedProductVoorPrijs2, dataset)
xtabs(~GoedProductVoorPrijs3, dataset)
xtabs(~GoedProductVoorPrijs4, dataset)
xtabs(~GoedProductVoorPrijs5, dataset)
xtabs(~GoedProductVoorPrijs6, dataset)  
xtabs(~GoedProductVoorPrijs7, dataset)

xtabs(~ZouVoordeligZijn0, dataset)
xtabs(~ZouVoordeligZijn1,	dataset)
xtabs(~ZouVoordeligZijn2, dataset)
xtabs(~ZouVoordeligZijn3, dataset)
xtabs(~ZouVoordeligZijn4, dataset)
xtabs(~ZouVoordeligZijn5, dataset)
xtabs(~ZouVoordeligZijn6, dataset)  
xtabs(~ZouVoordeligZijn7, dataset)

## Reshapen en melten van de data ##         
library(car)
library(reshape)
library(lattice)
library(ggplot2)
library(scales)

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try")

sex = data.frame(table(dataset$Geslacht)[2:3], nrow = 2, ncol = 1)

slices = sex$Freq 
lbls = c("Male","Female")
pct = round((slices/sum(slices)*100))
lbls = paste(lbls,':', pct) # add percents to labels 
lbls = paste(lbls,"%",sep="") # add % to labels 
# tiff("google_piechart_distribution_sexes.tiff", width = 1300, height = 650)
pie(slices,labels = lbls, col=c('lightskyblue1','lightslateblue'),
    main="Distribution of sexes (across entire experiment)")
# dev.off()

# tiff("google_barchart_distribution_sexes.tiff", width = 1300, height = 650)
numbers = table(dataset$Geslacht)[2:3]
text(barplot(numbers, main = "Distribution of sexes across participants", ylab = "Distribution of sexes across participants", 
             col=rainbow(length(numbers)), ylim = c(0,70)), as.vector(numbers), labels = as.vector(numbers), pos = 3)
# dev.off()

age = data.frame(table(dataset$Leeftijd)[1:12], nrow = 12, ncol = 1)
age = age[12:1,]

slices = age$Freq 
lbls = age$Var1
pct = round((slices/sum(slices)*100))
lbls = paste(lbls, "years old",':', pct) # add percents to labels 
lbls = paste(lbls,"%",sep="") # add % to labels 
# tiff("google_piechart_distribution_age.tiff", width = 1300, height = 650)
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Distribution of age (across entire experiment)")
# dev.off()

leeftijd = as.numeric(as.character(dataset$Leeftijd))

mean(leeftijd)
sd(leeftijd)
range(leeftijd)

# tiff("google_barchart_distribution_age.tiff", width = 1300, height = 650)
numbers = table(dataset$Leeftijd)[1:12]
text(barplot(numbers, main = "Distribution of age across participants (expressed in years)", ylab = "Distribution of age across participants", 
             col=rainbow(length(numbers)), ylim = c(0,15)), as.vector(numbers), labels = as.vector(numbers), pos = 3)
# dev.off()

## BUYER EXPERIENCE ##

# tiff("google_barchart_buyer_experience_prod0.tiff", width = 1300, height = 650)
numbers = table(dataset$OnlangsGekocht0)[2:5]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Bought once","Less than monthly", "Monthly","Never bought")
text(barplot(percentages, main = "Have you bought this product (Lipton Ice-Tea) recently?", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,100), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_buyer_experience_prod1.tiff", width = 1300, height = 650)
numbers = table(dataset$OnlangsGekocht1)[2:6]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Bought once","Less than monthly","Weekly", "Monthly","Never bought")
text(barplot(percentages, main = "Have you bought this product (Coca-Cola) recently?", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,100), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_buyer_experience_prod2.tiff", width = 1300, height = 650)
x = as.numeric(length(table(dataset$OnlangsGekocht2)))
numbers = table(dataset$OnlangsGekocht2)[2:x]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Bought once","Less than monthly","Monthly","Never bought")
text(barplot(percentages, main = "Have you bought this product (tic tac) recently?", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,100), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_buyer_experience_prod3.tiff", width = 1300, height = 650)
x = as.numeric(length(table(dataset$OnlangsGekocht3)))
numbers = table(dataset$OnlangsGekocht3)[2:x]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Bought once","Less than monthly","Monthly","Never bought")
text(barplot(percentages, main = "Have you bought this product (Philadelphia) recently?", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,100), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_buyer_experience_prod4.tiff", width = 1300, height = 650)
x = as.numeric(length(table(dataset$OnlangsGekocht4)))
numbers = table(dataset$OnlangsGekocht4)[2:x]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Bought once","Less than monthly","Weekly","Monthly","Never bought")
text(barplot(percentages, main = "Have you bought this product (Minute Maid) recently?", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,100), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_buyer_experience_prod5.tiff", width = 1300, height = 650)
x = as.numeric(length(table(dataset$OnlangsGekocht5)))
numbers = table(dataset$OnlangsGekocht5)[2:x]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Bought once","Less than monthly","Weekly","Monthly","Never bought")
text(barplot(percentages, main = "Have you bought this product (Lays) recently?", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,100), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_buyer_experience_prod6.tiff", width = 1300, height = 650)
x = as.numeric(length(table(dataset$OnlangsGekocht6)))
numbers = table(dataset$OnlangsGekocht6)[2:x]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Bought once","Less than monthly","Weekly","Monthly","Never bought")
text(barplot(percentages, main = "Have you bought this product (Herta) recently?", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,100), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_buyer_experience_prod7.tiff", width = 1300, height = 650)
x = as.numeric(length(table(dataset$OnlangsGekocht7)))
numbers = table(dataset$OnlangsGekocht7)[2:x]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Bought once","Less than monthly","Weekly","Monthly","Never bought")
text(barplot(percentages, main = "Have you bought this product (Haribo) recently?", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,100), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

## REASONABLE PRICE ##

# tiff("google_barchart_reasonable_price_prod0.tiff", width = 1300, height = 650)
numbers = table(dataset$RedelijkGeprijsd0)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Lipton Ice-Tea) is reasonably priced (2.31 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_reasonable_price_prod1.tiff", width = 1300, height = 650)
numbers = table(dataset$RedelijkGeprijsd1)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Coca-Cola) is reasonably priced (1.71 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_reasonable_price_prod2.tiff", width = 1300, height = 650)
numbers = table(dataset$RedelijkGeprijsd2)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (tic tac) is reasonably priced (2.00 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_reasonable_price_prod3.tiff", width = 1300, height = 650)
numbers = table(dataset$RedelijkGeprijsd3)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Philadelphia) is reasonably priced (2.53 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_reasonable_price_prod4.tiff", width = 1300, height = 650)
numbers = table(dataset$RedelijkGeprijsd4)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Minute Maid) is reasonably priced (1.24 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_reasonable_price_prod5.tiff", width = 1300, height = 650)
numbers = table(dataset$RedelijkGeprijsd5)[2:7]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Lays) is reasonably priced (1.42 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_reasonable_price_prod6.tiff", width = 1300, height = 650)
numbers = table(dataset$RedelijkGeprijsd6)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Herta) is reasonably priced (3.74 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_reasonable_price_prod7.tiff", width = 1300, height = 650)
numbers = table(dataset$RedelijkGeprijsd7)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Haribo) is reasonably priced (3.48 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

## QUALITY FOR PRICE ##

# tiff("google_barchart_quality_for_price_prod0.tiff", width = 1300, height = 650)
numbers = table(dataset$WaarVoorGeld0)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Lipton Ice-Tea) offers me quality for my money (2.31 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_quality_for_price_prod1.tiff", width = 1300, height = 650)
numbers = table(dataset$WaarVoorGeld1)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Coca-Cola) offers me quality for my money (1.71 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_quality_for_price_prod2.tiff", width = 1300, height = 650)
numbers = table(dataset$WaarVoorGeld2)[2:7]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6")
text(barplot(percentages, main = "This product (tic tac) offers me quality for my money (2.00 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_quality_for_price_prod3.tiff", width = 1300, height = 650)
numbers = table(dataset$WaarVoorGeld3)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Philadelphia) offers me quality for my money (2.53 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_quality_for_price_prod4.tiff", width = 1300, height = 650)
numbers = table(dataset$WaarVoorGeld4)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Minute Maid) offers me quality for my money (1.24 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_quality_for_price_prod5.tiff", width = 1300, height = 650)
numbers = table(dataset$WaarVoorGeld5)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("1","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Lays) offers me quality for my money (1.42 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_quality_for_price_prod6.tiff", width = 1300, height = 650)
numbers = table(dataset$WaarVoorGeld6)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Herta) offers me quality for my money (3.74 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_quality_for_price_prod7.tiff", width = 1300, height = 650)
numbers = table(dataset$WaarVoorGeld7)[2:7]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6")
text(barplot(percentages, main = "This product (Haribo) offers me quality for my money (3.48 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

## GOOD PRODUCT FOR THE PRICE ##

# tiff("google_barchart_good_for_price_prod0.tiff", width = 1300, height = 650)
numbers = table(dataset$GoedProductVoorPrijs0)[2:7]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6")
text(barplot(percentages, main = "This is a good product (Lipton Ice-Tea) for this price (2.31 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_good_for_price_prod1.tiff", width = 1300, height = 650)
numbers = table(dataset$GoedProductVoorPrijs1)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This is a good product (Coca-Cola) for this price (1.71 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_good_for_price_prod2.tiff", width = 1300, height = 650)
numbers = table(dataset$GoedProductVoorPrijs2)[2:7]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6")
text(barplot(percentages, main = "This is a good product (tic tac) for this price (2.00 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_good_for_price_prod3.tiff", width = 1300, height = 650)
numbers = table(dataset$GoedProductVoorPrijs3)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This is a good product (Philadelphia) for this price (2.53 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_good_for_price_prod4.tiff", width = 1300, height = 650)
numbers = table(dataset$GoedProductVoorPrijs4)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This is a good product (Minute Maid) for this price (1.24 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_good_for_price_prod5.tiff", width = 1300, height = 650)
numbers = table(dataset$GoedProductVoorPrijs5)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("1","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This is a good product (Lays) for this price (1.42 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_good_for_price_prod6.tiff", width = 1300, height = 650)
numbers = table(dataset$GoedProductVoorPrijs6)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This is a good product (Herta) for this price (3.74 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_good_for_price_prod7.tiff", width = 1300, height = 650)
numbers = table(dataset$GoedProductVoorPrijs7)[2:7]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6")
text(barplot(percentages, main = "This is a good product (Haribo) for this price (3.48 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

## GOOD PRODUCT FOR THE PRICE ##

# tiff("google_barchart_beneficial_for_price_prod0.tiff", width = 1300, height = 650)
numbers = table(dataset$ZouVoordeligZijn0)[2:7]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","7")
text(barplot(percentages, main = "This product (Lipton Ice-Tea) would be beneficial (2.31 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_beneficial_for_price_prod1.tiff", width = 1300, height = 650)
numbers = table(dataset$ZouVoordeligZijn1)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Coca-Cola) would be beneficial (1.71 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_beneficial_for_price_prod2.tiff", width = 1300, height = 650)
numbers = table(dataset$ZouVoordeligZijn2)[2:7]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6")
text(barplot(percentages, main = "This product (tic tac) would be beneficial (2.00 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_beneficial_for_price_prod3.tiff", width = 1300, height = 650)
numbers = table(dataset$ZouVoordeligZijn3)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Philadelphia) would be beneficial (2.53 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_beneficial_for_price_prod4.tiff", width = 1300, height = 650)
numbers = table(dataset$ZouVoordeligZijn4)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Minute Maid) would be beneficial (1.24 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_beneficial_for_price_prod5.tiff", width = 1300, height = 650)
numbers = table(dataset$ZouVoordeligZijn5)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("1","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Lays) would be beneficial (1.42 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_beneficial_for_price_prod6.tiff", width = 1300, height = 650)
numbers = table(dataset$ZouVoordeligZijn6)[2:8]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6","Absolutely")
text(barplot(percentages, main = "This product (Herta) would be beneficial (3.74 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

# tiff("google_barchart_beneficial_for_price_prod7.tiff", width = 1300, height = 650)
numbers = table(dataset$ZouVoordeligZijn7)[2:7]
percentages = round((numbers/dim(dataset)[1]*100),2)
label = c("Absolutely not","2", "3","4","5","6")
text(barplot(percentages, main = "This product (Haribo) would be beneficial (3.48 euro)", ylab = "Percentage this option was selected (all subjects)", 
             col=rainbow(length(percentages)), ylim = c(0,50), names.arg=label), as.vector(percentages), labels = as.vector(percentages), pos = 3)
# dev.off()

## Create on dataset ##
subNum = rep(c(1:66,68,69), times = 8)
SubjectNr = matrix(subNum, nrow = length(subNum), ncol = 1)

productnaam = rep(c('product0','product1','product2','product3','product4','product5','product6','product7'), each = length(dataset$OnlangsGekocht0))
productname = matrix(productnaam, nrow = length(productnaam), ncol = 1)

gekocht0 = matrix(dataset$OnlangsGekocht0, ncol = 1)
gekocht1 = matrix(dataset$OnlangsGekocht1, ncol = 1)
gekocht2 = matrix(dataset$OnlangsGekocht2, ncol = 1)
gekocht3 = matrix(dataset$OnlangsGekocht3, ncol = 1)
gekocht4 = matrix(dataset$OnlangsGekocht4, ncol = 1)
gekocht5 = matrix(dataset$OnlangsGekocht5, ncol = 1)
gekocht6 = matrix(dataset$OnlangsGekocht6, ncol = 1)
gekocht7 = matrix(dataset$OnlangsGekocht7, ncol = 1)

onlangs = rbind(gekocht0, gekocht1, gekocht2, gekocht3,
                gekocht4, gekocht5, gekocht6, gekocht7)

priced0 = matrix(dataset$RedelijkGeprijsd0, ncol = 1)
priced1 = matrix(dataset$RedelijkGeprijsd1, ncol = 1)
priced2 = matrix(dataset$RedelijkGeprijsd2, ncol = 1)
priced3 = matrix(dataset$RedelijkGeprijsd3, ncol = 1)
priced4 = matrix(dataset$RedelijkGeprijsd4, ncol = 1)
priced5 = matrix(dataset$RedelijkGeprijsd5, ncol = 1)
priced6 = matrix(dataset$RedelijkGeprijsd6, ncol = 1)
priced7 = matrix(dataset$RedelijkGeprijsd7, ncol = 1)

priced = rbind(priced0, priced1, priced2, priced3,
                priced4, priced5, priced6, priced7)

waarVoorGeld0 = matrix(dataset$WaarVoorGeld0, ncol = 1)
waarVoorGeld1 = matrix(dataset$WaarVoorGeld1, ncol = 1)
waarVoorGeld2 = matrix(dataset$WaarVoorGeld2, ncol = 1)
waarVoorGeld3 = matrix(dataset$WaarVoorGeld3, ncol = 1)
waarVoorGeld4 = matrix(dataset$WaarVoorGeld4, ncol = 1)
waarVoorGeld5 = matrix(dataset$WaarVoorGeld5, ncol = 1)
waarVoorGeld6 = matrix(dataset$WaarVoorGeld6, ncol = 1)
waarVoorGeld7 = matrix(dataset$WaarVoorGeld7, ncol = 1)

waarVoorGeld = rbind(waarVoorGeld0, waarVoorGeld1, waarVoorGeld2, waarVoorGeld3,
               waarVoorGeld4, waarVoorGeld5, waarVoorGeld6, waarVoorGeld7)

Good_for_Money0 = matrix(dataset$GoedProductVoorPrijs0, ncol = 1)
Good_for_Money1 = matrix(dataset$GoedProductVoorPrijs1, ncol = 1)
Good_for_Money2 = matrix(dataset$GoedProductVoorPrijs2, ncol = 1)
Good_for_Money3 = matrix(dataset$GoedProductVoorPrijs3, ncol = 1)
Good_for_Money4 = matrix(dataset$GoedProductVoorPrijs4, ncol = 1)
Good_for_Money5 = matrix(dataset$GoedProductVoorPrijs5, ncol = 1)
Good_for_Money6 = matrix(dataset$GoedProductVoorPrijs6, ncol = 1)
Good_for_Money7 = matrix(dataset$GoedProductVoorPrijs7, ncol = 1)

Good_for_Money = rbind(Good_for_Money0, Good_for_Money1, Good_for_Money2, Good_for_Money3,
                     Good_for_Money4, Good_for_Money5, Good_for_Money6, Good_for_Money7)

beneficial0 = matrix(dataset$ZouVoordeligZijn0, ncol = 1)
beneficial1 = matrix(dataset$ZouVoordeligZijn1, ncol = 1)
beneficial2 = matrix(dataset$ZouVoordeligZijn2, ncol = 1)
beneficial3 = matrix(dataset$ZouVoordeligZijn3, ncol = 1)
beneficial4 = matrix(dataset$ZouVoordeligZijn4, ncol = 1)
beneficial5 = matrix(dataset$ZouVoordeligZijn5, ncol = 1)
beneficial6 = matrix(dataset$ZouVoordeligZijn6, ncol = 1)
beneficial7 = matrix(dataset$ZouVoordeligZijn7, ncol = 1)

beneficial = rbind(beneficial0, beneficial1, beneficial2, beneficial3,
                       beneficial4, beneficial5, beneficial6, beneficial7)

data = cbind(SubjectNr, productname, onlangs, priced, waarVoorGeld, Good_for_Money, beneficial)

data = data.frame(data, row.names = NULL)
colnames(data) = c("SubjectNr","Product","RecentlyBought","ReasonablyPriced","QualityForMoney","GoodForPrice","Benificial")
head(data)

for(i in 1:length(data$QualityForMoney)){
  data$ReasonablyPriced = as.character(data$ReasonablyPriced)
  if(data$ReasonablyPriced[i] == '1 (helemaal niet akkoord)'){
    data$ReasonablyPriced[i] = '1'
  }
  if(data$ReasonablyPriced[i] == '7 (helemaal akkoord)'){
    data$ReasonablyPriced[i] = '7'
  }
  data$ReasonablyPriced = as.factor(data$ReasonablyPriced)
  
  data$QualityForMoney = as.character(data$QualityForMoney)
  if(data$QualityForMoney[i] == '1 (helemaal niet akkoord)'){
    data$QualityForMoney[i] = '1'
  }
  if(data$QualityForMoney[i] == '7 (helemaal akkoord)'){
    data$QualityForMoney[i] = '7'
  }
  data$QualityForMoney = as.factor(data$QualityForMoney)

  data$GoodForPrice = as.character(data$GoodForPrice)
  if(data$GoodForPrice[i] == '1 (helemaal niet akkoord)'){
    data$GoodForPrice[i] = '1'
  }
  if(data$GoodForPrice[i] == '7 (helemaal akkoord)'){
    data$GoodForPrice[i] = '7'
  }
  data$GoodForPrice = as.factor(data$GoodForPrice)
  
  data$Benificial = as.character(data$Benificial)
  if(data$Benificial[i] == '1 (helemaal niet akkoord)'){
    data$Benificial[i] = '1'
  }
  if(data$Benificial[i] == '7 (helemaal akkoord)'){
    data$Benificial[i] = '7'
  }
  data$Benificial = as.factor(data$Benificial)
  
}

head(data)
print(class(data$GoodForPrice))

data$ReasonablyPriced = as.numeric(data$ReasonablyPriced)
data$QualityForMoney  = as.numeric(data$QualityForMoney)
data$GoodForPrice     = as.numeric(data$GoodForPrice)
data$Benificial       = as.numeric(data$Benificial)

## Melt ReasonablyPriced per product ##
reason_product = melt(data, id.vars = c("Product"), measure.vars = c("ReasonablyPriced"))  
average_reason_product = cast(reason_product, Product ~ ., mean)
colnames(average_reason_product) = c("Product", "Mean")
summary(average_reason_product)

## Melt QualityForMoney per product ##
quality_product = melt(data, id.vars = c("Product"), measure.vars = c("QualityForMoney"))  
average_quality_product = cast(quality_product, Product ~ ., mean)
colnames(average_quality_product) = c("Product", "Mean")
summary(average_quality_product)

## Melt GoodForPrice per product ##
goodForPrice_product = melt(data, id.vars = c("Product"), measure.vars = c("GoodForPrice"))  
average_goodForPrice_product = cast(goodForPrice_product, Product ~ ., mean)
colnames(average_goodForPrice_product) = c("Product", "Mean")
summary(average_goodForPrice_product)

## Melt Benificial per product ##
benificial_product = melt(data, id.vars = c("Product"), measure.vars = c("Benificial"))  
average_benificial_product = cast(benificial_product, Product ~ ., mean)
colnames(average_benificial_product) = c("Product", "Mean")
summary(average_benificial_product)

## LOOKING AT SUBJECT INTERACTIONS ##

reason_subject_product = melt(data, id.vars = c("SubjectNr", "Product"), measure.vars = c("ReasonablyPriced"))  
average_reason_subject_product = cast(reason_subject_product, SubjectNr + Product ~ ., mean)
colnames(average_reason_subject_product) = c("SubjectNr", "Product", "Mean")
summary(average_reason_subject_product)

quality_subject_product = melt(data, id.vars = c("SubjectNr", "Product"), measure.vars = c("QualityForMoney"))  
average_quality_subject_product = cast(quality_subject_product, SubjectNr + Product ~ ., mean)
colnames(average_quality_subject_product) = c("SubjectNr", "Product", "Mean")
summary(average_quality_subject_product)

goodForPrice_subject_product = melt(data, id.vars = c("SubjectNr", "Product"), measure.vars = c("GoodForPrice"))  
average_goodForPrice_subject_product = cast(goodForPrice_subject_product, SubjectNr + Product ~ ., mean)
colnames(average_goodForPrice_subject_product) = c("SubjectNr", "Product", "Mean")
summary(average_goodForPrice_subject_product)

benificial_subject_product = melt(data, id.vars = c("SubjectNr", "Product"), measure.vars = c("Benificial"))  
average_benificial_subject_product = cast(benificial_subject_product, SubjectNr + Product ~ ., mean)
colnames(average_benificial_subject_product) = c("SubjectNr", "Product", "Mean")
summary(average_benificial_subject_product)


## PLOTS ##

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Data analyse/Plots/First phase_First_Try")

average_reason_product$Product = as.numeric(average_reason_product$Product)

# tiff("google_ggplot_ReasonablyPriced_per_product.tiff", width = 1360, height = 650)
labelNeeded = c("Lipton","Coca-Cola","tic tac","Philadelphia","Minute Maid","Lays","Herta","Haribo")
print(ggplot(average_reason_product, aes(Product,Mean)) + geom_point(color = "black", cex=2) +geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Product displayed",  breaks=average_reason_product$Product,labels = as.factor(labelNeeded), minor_breaks = NULL) 
      + scale_y_continuous(name="Mean score given by participants (7 point Likert scale)", breaks=c(0:7),labels = as.factor(c(0:7)))
      + labs(title = "'This product is reasonably priced'", subtitle = "Experiment 2")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5))
      + expand_limits(y=c(0, 7)))
# dev.off()

average_quality_product$Product = as.numeric(average_quality_product$Product)

# tiff("google_ggplot_QualityForMoney_per_product.tiff", width = 1360, height = 650)
labelNeeded = c("Lipton","Coca-Cola","tic tac","Philadelphia","Minute Maid","Lays","Herta","Haribo")
print(ggplot(average_quality_product, aes(Product,Mean)) + geom_point(color = "black", cex=2) +geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Product displayed",  breaks=average_quality_product$Product,labels = as.factor(labelNeeded), minor_breaks = NULL) 
      + scale_y_continuous(name="Mean score given by participants (7 point Likert scale)", breaks=c(0:7),labels = as.factor(c(0:7)))
      + labs(title = "'This product offers value for money'", subtitle = "Experiment 2")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5))
      + expand_limits(y=c(0, 7)))
# dev.off()

average_goodForPrice_product$Product = as.numeric(average_goodForPrice_product$Product)

# tiff("google_ggplot_GoodForPrice_per_product.tiff", width = 1360, height = 650)
labelNeeded = c("Lipton","Coca-Cola","tic tac","Philadelphia","Minute Maid","Lays","Herta","Haribo")
print(ggplot(average_goodForPrice_product, aes(Product,Mean)) + geom_point(color = "black", cex=2) +geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Product displayed",  breaks=average_goodForPrice_product$Product,labels = as.factor(labelNeeded), minor_breaks = NULL) 
      + scale_y_continuous(name="Mean score given by participants (7 point Likert scale)", breaks=c(0:7),labels = as.factor(c(0:7)))
      + labs(title = "'This is a good product for the price'", subtitle = "Experiment 2")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5))
      + expand_limits(y=c(0, 7)))
# dev.off()

average_benificial_product$Product = as.numeric(average_benificial_product$Product)

# tiff("google_ggplot_Benificial_per_product.tiff", width = 1360, height = 650)
labelNeeded = c("Lipton","Coca-Cola","tic tac","Philadelphia","Minute Maid","Lays","Herta","Haribo")
print(ggplot(average_benificial_product, aes(Product,Mean)) + geom_point(color = "black", cex=2) +geom_smooth(method = "loess", color = "red")
      + scale_x_continuous(name="Product displayed",  breaks=average_benificial_product$Product,labels = as.factor(labelNeeded), minor_breaks = NULL) 
      + scale_y_continuous(name="Mean score given by participants (7 point Likert scale)", breaks=c(0:7),labels = as.factor(c(0:7)))
      + labs(title = "'This product would be economical'", subtitle = "Experiment 2")
      + theme(plot.title = element_text(hjust = 0.5))
      + theme(plot.subtitle = element_text(hjust = 0.5))
      + expand_limits(y=c(0, 7)))
# dev.off()

dataset$Leeftijd = as.numeric(as.character(dataset$Leeftijd))
median(dataset$Leeftijd)

#########
## END ##
#########
