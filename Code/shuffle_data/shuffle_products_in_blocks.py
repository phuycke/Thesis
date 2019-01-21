############
## Import ##
############

from __future__ import division
from psychopy import core, visual, event

from random import shuffle
import pandas as pd

import os 
import platform 
import csv

############################
##  read and manipulate 1 ##
############################

print ('# read and manipulate 1 #')

## The directory (map/folder) we are working in can be defined to tell Python from which directory we are extracting files
## In this particular case, all our files we want to edit can be situated in a certain folder on your computer
    ## Keep in mind that you can write files away to a certain location in other python programs
    ## This same location can then be used to define the working directory when you want to edit these files
    ## Random fact: os.chdir stands for OperatingSystem.ChangeDirectory
## Keep in mind that different operating systems have different ways of changing their directories
## More specifically, the specification of the directory differs between Windows and Mac and Linux
    ## no 'C:' is needed for Mac or Linux
## The code below ensures that the right notation is used to change your directory

mydirectory = '/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Randomisation files'
if (platform.system() == 'Windows'): 
    mydirectory = 'C:' + mydirectory
os.chdir(mydirectory) 

############################
##  read and manipulate 2 ##
############################

print ('# read and manipulate 2 #')

## When we have multiple files in a folder (for example: when we have a file for each participant in your experiment), we can tell Python which file to select based on the file name
## Here, we select the file 'RandomisatieFile_PP_%02d.txt' from our specified directory
    ## As we saw in earlier code, the '%02d' means that a number has to be filled
    ## What number has to be filled in, is specified right after the file name
    ## In this particular case, Python will open the file 'RandomisatieFile_PP_01.txt'
        ## Why not 'RandomisatieFile_PP_1.txt'?
            ## Because the '%02d' tells us that two numbers should be found there, as 'SubjectNr = 1', a 0 is added before the 1
            ## This notation is useful when you tested more than 9 participants
            ## Alternatively, if you tested hundreds participants, your notations would have been '%03d'
## 'dialect = 'excel' means that the data comes from an Excel file (.xlsx), or has a layout which closely resembles the Excel layout 
## 'delimiter = '\t' means that the data is seperated by a tab
    ## When we read a .csv file (comma separated values file), the values are (obviously) seperated by commas
    ## When the delimiter is a tab, this means that the values are seperated by a tab
    ## If we have a comma/tab between values, this tells us that the values belonged to different columns in the file
    ## Below, we see an example of a csv seperation, and an example of a tab seperation
        ## Ghent,Sint-Veerleplein,11
        ## Ghent    Sint-Veerleplein    11
    ## It is important to know which delimiter is used, as this determines how your file has to be read by Python
## Be sure to check the output as much as possible!
    ## By checking, you can make sure whether your manipulations work as intended
    ## You can never compile your code too much!
    ## If errors occur, remember: Google is your friend!

## Subjectnumber = 1

dataPP = []

with open("RandomisationFile_PP_%02d.txt" %Subjectnumber, 'r') as f:
    reader = csv.reader(f, dialect = 'excel', delimiter = '\t')
    for row in reader:
        print (row)
        dataPP.append(row)

print (type(dataPP)), (len(dataPP)), (dataPP)

############################
##  read and manipulate 3 ##
############################

print ('# read and manipulate 3 #')

## When we are able to read in the file, it is imperative to first look at the output before we continue
## The first output we have are the rows we appended
    ## This provides us with a good overview of the data we have
    ## If you don't want to see this, we can of course comment out the 'print row'
## Here, we notice that the first entry represents the column titles: ['', 'Product', 'Price']
## Of course, this is of no use to us, and therefore we should delete this entry 

del(dataPP[0])

############################
##  read and manipulate 4 ##
############################

print ('# read and manipulate 4 #')

## As we can see, the row numbers are also included in this data, as this is again of no use to us, we can also delete these
## To do so, we can create a loop in which we select each element in the list, and then from these elements we delete the first element, which consists of the row number
## This new list can then be appended to an empty list
## So, at the end, we have a new list with the same information as before, but the row numbers are now deleted

clean = []

for i in range(280):
    needed = dataPP[i]
    del(needed[0])
    clean.append(needed)

dataPP = clean

print ('@@@')
print (len(dataPP)), (dataPP)
print ('@@@')

############################
##  read and manipulate 5 ##
############################

print ('# read and manipulate 5 #')

## When we are now inspecting the data, we see that all info we need is included in the data
## However, we can still see that the data is ordered
    ## We start with product0, product1 follows after that, then product2... until product7
    ## When we want to use this file to determine which price and which product is shown on screen, we need to shuffle the data
        ## Note that shuffling the entire list will not work out: in this way, it could be that product4 is displayed 5 times in a row, as shuffle is a random process
            ## Thus, we want to create blocks, and then shuffle each block
    ## To create blocks in the data, we use the index numbers:
        ## lowerbound is defined as i*8, which means that it will be 0 in the first cycle, 8 in the second cycle..
        ## upperbound is defined as (i+1)*8, which means that it will be 8 in the first cycle, 16 in the second cycle..
        ## For each cycle, we select the part of the list between lowerbound and upperbound, thus, we will select 8 items each time
        ## These parts are then shuffled, and appended to a new list
        ## The elements of the new list are then sampled and appended one by one to a new list, which creates one large list which contains 56 (7*8) items
            ## Look at the difference between the length of 'blocks' and 'trial'
                ## 'Blocks' is a list which contains 7 elements: the collection of 8 product-price combinations that were shuffled earlier
                ## 'trial' is a list which contains all seperate elements that can also be found in Blocks, but now in one big list
## At the end of this process, this large list is ready to be used in the actual experiment execution!
## Additionally, we can convert the obtained list into a dataframe, and write it
    ## In that way, when we analyse the data we obtain from the subjects, we know in what order the product-price combinations were shown to them
    ## Note that the file is also written to the directory we specified earlier, unless we change chdir to a new folder

blocks = []

## 40 because 280 (trials) divided by 7 (blocks) equals 40 

for i in range(40):
    lowerbound = i*8
    upperbound = (i+1)*8
    nodig = dataPP[lowerbound:upperbound]
    
    shuffle(nodig)
    
    blocks.append(nodig)

print ('~~~~')
print (len(blocks)), (blocks)
print ('~~~~')

trial = []

for i in range(40):
    list = blocks[i]
    trial.extend(list)

print ('****')
print (len(trial)), (type(trial)), (trial)
print ('****')

trialdata = pd.DataFrame(trial, columns = ['Block number','Product', 'Price'])

print ('####')
print (trialdata)
print ('####')

mydirectory = '/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Experiment order files'
if (platform.system() == 'Windows'): 
    mydirectory = 'C:' + mydirectory
os.chdir(mydirectory) 

trialdata.to_csv("ProductPrice_Order_PP_%02d.txt" %Subjectnumber, sep = '\t')

#########
## END ##
#########
