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

mydirectory = '/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Excercise phase'
if (platform.system() == 'Windows'): 
    mydirectory = 'C:' + mydirectory

os.chdir(mydirectory) 

#########################
##  Producten ordenen  ##
#########################

## nummer = 1

products1 = []

for i in range(1,29):
    product = 'product%d' %i
    products1.append(product)

products2 = []

for i in range(1,29):
    product = 'product%d' %i
    products2.append(product)

products = products1+products2

Products = np.ravel(products)
exc_Products = list(Products)

print '---'
print exc_Products
print '---'

#######################
##  Prijzen ordenen  ##
#######################

prices_cheap = []

for i in range(1,29):
    price = 'product%d_chp' %i
    prices_cheap.append(price)

print prices_cheap

prices_expensive = []

for i in range(1,29):
    price = 'product%d_exp' %i
    prices_expensive.append(price)

print prices_expensive

prices = prices_cheap + prices_expensive

Prices = np.ravel(prices)
exc_Prices = list(Prices)

print '---'
print exc_Prices
print '---'

data = {'Product': exc_Products, 'Price': exc_Prices}
Data = pd.DataFrame(data, columns = ['Product','Price'])

print '****'
print Data
print '****'

Data.to_csv("Excercise_PP_%02d.txt" %nummer, sep = '\t')

ShuffledData = Data.sample(frac=1)

print '////'
print ShuffledData
print '////'

ShuffledData.to_csv("Shuffled_Excercise_PP_%02d.txt" %nummer, sep = '\t')

