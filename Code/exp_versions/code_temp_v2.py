#####################################################################################################
## Deze code werd geschreven in het kader van de masterproef van Pieter Huycke                      #
## De code werd geschreven in PsychoPy, en is daardoor misschien niet volledig executable in Python #
#####################################################################################################

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

#######################################################################################################################################################################################

# !! Declareren proefpersoon nummer !!

proefpersoonNR = 1

#######################################################################################################################################################################################

# Bepalen window properties

## win_exp = visual.Window(size = (800,600), color='black')
win_exp = visual.Window(fullscr = True, color='black')

#######################################################################################################################################################################################

# Working directory
    # Fase 1
    # Oefenblok

os.chdir('C:/Users/pp02/Desktop/Pieter_Thesis/Code/RandomisatieFiles/Excercise phase') 

#######################################################################################################################################################################################

# Uitlegblok
    # Fase 1
    # Experimental block

# In dit deel zien de participanten een aantal producten die kunnen gekochten worden in de winkel
# Daarbovenop worden prijzen getoond vlak na het verschijnen van de producten
# De participanten moeten aanduiden of de prijs die ze zien DUUR of GOEDKOOP is voor het product dat ze zien VLAK VOOR de prijs
# De bedoeling is dat ze zo snel als mogelijk reageren op de prijs door gebruik te maken van de 'f' en 'j' toets 
    ## (die worden afgeplakt in het lab zelf (er wordt verwezen naar de toetsen als 'rechts/links') )
    # De escape toets kan gebruikt worden om te ontsnappen uit het experiment
# De verwachting is dat participanten:
    # sneller reageren op goedkopere vs. duurdere prijzen
    # sneller op extremere prijzen (price1, 2, 5 & 6)
# Zowel de reactietijden als de response die ze geven worden geregistreerd en weggeschreven

# In dit deel krijgen de participanten de kans om zo snel als mogelijk te reageren
# Ze kunnen enkel reageren met de f en j toets, de andere toetsen werken niet (los van de 'escape', die kan gebruikt worden als break)
# Reactietijden worden gemeten voor iedere trial, en weggeschreven naar een list

# In dit experiment wordt gebruik gemaakt van een adaptieve response threshold:
    # Op basis van hun reactietijd wordt een response deadline ingesteld
    # Dus, hoe trager ze zijn, hoe langer zijn krijgen voor hun antwoord als 'te traag' wordt beschouwd
    # Dit werd gedaan met het oog op de variatie in reactiesnelheid binnen de populatie

# In totaal zijn er 336 trials, waarbij de participanten iedere combinatie van alle 8 producten en 7 prijzen 6 keer ziet
    # Zo komen we aan 56 (7*8) prijs-product combinaties, die we elk 6 keer zien, dus 56*6 = 336 trials

# De randomisatiefiles van dit experiment werden op voorhand gemaakt, waarbij de gerandomiseerde volgorde van de producten & prijzen wordt ingelezen vanuit een externe file
# Dit werd gedaan om de pc niet extra te belasten met het berekenen van een randomisatie

#######################################################################################################################################################################################

# Working directory
    # Fase 1
    # Experimental block

os.chdir('C:/Users/pp02/Desktop/Pieter_Thesis/Code/RandomisatieFiles/Experiment order files') 

#######################################################################################################################################################################################

# Inlezen en verwerken van file
    # Randomisation file
    # Fase 1
    # Experimental block

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

# Definities
    # Fase 1
    # Experimental block

# Declareren tekst input

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

EndInstr1 = 'Dit deel is afgelopen is afgelopen. \n \nDruk op een willekeurige toets om verder te gaan met het volgende gedeelte.'

Fatal = 'Oeps! Er is iets fout gegaan... \n \nRoep de experimentleider.'

Pause = 'Hier kan je even rusten, druk op een willekeurige knop om verder te gaan. \n \nJe mag zo lang rusten als je zelf wil.'

# Declareren van PsychoPy text properties

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

#######################################################################################################################################################################################

