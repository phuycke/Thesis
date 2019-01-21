# -*- coding: utf-8 -*-

#######################################################################################################################################################################################
"""
Created on Tue Oct 10 09:50:20 2017

@author: Pieter Huycke

This code was created for the master thesis of Pieter Huycke
Departement of experimental psychology, Faculty of Psychology, Ghent University
mail: pieter.huycke@ugent.be


editor: Spyder
experiment to be run in Psychopy
Peirce, JW (2007) PsychoPy - Psychophysics software in Python. J Neurosci Methods, 162(1-2):8-13

----------
change:
code can be run on the lab pc
----------

"""
#######################################################################################################################################################################################

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
import math

import os 
import csv
import sys

import webbrowser

#######################################################################################################################################################################################

proefpersoonNR = 60

win_exp = visual.Window(fullscr = True, color='black')

os.chdir('C:/Users/pp02/Desktop/Pieter_Thesis/Code/RandomisatieFiles/Experiment order files') 

dataPP = []

with open("ProductPrice_Order_PP_%02d.txt" %proefpersoonNR, 'r') as f:
    reader = csv.reader(f, dialect = 'excel', delimiter = '\t')
    for row in reader:
        print row
        dataPP.append(row)

del(dataPP[0])

clean = []

for i in range(336):
    nodig = dataPP[i]
    del(nodig[0])
    clean.append(nodig)

trial = clean

print '@@@'
print len(trial), trial
print '@@@'

#######################################################################################################################################################################################

instr9 = 'Hallo, welkom bij dit experiment. \n \n(bij elk scherm waar uitleg wordt gegeven kan je verder gaan door een willekeurige toets in te drukken)'
instr10 = 'Tijdens dit experiment zal je een reeks producten gevolgd door prijzen zien verschijnen. \n \n'
instr11 = 'Na een aantal seconden zal het product verdwijnen en zal je een prijs zien verschijnen. \n \nHet is jouw taak om zo snel mogelijk aan te geven of je deze prijs GOEDKOOP of DUUR vindt voor het product dat je net zag.'
instr12 = 'Als je de prijs GOEDKOOP vindt, druk dan zo snel mogelijk op de "linker"-toets. \n\nAls je de prijs DUUR vindt, druk dan zo snel mogelijk op de "rechter"-toets.'
instr13 = 'Vanaf het moment dat de prijs getoond wordt dien je zo snel mogelijk te drukken. \n\nHet is niet mogelijk om even te oefenen, probeer je dus onmiddellijk te concentreren. Er zijn voldoende pauze voorzien, gebruik deze om wat te rusten.'
instr14 = 'Als alles duidelijk is mag je op een toets naar keuze drukken, en het experiment zal starten na 5 seconden. \n\nAls er nog vragen zijn kan je deze nu stellen aan de proefleider.'

time1 = '1'
time2 = '2'
time3 = '3'
time4 = '4'
time5 = '5'

instrSlow = "Te traag"

EndInstr1 = 'Dit deel is afgelopen is afgelopen. \n \nDruk op een willekeurige toets om verder te gaan naar de vragenlijst.'

Fatal = 'Oeps! Er is iets fout gegaan... \n \nRoep de experimentleider.'

Pause = 'Hier kan je even rusten, druk op een willekeurige knop om verder te gaan. \n \nJe mag zo lang rusten als je zelf wil.'

#######################################################################################################################################################################################

