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

mydirectory = '/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Shuffled PERVAL'
if (platform.system() == 'Windows'): 
    mydirectory = 'C:' + mydirectory

os.chdir(mydirectory) 

##########################
##  set subject number  ##
##########################

## SubjectNr = 1

#########################
##  Producten ordenen  ##
#########################

product0 = [0]*4
product1 = [1]*4
product2 = [2]*4
product3 = [3]*4
product4 = [4]*4
product5 = [5]*4
product6 = [6]*4
product7 = [7]*4

randomProduct = product0 + product1 + product2 + product3 + product4 + product5 + product6 + product7

Product = np.ravel(randomProduct)
Product = list(Product)

print (len(Product)), (Product)

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

print (len(Product)), (Product)

#######################################
##  Referentieprijs bepalen ordenen  ##
#######################################

prijs0 = ["2.31"]*4
prijs1 = ["1.71"]*4
prijs2 = ["2.00"]*4
prijs3 = ["2.53"]*4
prijs4 = ["1.24"]*4
prijs5 = ["1.42"]*4
prijs6 = ["3.74"]*4
prijs7 = ["3.48"]*4

refPrijs= prijs0 + prijs1 + prijs2 + prijs3 + prijs4 + prijs5 + prijs6 + prijs7

Prijs = np.ravel(refPrijs)
refPrijs = list(Prijs)

print 'test-test-test'
print (len(refPrijs)), (refPrijs)
print 'test-test-test'

####################################
##  Naam product ordenen  ##
####################################

name0 = ["LIPTON ICE TEA (2L)"]*4
name1 = ["COCA COLA (1.5L)"]*4
name2 = ["TIC TAC MINT (100 stuks)"]*4
name3 = ["PHILADELPHIA VERSE KAAS LIGHT (300 gram)"]*4
name4 = ["MINUTE MAID ORANGE (1L)"]*4
name5 = ["LAYS PAPRIKA CHIPS (250 gram)"]*4
name6 = ["HERTA HAM (200 gram)"]*4
name7 = ["HARIBO ZURE KERSEN (500 gram)"]*4

refName= name0 + name1 + name2 + name3 + name4 + name5 + name6 + name7

Name = np.ravel(refName)
refName = list(Name)

print 'test-test-test'
print (len(refName)), (refName)
print 'test-test-test'

######################
##  Vragen ordenen  ##
######################

vragen = []

for i in range(1,5):
    vragen.append(i)

for n,i in enumerate(vragen):
    if i==1:
        vragen[n]='Het product is redelijk geprijsd'
    if i==2:
        vragen[n]='Het product biedt waar voor mijn geld'
    if i==3:
        vragen[n]='Het product is een goed product voor de prijs'
    if i==4:
        vragen[n]='Het product zou voordelig zijn'

Questions = vragen*8
print (len(Questions)), (Questions)

################################################
## Data NIET geordend volgens blocks          ##
## NOOT: let op de tekens boven de dataframe  ##
################################################

raw_data = {'Product': Product,'Name': refName, 'Reference price': refPrijs, 'Questions': Questions}
data = pd.DataFrame(raw_data, columns = ['Product', 'Name', 'Reference price', 'Questions'])

print ('///')
print (data)
print ('///')

data.to_csv("PERVAL_PP_%02d.txt" %SubjectNr, sep = '\t')

ShuffledData = data.sample(frac=1)

print ('%%%')
print (ShuffledData)
print ('%%%')

ShuffledData.to_csv("ShuffledPERVAL_PP_%02d.txt" %SubjectNr, sep = '\t')

#########
## END ##
#########