# Muis onzichtbaar maken

mouse = event.Mouse(visible = False, newPos = (0,0), win = win_exp)

# Tonen van instructies aan participanten

core.wait(0.5)

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

#######################################################################################################################################################################################

# Aftellen

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

# Executie van experiment
    # Fase 1
    # Experimental block

os.chdir('C:/Users/pp02/Desktop/Pieter_Thesis/Code/RandomisatieFiles/Antwoord files') 

experiment_data = []
rt = []
meanRT = []
FaultyTrials = []

breaking = False

with open("1_Phase_1_PP_%02d_FailSave.txt" %proefpersoonNR, 'w') as f:

    writer = csv.writer(f, delimiter='\t')
    writer.writerow([datetime.datetime.now()])
    writer.writerow(['Block number','SubjectNr','Product','Prijs','Key','RT (in ms)','Block RT','TooLate'])

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

            timer =  core.CountdownTimer(.5)
            while timer.getTime() > 0:
                Fixationcross.draw()
                win_exp.flip()

            timer =  core.CountdownTimer(1.5)
            while timer.getTime() > 0:
                product.draw()
                win_exp.flip()

            event.clearEvents()
            win_exp.flip(clearBuffer=True)

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

            print ('We are at trial %d') %i

            TooLate = 1

            while len(rt)%8 != 0:
                if len(rt) <= 8:
                    BlockRT = "oefenblok"
                    break
                else:
                    if reactiontime > BlockRT:
                        win_exp.flip(clearBuffer=True)
                        timer =  core.CountdownTimer(.5)
                        while timer.getTime() > 0:
                            tooSlow.draw()
                            win_exp.flip()
                        break
                    else:
                        break

            if answer[0] in ['Escape','escape', 'esc']:
                break

            if answer[0] in ['f','j']:
                if reactiontime <= BlockRT:

                    TooLate = 0

                    writer.writerow([blocknumber,proefpersoonNR,Product,Prijs,answer[0],reactiontime,BlockRT,TooLate])

                    experiment_data.append([blocknumber,proefpersoonNR,Product,Prijs,answer[0],reactiontime,BlockRT,TooLate])

                else:

                    writer.writerow([blocknumber,proefpersoonNR,Product,Prijs,answer[0],reactiontime,BlockRT,TooLate])

                    experiment_data.append([blocknumber,proefpersoonNR,Product,Prijs,answer[0],reactiontime,BlockRT,TooLate])

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

            time.sleep(1.5)

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

# Wegschrijven data
    # Fase 1
    # Experimental block

print len(FaultyTrials), FaultyTrials

expData = pd.DataFrame(experiment_data, columns = ['Block number','SubjectNr','Product','Prijs','Key','RT (in ms)','Block RT','TooLate'])
print len(trial)
print expData

expData.to_csv("1_Phase_1_PP_%02d.txt" %proefpersoonNR, sep = '\t')

# Tonen van 'end message' van deze fase

while not event.getKeys():
    EndInstruction1.draw()
    win_exp.flip()

#######################################################################################################################################################################################

# Uitlegblok
    # Fase 2
    # Familiariteit

# In dit blok krijgen de participanten ieder product te zien dat ze zagen in de eerste fase van het experiment (er waren toen 8 verschillende producten te zien)
# De bedoeling is om aan te duiden hoe zeer te participanten vertrouwd zijn met de producten die ze zagen
# Er zijn 5 opties:
    # "a) Ja, ik koop dit product heel vaak (wekelijks)."
    # "b) Ja, ik koop dit product vaak (maandelijks)."
    # "c) Ja, ik koop dit product af en toe (minder dan maandelijks)."
    # "d) Ja, ik heb dit product ooit al gekocht."
    # "e) Neen, ik heb dit product nog nooit gekocht."
# Door middel van het gebruik van de bijhorende toetsen (als je iets wekelijks koopt moet je de 'a' toets indrukken) kan je aanduiden welk statement het beste past

