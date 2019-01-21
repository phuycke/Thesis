from __future__ import division
from psychopy import core, visual, event

from random import randint
from random import randrange, uniform
from random import shuffle

import random
import datetime
import functools
import time
import datetime
import numpy as np
import pandas as pd

import os 
import csv
import sys

#############################
##  set working directory  ##
#############################

os.chdir('C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Excercise phase') 

############################################
##  Bepaal pp nummer en randomisatiefile  ##
############################################

win = visual.Window(size = (800,600), color='white')
# win = visual.Window(fullscr = True, color='white')

warning = "De verkeerde toets werd ingedrukt! \n \nGebruik enkel de gemarkeerde toetsen! \n \nDruk op een willekeurige knop om verder te gaan."
Fatal = 'Oeps! Er is iets fout gegaan... \n \nRoep de experimentleider.'

warningMessage = visual.TextStim(win, text=warning,units='norm',height=0.12, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)
FatalMessage = visual.TextStim(win, text=Fatal,units='norm',height=0.12, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

proefpersoonNR = 1

dataPP = []

with open("Shuffled_Excercise_PP_%02d.txt" %proefpersoonNR, 'r') as f:
    reader = csv.reader(f, dialect = 'excel', delimiter = '\t')
    for row in reader:
        print row
        dataPP.append(row)

del(dataPP[0])

clean = []

for i in range(56):
    nodig = dataPP[i]
    del(nodig[0])
    clean.append(nodig)

trial = clean

print '@@@'
print len(trial), trial
print '@@@'

###########################
## Fixationcross defined ##
###########################

Fixationcross = visual.TextStim(win, text="+", height=0.12, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

######################################
##  Eigenlijke executie experiment  ##
######################################

os.chdir('C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Antwoord files') 

experiment_data = []
rt = []

with open("Phase_Excercise_PP_%02d_FailSave.txt" %proefpersoonNR, 'w') as f:

    writer = csv.writer(f, delimiter='\t')
    writer.writerow([datetime.datetime.now()])
    writer.writerow(['SubjectNr','Product','Key','RT (in ms)'])

    try:

        for i in range(len(trial)):

            Pathway = "C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/oefenstimuli/"

            Product = trial[i][0]
            Prijs = trial[i][1]

            StimProduct = Pathway + Product + ".png"
            product = visual.ImageStim(win, image= StimProduct)

            StimPrijs = Pathway + Prijs + ".png"
            prijs = visual.ImageStim(win, image= StimPrijs)

            timer =  core.CountdownTimer(.5)
            while timer.getTime() > 0:
                Fixationcross.draw()
                win.flip()

            timer =  core.CountdownTimer(2.5)
            while timer.getTime() > 0:
                product.draw()
                win.flip()

            event.clearEvents()
            win.flip(clearBuffer=True)

            prijs.draw()
            win.flip()
            t1 = int(round(time.time() * 1000))
            
            event.clearEvents()
            answer = event.waitKeys()

            t2 = int(round(time.time() * 1000))

            reactiontime = int(t2-t1)
            print('reactiontime is %d') %reactiontime

            if answer[0] in ['Escape','escape', 'esc']:
                break

            if answer[0] in ['f','j','F','J']:

                writer.writerow([proefpersoonNR,Product,Prijs,answer[0],reactiontime])
                experiment_data.append([proefpersoonNR,Product,Prijs,answer[0],reactiontime])

            elif answer[0] not in ['f','j','F','J']:

                win.flip(clearBuffer=True)
                warningMessage.draw()
                win.flip()

                writer.writerow([proefpersoonNR,Product,Prijs,answer[0],reactiontime])

                experiment_data.append([proefpersoonNR,Product,Prijs,answer[0],reactiontime])

                event.waitKeys()

            win.flip(clearBuffer=True)
            event.clearEvents()

            if i == (len(trial)-1):
                writer.writerow([datetime.datetime.now()])

            time.sleep(1)

    except:

        win.flip(clearBuffer=True)
        FatalMessage.draw()
        win.flip()
        event.waitKeys()

        with open("Phase_Excercise_PP_%02d_LoggingFile.txt" %proefpersoonNR, 'w') as f:

            e1 = sys.exc_info()[0]
            e2 = sys.exc_info()[1]

            writer = csv.writer(f,delimiter=' ')
            writer.writerow([i,e1, e2])

################
## Write data ##
################

expData = pd.DataFrame(experiment_data, columns = ['SubjectNr','Product','Prijs','Key','RT (in ms)'])
print expData

expData.to_csv("Phase_Excercise_PP_%02d.txt" %proefpersoonNR, sep = '\t')