instruction9 = visual.TextStim(win_exp, text=instr9,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction10 = visual.TextStim(win_exp, text=instr10,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction11 = visual.TextStim(win_exp, text=instr11,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction12 = visual.TextStim(win_exp, text=instr12,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction13 = visual.TextStim(win_exp, text=instr13,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction14 = visual.TextStim(win_exp, text=instr14,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

timing1 = visual.TextStim(win_exp, text=time1,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing2 = visual.TextStim(win_exp, text=time2,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing3 = visual.TextStim(win_exp, text=time3,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing4 = visual.TextStim(win_exp, text=time4,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing5 = visual.TextStim(win_exp, text=time5,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

tooSlow = visual.TextStim(win_exp, text=instrSlow,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

EndInstruction1 = visual.TextStim(win_exp, text=EndInstr1,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

FatalMessage = visual.TextStim(win_exp, text=Fatal,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

Fixationcross = visual.TextStim(win_exp, text="+", height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

Pausing = visual.TextStim(win_exp, text=Pause, height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

mouse = event.Mouse(visible = False, newPos = (0,0), win = win_exp)

core.wait(0.5)

#######################################################################################################################################################################################

while True:
    instruction9.draw()
    win_exp.flip()
    event.waitKeys()

    instruction10.draw()
    win_exp.flip()
    event.waitKeys()

    instruction11.draw()
    win_exp.flip()
    event.waitKeys()

    instruction12.draw()
    win_exp.flip()
    event.waitKeys()

    instruction13.draw()
    win_exp.flip()
    event.waitKeys()

    instruction14.draw()
    win_exp.flip()
    event.waitKeys()
    break

while True:
    timing5.draw()
    win_exp.flip()
    time.sleep(1)

    timing4.draw()
    win_exp.flip()
    time.sleep(1)

    timing3.draw()
    win_exp.flip()
    time.sleep(1)

    timing2.draw()
    win_exp.flip()
    time.sleep(1)

    timing1.draw()
    win_exp.flip()
    time.sleep(1)

    break

#######################################################################################################################################################################################

os.chdir('C:/Users/pp02/Desktop/Pieter_Thesis/Code/RandomisatieFiles/Antwoord files') 

experiment_data = []
rt = []
meanRT = []
FaultyTrials = []

breaking = False

with open("1_Phase_1_PP_%02d_FailSave.txt" %proefpersoonNR, 'w') as f:

    writer = csv.writer(f, delimiter='\t')
    writer.writerow([datetime.datetime.now()])
    writer.writerow(['Block number','SubjectNr','Product','Prijs','Key','RT (in ms)','Block RT','SD','resp threshold','TooLate'])

    try:

        for i in range(len(trial)):

            Pathway = "C:/Users/pp02/Desktop/Pieter_Thesis/PieterHuycke_paradigma/PieterHuycke/implicit/"
            
            blocknumber = trial[i][0]
            Product = trial[i][1]
            Prijs = trial[i][2]

            New = Pathway+Product
            Newer = New + "/regular/"

            StimProduct = Newer + Product + ".png"
            product = visual.ImageStim(win_exp, image= StimProduct)

            StimPrijs = Newer + Prijs + ".png"
            prijs = visual.ImageStim(win_exp, image= StimPrijs)

            rectangle = visual.Rect(win_exp, width = .9, height = 1.1, pos=(0,0), fillColor = 'White')

            timer =  core.CountdownTimer(.5)
            while timer.getTime() > 0:
                rectangle.draw()
                Fixationcross.draw()
                win_exp.flip()

            timer =  core.CountdownTimer(2.5)
            while timer.getTime() > 0:
                rectangle.draw()
                product.draw()
                win_exp.flip()

            event.clearEvents()

            rectangle.draw()
            prijs.draw()
            win_exp.flip()
            t1 = int(round(time.time() * 1000))
            
            event.clearEvents()
            answer = event.waitKeys(keyList = ['Escape','escape', 'esc','f','j'])

            t2 = int(round(time.time() * 1000))

            reactiontime = int(t2-t1)
            print('reactiontime is %d') %reactiontime

            rt.append(reactiontime)

            if i == 0 or len(rt)%8 == 0:
                mean = sum(rt)/len(rt)
                meanRT.append(mean)

            BlockRT = meanRT[-1]

            if i < 8:
                standardDev = 0
            else:
                num_items = len(rt)
                mean = sum(rt) / num_items
                differences = [x - mean for x in rt]
                sq_differences = [d ** 2 for d in differences]
                sum_sq = sum(sq_differences)
                variance = sum_sq / (num_items - 1)
                standardDev = math.sqrt(variance)

            print ('We are at trial %d') %i
            respThreshold = (BlockRT + 1.5*standardDev)

            TooLate = 1

            while len(rt)%8 != 0:
                if len(rt) <= 8:
                    BlockRT = "oefenblok"
                    break
                else:
                    if reactiontime > (BlockRT + 1.5*standardDev):
                        win_exp.flip(clearBuffer=True)
                        timer =  core.CountdownTimer(.5)
                        while timer.getTime() > 0:
                            tooSlow.draw()
                            win_exp.flip()
                        break
                    else:
                        break

            if i < 8:
                BlockRT = reactiontime

            if answer[0] in ['Escape','escape', 'esc']:
                break

            if answer[0] in ['f','j']:
                if reactiontime <= (BlockRT + 1.5*standardDev):

                    TooLate = 0

                    writer.writerow([blocknumber,proefpersoonNR,Product,Prijs,answer[0],reactiontime,BlockRT,standardDev,respThreshold,TooLate])

                    experiment_data.append([blocknumber,proefpersoonNR,Product,Prijs,answer[0],reactiontime,BlockRT,standardDev,respThreshold,TooLate])

                else:

                    writer.writerow([blocknumber,proefpersoonNR,Product,Prijs,answer[0],reactiontime,BlockRT,standardDev,respThreshold,TooLate])

                    experiment_data.append([blocknumber,proefpersoonNR,Product,Prijs,answer[0],reactiontime,BlockRT,standardDev,respThreshold,TooLate])

                    FaultyTrials.append(trial[i])

            win_exp.flip(clearBuffer=True)
            event.clearEvents()

            if ((i%56 == 0) and (i != 0)):
                win_exp.flip(clearBuffer=True)
                Pausing.draw()
                win_exp.flip()
                event.waitKeys()

            if i == (len(trial)-1):
                writer.writerow([datetime.datetime.now()])

            time.sleep(1)
            
    except:

        win_exp.flip(clearBuffer=True)
        FatalMessage.draw()
        win_exp.flip()
        event.waitKeys()

        with open("1_Phase_1_PP_%02d_LoggingFile.txt" %proefpersoonNR, 'w') as f:

            e1 = sys.exc_info()[0]
            e2 = sys.exc_info()[1]

            writer = csv.writer(f,delimiter=' ')
            writer.writerow([i,e1, e2])

#######################################################################################################################################################################################

print len(FaultyTrials), FaultyTrials

expData = pd.DataFrame(experiment_data, columns = ['Block number','SubjectNr','Product','Prijs','Key','RT (in ms)','Block RT','SD','resp threshold','TooLate'])
print len(trial)
print expData

expData.to_csv("1_Phase_1_PP_%02d.txt" %proefpersoonNR, sep = '\t')

while not event.getKeys():
    EndInstruction1.draw()
    win_exp.flip()

webbrowser.open('https://goo.gl/forms/6LU2Gb3vYjP7lyYf1')

#######################################################################################################################################################################################

#########
## END ##
#########