# Op deze manier willen we nagaan in welke mate mensen het product kennen

# Als de verkeerde toets wordt ingedrukt, dan krijgen de participanten de kans om opnieuw te drukken

# Als de participant van antwoord wil veranderen, dan drukken ze gewoon opnieuw op de toets, en dan op enter

# Het antwoord dat na 'Antwoord : ' staat zal pas weggeschreven worden als er op 'enter' wordt geduwd

#######################################################################################################################################################################################

#######################################################################################################################################################################################

# Definities
    # Fase 2
    # Familiariteit

# Declareren tekst input

instrFam1 = 'In de volgende fase kan je aanduiden in hoe verre je vertrouwd bent met de producten die je daarnet zag.'
instrFam2 = 'Telkens zal je onder het product 5 statements zien. \n \nJe kan een statement selecteren door te drukken op de toets op het keyboard dat overeenkomt met het statement. \n \n'
instrFam3 = 'Bijvoorbeeld: als je een product wekelijks koopt, dan kan je dit aanduiden door op de "a"-toets te drukken op het keyboard. \n\nDruk daarna op de "enter"-toets om jouw antwoord te bevestigen.'
instrFam4 = 'Als je een fout maakte, dan kan je gewoon herdrukken, het antwoord wordt pas gevalideerd als onderaan  "antwoord = " verschijnt, en je dan op "enter" duwt.'
instrFam5 = 'Hier hoef je je niet te haasten, dus denk goed na voor je jouw antwoord valideert.'
instrFam6 = 'Als alles duidelijk is mag je op een toets naar keuze drukken, en het volgende gedeelte zal starten na 5 seconden. \n \nAls er nog vragen zijn kan je deze nu stellen aan de proefleider.'

time1 = '1'
time2 = '2'
time3 = '3'
time4 = '4'
time5 = '5'

Statement0 = "a) Ja, ik koop dit product heel vaak (wekelijks)."
Statement1 = "b) Ja, ik koop dit product vaak (maandelijks)."
Statement2 = "c) Ja, ik koop dit product af en toe (minder dan maandelijks)."
Statement3 = "d) Ja, ik heb dit product ooit al gekocht."
Statement4 = "e) Neen, ik heb dit product nog nooit gekocht."

EndInstr2 = 'Dit deel is afgelopen is afgelopen. \n \nDruk op een willekeurige toets om verder te gaan met het volgende gedeelte.'

Fatal = 'Oeps! Er is iets fout gegaan... \n \nRoep de experimentleider.'

name0 = ["LIPTON ICE TEA (2L)"]
name1 = ["COCA COLA (1.5L)"]
name2 = ["TIC TAC MINT (100 stuks)"]
name3 = ["PHILADELPHIA VERSE KAAS LIGHT (300 gram)"]
name4 = ["MINUTE MAID ORANGE (1L)"]
name5 = ["LAYS PAPRIKA CHIPS (250 gram)"]
name6 = ["HERTA HAM (200 gram)"]
name7 = ["HARIBO ZURE KERSEN (500 gram)"]

refName= name0 + name1 + name2 + name3 + name4 + name5 + name6 + name7

Name = np.ravel(refName)
refName = list(Name)

# Declareren van PsychoPy text properties

