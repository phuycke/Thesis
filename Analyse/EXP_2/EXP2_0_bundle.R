####
# bundle the raw data files acquired from the experiment into one large file for analysis
# the raw data files have to be in the same folder
# first point R to the specific folder, then R will concatenate all files in this folder to one big file
####

# set working directory
####

setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis/Data_Thesis_EXP2")

list = list.files(path = "C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis/Data_Thesis_EXP2")

# loop over files
####

for(i in 1:length(list)){
  name = list[i]
  dataSet = read.table(name, fill = T, header = F, sep = "\t",  na.strings = "")
  numRow = dim(dataSet)[1]
  numRow = as.numeric(numRow)
  if(i == 1){
    dataSet = dataSet[1:numRow,  ]
  }
  else{
    dataSet = dataSet[2:numRow,  ]
  }
  write.table(dataSet, file = "Data_Thesis_EXP2_All.txt", append = TRUE, quote = FALSE, sep = "\t", na = "NA", row.names = FALSE, col.names = FALSE)
}

#########
## END ##
#########
