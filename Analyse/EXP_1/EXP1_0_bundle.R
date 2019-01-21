setwd("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis/Data_Thesis_EXP1")

list = list.files(path = "C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Data_thesis/Data_Thesis_EXP1")


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
  write.table(dataSet, file = "Data_Thesis_EXP1_All.txt", append = TRUE, quote = FALSE, sep = "\t", na = "NA", row.names = FALSE, col.names = FALSE)
  }