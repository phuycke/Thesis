##############
##  Import  ##
##############

from random import randint
from random import randrange, uniform
from random import shuffle

import os
import platform
import random
import numpy as np
import pandas as pd

##############
##  set wd  ##
##############

mydirectory = '/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Randomisation files'
if (platform.system() == 'Windows'): 
    mydirectory = 'C:' + mydirectory

os.chdir(mydirectory) 

#########################
##  Producten ordenen  ##
#########################

## nummer = 1

product0 = [0]*7
product1 = [1]*7
product2 = [2]*7
product3 = [3]*7
product4 = [4]*7
product5 = [5]*7
product6 = [6]*7
product7 = [7]*7

randomProduct = product0 + product1 + product2 + product3 + product4 + product5 + product6 + product7

Product = np.ravel(randomProduct)
Product = list(Product)

print len(Product), Product

for n,i in enumerate(Product):
    if i==0:
        Product[n]='product0'
    if i==1:
        Product[n]='product1'
    if i==2:
        Product[n]='product2'
    if i==3:
        Product[n]='product3'
    if i==4:
        Product[n]='product4'
    if i==5:
        Product[n]='product5'
    if i==6:
        Product[n]='product6'
    if i==7:
        Product[n]='product7'

print len(Product), Product

###################################
##  Producten ordenen in blocks  ##
###################################

block = [0,7,14,21,28,35,42,49]

blockProduct = []

for k in range(5):
    for j in range(7):
        for i in range(8):
            rang = block[i]+j
            nodig = Product[rang]
            blockProduct.append(nodig)

print '@@@'
print len(blockProduct), blockProduct
print '@@@'

############################
##  Prijzen randomiseren  ##
############################

Price = []

prijslijst = [0,1,2,3,4,5,6]
print type(prijslijst), prijslijst

random = list(random.sample(prijslijst, len(prijslijst)))
print type(random), random

random1 = [random[-1]] + random[:-1]
random2 = [random1[-1]] + random1[:-1]
random3 = [random2[-1]] + random2[:-1]
random4 = [random3[-1]] + random3[:-1]
random5 = [random4[-1]] + random4[:-1]
random6 = [random5[-1]] + random5[:-1]
random7 = [random6[-1]] + random6[:-1]

Price = random+random1+random2+random3+random4+random5+random6+random7

print len(Price), Price

for n,i in enumerate(Price):
    if i==0:
        Price[n]='price0'
    if i==1:
        Price[n]='price1'
    if i==2:
        Price[n]='price2'
    if i==3:
        Price[n]='price3'
    if i==4:
        Price[n]='price4'
    if i==5:
        Price[n]='price5'
    if i==6:
        Price[n]='price6'

print len(Price), Price

#################################
##  Prijzen ordenen in blocks  ##
#################################

block = [0,7,14,21,28,35,42,49]

blockPrice = []

for k in range(5):
    for j in range(7):
        for i in range(8):
            rang = block[i]+j
            nodig = Price[rang]
            blockPrice.append(nodig)

print '@@@'
print len(blockPrice), blockPrice
print '@@@'

############################
##  Blok nummers bepalen  ##
############################

blockNumber = []

for k in range(1,6):
    for j in range(len(Price)):
        blockNumber.append(k)

print 'lololol'
print len(blockNumber), blockNumber
print 'lololol'

################################################
## Data NIET geordend volgens blocks          ##
## NOOT: let op de tekens boven de dataframe  ##
################################################

raw_data = {'Product': Product, 'Price': Price}
data = pd.DataFrame(raw_data, columns = ['Product', 'Price'])

print '///'
print data 
print '///'

################################################
## Data WEL geordend volgens blocks           ##
## NOOT: let op de tekens boven de dataframe  ##
################################################

block_data = {'Block number': blockNumber, 'Product': blockProduct, 'Price': blockPrice}
BlockData = pd.DataFrame(block_data, columns = ['Block number','Product', 'Price'])

print '\\'
print BlockData 
print '\\'

##########################
## Write to a data file ##
##########################

BlockData.to_csv("RandomisationFile_PP_%02d.txt" %nummer, sep = '\t')