instructionFam1 = visual.TextStim(win_exp, text=instrFam1,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instructionFam2 = visual.TextStim(win_exp, text=instrFam2,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instructionFam3 = visual.TextStim(win_exp, text=instrFam3,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instructionFam4 = visual.TextStim(win_exp, text=instrFam4,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instructionFam5 = visual.TextStim(win_exp, text=instrFam5,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instructionFam6 = visual.TextStim(win_exp, text=instrFam6,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

timing1 = visual.TextStim(win_exp, text=time1,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing2 = visual.TextStim(win_exp, text=time2,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing3 = visual.TextStim(win_exp, text=time3,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing4 = visual.TextStim(win_exp, text=time4,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing5 = visual.TextStim(win_exp, text=time5,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

Statement0_d = visual.TextStim(win_exp, text= Statement0, units = 'norm', color='White',pos=(0,-.15), height = .05, alignHoriz = 'center', flipHoriz=False)
Statement1_d = visual.TextStim(win_exp, text= Statement1, units = 'norm', color='White',pos=(0,-.30), height = .05, alignHoriz = 'center', flipHoriz=False)
Statement2_d = visual.TextStim(win_exp, text= Statement2, units = 'norm', color='White',pos=(0,-.45), height = .05, alignHoriz = 'center', flipHoriz=False)
Statement3_d = visual.TextStim(win_exp, text= Statement3, units = 'norm', color='White',pos=(0,-.60), height = .05, alignHoriz = 'center', flipHoriz=False)
Statement4_d = visual.TextStim(win_exp, text= Statement4, units = 'norm', color='White',pos=(0,-.75), height = .05, alignHoriz = 'center', flipHoriz=False)

EndInstruction2 = visual.TextStim(win_exp, text=EndInstr1,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

FatalMessage = visual.TextStim(win_exp, text=Fatal,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

#######################################################################################################################################################################################

# Tonen van instructies aan participanten

core.wait(0.5)

while True:
    instructionFam1.draw()
    win_exp.flip()
    event.waitKeys()

    instructionFam2.draw()
    win_exp.flip()
    event.waitKeys()

    instructionFam3.draw()
    win_exp.flip()
    event.waitKeys()

    instructionFam4.draw()
    win_exp.flip()
    event.waitKeys()

    instructionFam5.draw()
    win_exp.flip()
    event.waitKeys()

    instructionFam6.draw()
    win_exp.flip()
    event.waitKeys()
    break

#######################################################################################################################################################################################

# Aftellen

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

# Klaarmaken voor executie
    # Fase 2
    # Familiariteit

productList = []

for i in range(7):
    word = 'product%i' %i
    print word
    productList.append(word)

print productList

experiment_data = []

#######################################################################################################################################################################################

# Executie van experiment
    # Fase 2
    # Familiariteit

trialnumber = 0

os.chdir('C:/Users/pp02/Desktop/Pieter_Thesis/Code/RandomisatieFiles/Antwoord files') 

with open("2_Phase_Familiarity_PP_%02d_FailSave.txt" %proefpersoonNR, 'w') as f:

    writer = csv.writer(f, delimiter='\t')
    writer.writerow([datetime.datetime.now()])
    writer.writerow(['Product','Key','Statement','RT (in ms)'])

    try:

        while trialnumber < len(productList):
            Pathway = "C:/Users/pp02/Desktop/Pieter_Thesis/PieterHuycke_paradigma/PieterHuycke/implicit/"

            Product = productList[trialnumber]

            New = Pathway+Product
            Newer = New + "/regular/"

            StimProduct = Newer + Product + ".png"
            product = visual.ImageStim(win_exp, image= StimProduct, pos = [0,.5])

            name = refName[trialnumber]
            name_drawing = visual.TextStim(win_exp, text= name, units = 'norm', color='White',pos=(0,0), height = .05, alignHoriz = 'center', flipHoriz=False)

            product.draw()
            name_drawing.draw()

            Statement0_d.draw()
            Statement1_d.draw()
            Statement2_d.draw()
            Statement3_d.draw()
            Statement4_d.draw()

            win_exp.flip()

            event.clearEvents()
            FirstKey = event.waitKeys(keyList = ['Escape','escape', 'esc','a','b','c','d','e'])
            t1 = int(round(time.time() * 1000))

            if FirstKey[0] in ['Escape','escape', 'esc']:
                break

            if FirstKey[0] in ['a','b','c','d','e']:

                answer = FirstKey[0]
                Answered = visual.TextStim(win_exp, text= 'Antwoord: %s' %answer, units = 'norm', color='White',pos=(0,-.90), height = .05, alignHoriz = 'center', flipHoriz=False)

                product.draw()
                name_drawing.draw()

                Statement0_d.draw()
                Statement1_d.draw()
                Statement2_d.draw()
                Statement3_d.draw()
                Statement4_d.draw()
                Answered.draw()

                win_exp.flip()

                statement = []

                if FirstKey[0] == 'a':
                    statement.append(Statement0)
                if FirstKey[0] == 'b':
                    statement.append(Statement1)
                if FirstKey[0] == 'c':
                    statement.append(Statement2)
                if FirstKey[0] == 'd':
                    statement.append(Statement3)
                if FirstKey[0] == 'e':
                    statement.append(Statement4)

                SecondKey = event.waitKeys()
                t2 = int(round(time.time() * 1000))

                reactiontime = int(t2-t1)

                if SecondKey[0] in ['return']:
                    writer.writerow([Product,FirstKey[0],statement[0],reactiontime])
                    experiment_data.append([Product,FirstKey[0],statement[0],reactiontime])
                else:
                    continue

            if trialnumber+1 == len(productList):
                writer.writerow([datetime.datetime.now()])

            trialnumber += 1

    except:

        win_exp.flip(clearBuffer=True)
        FatalMessage.draw()
        win_exp.flip()
        event.waitKeys()

        with open("2_Phase_Familiarity_PP_%02d_LoggingFile.txt" %proefpersoonNR, 'w') as f:

            e1 = sys.exc_info()[0]
            e2 = sys.exc_info()[1]

            writer = csv.writer(f,delimiter=' ')
            writer.writerow([i,e1, e2])

exp_Familiarity_Data = pd.DataFrame(experiment_data, columns = ['Product','Key','Statement','RT (in ms)'])
print len(exp_Familiarity_Data)
print exp_Familiarity_Data

exp_Familiarity_Data.to_csv("2_Phase_Familiarity_PP_%02d.txt" %proefpersoonNR, sep = '\t')

#######################################################################################################################################################################################

# Tonen van 'end message' van deze fase

while not event.getKeys():
    EndInstruction2.draw()
    win_exp.flip()

#######################################################################################################################################################################################

# Uitlegblok
    # Fase 2
    # PERVAL

# In dit blok krijgen de participanten nog eens ieder product te zien, maar dan met de prijs er bij
# De participanten duiden vervolgens aan hoe eens ze het zijn met een bepaald statement 
    # Ieder statement dat ze te zien krijgen behoort tot de PERVAL schaal, meer bepaald de dimensie 'price'
# De prijs die getoond wordt bij het product is de prijs die je normaal zou te zien krijgen in de winkel
    # In ons geval is dit prijs '3', omdat prijzen 0,1 & 2 lager liggen, en prijzen 4,5 & 6 hoger liggen dan deze prijs

# Door middel van een muisklik op de schaal duiden de participanten aan hoe eens ze het zijn met een statement
    # 1 wil zeggen dat ze 'helemaal oneens' zijn
    # 7 wil zeggen dat ze 'helemaal eens' zijn

#######################################################################################################################################################################################

# Working directory
    # Fase 2
    # PERVAL

os.chdir('C:/Users/pp02/Desktop/Pieter_Thesis/Code/RandomisatieFiles/Shuffled PERVAL') 

#######################################################################################################################################################################################

# Inlezen en verwerken van file
    # Shuffled PERVAL
    # Fase 2
    # PERVAL

dataShuffle = []

with open("PERVAL_PP_%02d.txt" %proefpersoonNR, 'r') as f:
    reader = csv.reader(f, dialect = 'excel', delimiter = '\t')
    for row in reader:
        print row
        dataShuffle.append(row)

del(dataShuffle[0])

clean = []

for i in range(len(dataShuffle)):
    nodig = dataShuffle[i]
    del(nodig[0])
    clean.append(nodig)

trialShuffle = clean

print '@@@'
print len(trialShuffle), trialShuffle
print '@@@'

#######################################################################################################################################################################################

# Definities
    # Fase 1
    # Experiment first attempt

# Declareren tekst input

core.wait(0.5)

instr15 = 'Welkom bij het laatste deel van dit experiment! \n \nOpnieuw kan je op een willekeurige toets drukken om verder te gaan.'
instr16 = 'In dit deel hoef je aan te duiden hoe eens je het bent met een bepaald statement. \n \nDe statements die je ziet zullen steeds over het product gaan dat je net voor het statement zag. '
instr17 = 'Eerst verschijnt een van de producten die je hebt gezien in deel 1. \n \nHieronder staat de naam van het product, de winkelprijs van het product, een statement, en een schaal.'
instr18 = 'Duid vervolgens met je muis aan hoe eens je het bent met het statement door te drukken op de schaal. \n \n"1" wil zeggen dat je het HELEMAAL ONEENS bent, "7" wil zeggen dat je het HELEMAAL EENS bent.'
instr19 = 'Als je zeker bent van je selectie mag je op de "OK" toets drukken. \n \nJe mag werken op je eigen tempo, al raden we aan niet te lang te denken over de statements.'
instr20 = 'Als alles duidelijk is mag je op een toets naar keuze drukken, en het experiment zal starten na 5 seconden. \n \nAls er nog vragen zijn kan je deze nu stellen aan de proefleider!'

EndInstr2 = 'Dit was het laatste gedeelte! \n \nBedankt voor je deelname aan dit experiment!'

BelowText = 'Kies 1 als je HELEMAAL ONEENS bent met het volgende statement \n \nKies 1 als je HELEMAAL EENS bent met het volgende statement'

time6 = '1'
time7 = '2'
time8 = '3'
time9 = '4'
time10 = '5'

# Declareren van PsychoPy text properties

instruction15 = visual.TextStim(win_exp, text=instr15,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction16 = visual.TextStim(win_exp, text=instr16,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction17 = visual.TextStim(win_exp, text=instr17,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction18 = visual.TextStim(win_exp, text=instr18,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction19 = visual.TextStim(win_exp, text=instr19,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
instruction20 = visual.TextStim(win_exp, text=instr20,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

EndInstruction2 = visual.TextStim(win_exp, text=EndInstr2,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

BelowProd = visual.TextStim(win_exp, text=BelowText, units = 'norm', color='White',pos=(0,-.5), height = .05, flipHoriz=False)

timing6 = visual.TextStim(win_exp, text=time1,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing7 = visual.TextStim(win_exp, text=time2,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing8 = visual.TextStim(win_exp, text=time3,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing9 = visual.TextStim(win_exp, text=time4,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)
timing10 = visual.TextStim(win_exp, text=time5,units='norm',height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

Fixationcross = visual.TextStim(win_exp, text="+", height=0.12, color='White',pos=[0,0], alignHoriz='center',flipHoriz=False)

#######################################################################################################################################################################################

# Tonen van instructies aan participanten

while True:
    instruction15.draw()
    win_exp.flip()
    event.waitKeys()

    instruction16.draw()
    win_exp.flip()
    event.waitKeys()

    instruction17.draw()
    win_exp.flip()
    event.waitKeys()

    instruction18.draw()
    win_exp.flip()
    event.waitKeys()

    instruction19.draw()
    win_exp.flip()
    event.waitKeys()

    instruction20.draw()
    win_exp.flip()
    event.waitKeys()
    break

#######################################################################################################################################################################################

# Aftellen

while True:
    timing10.draw()
    win_exp.flip()
    time.sleep(1)

    timing9.draw()
    win_exp.flip()
    time.sleep(1)

    timing8.draw()
    win_exp.flip()
    time.sleep(1)

    timing7.draw()
    win_exp.flip()
    time.sleep(1)

    timing6.draw()
    win_exp.flip()
    time.sleep(1)

    break

#######################################################################################################################################################################################

# Executie van experiment
    # Fase 2
    # PERVAL

win_exp.flip(clearBuffer=True)
event.clearEvents()

os.chdir('C:/Users/pp02/Desktop/Pieter_Thesis/Code/RandomisatieFiles/Antwoord files') 

perval_data = []
rt_data = []

experiment_DataShuffle = []

mouse = event.Mouse(visible = True, newPos = (0,0), win = win_exp)

with open("3_Phase_2_PP_%02d_FailSave.txt" %proefpersoonNR, 'w') as f:

    writer = csv.writer(f, delimiter='\t')
    writer.writerow([datetime.datetime.now()])
    writer.writerow(['SubjectNr','Product','Statement','Number','RT (in ms)'])

    try:

        for i in range(len(trialShuffle)):

            Pathway = "C:/Users/pp02/Desktop/Pieter_Thesis/PieterHuycke_paradigma/PieterHuycke/implicit/"

            Product = trialShuffle[i][0]
            refName = trialShuffle[i][1]
            refPrice = trialShuffle[i][2]
            Text = trialShuffle[i][3]

            New = Pathway+Product
            Newer = New + "/regular/"

            StimProduct = Newer + Product + ".png"
            product = visual.ImageStim(win_exp, image= StimProduct, pos = [0,.4])

            ReferenceName = visual.TextStim(win_exp, text= "%s" %refName, units = 'norm', color='White',pos=(0,-.15), height = .08, flipHoriz=False)
            ReferencePrice = visual.TextStim(win_exp, text= "%s euro" %refPrice, units = 'norm', color='White',pos=(0,-.30), height = .08, flipHoriz=False)

            rectangle = visual.Rect(win_exp, width = .05, height = .05, pos=(.85,.85), fillColor = 'springgreen')

            rating_scale = visual.RatingScale(win_exp, acceptPreText="", acceptText = "Ok",labels=["1","4","7"],size = 1, pos=(0,-.6), textColor = 'white', lineColor = 'white', showValue= False, markerColor = 'blue')
            rating_scale.setDescription(Text)

            timer =  core.CountdownTimer(.5)
            while timer.getTime() > 0:
                Fixationcross.draw()
                win_exp.flip()

            BreakingOut = 0

            rating_scale.reset()
            while rating_scale.noResponse:

                rectangle.draw()

                product.draw()
                ReferenceName.draw()
                ReferencePrice.draw()
                rating_scale.draw()
                win_exp.flip()
                if mouse.isPressedIn(rectangle):
                    BreakingOut = 1
                    break

            if BreakingOut == 1:
                break

            rating = rating_scale.getRating()
            rt = rating_scale.getRT()

            perval_data.append(rating)
            rt_data.append(rt)

            writer.writerow([proefpersoonNR,Product,Text, perval_data[i], rt_data[i]])
            experiment_DataShuffle.append([proefpersoonNR,Product,Text, perval_data[i], rt_data[i]])

            win_exp.flip(clearBuffer=True)
            event.clearEvents()

            if i == (len(trialShuffle)-1):
                writer.writerow([datetime.datetime.now()])

            time.sleep(1)

    except:

        win_exp.flip(clearBuffer=True)
        FatalMessage.draw()
        win_exp.flip()
        event.waitKeys()

        with open("3_Phase_2_PP_%02d_LoggingFile.txt" %proefpersoonNR, 'w') as f:

            e1 = sys.exc_info()[0]
            e2 = sys.exc_info()[1]

            writer = csv.writer(f,delimiter=' ')
            writer.writerow([i,e1, e2])

#######################################################################################################################################################################################

# Wegschrijven data
    # Fase 2
    # PERVAL

expDataPERVAL = pd.DataFrame(experiment_DataShuffle, columns = ['SubjectNr','Product','Statement','Number','RT (in ms)'])
print (expDataPERVAL)

expDataPERVAL.to_csv("3_Phase_2_PP_%02d.txt" %proefpersoonNR, sep = '\t')

#######################################################################################################################################################################################

# Tonen van 'end message' van deze fase

while not event.getKeys():
    EndInstruction2.draw()
    win_exp.flip()

#######################################################################################################################################################################################

#########
## END ##
#########
