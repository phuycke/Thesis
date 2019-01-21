from __future__ import division
from psychopy import core, visual, event

import pandas as pd
import numpy as np
import os
import time
import datetime

import csv

proefpersoonNR = 1

productList = []

for i in range(7):
    word = 'product%i' %i
    print word
    productList.append(word)

print productList

os.chdir('C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Antwoord files') 

win = visual.Window(fullscr = True, color='white')

Statement0 = "a) Ja, ik koop dit product heel vaak (wekelijks)."
Statement1 = "b) Ja, ik koop dit product vaak (maandelijks)."
Statement2 = "c) Ja, ik koop dit product af en toe (minder dan maandelijks)."
Statement3 = "d) Ja, ik heb dit product ooit al gekocht."
Statement4 = "e) Neen, ik heb dit product nog nooit gekocht."

Statement0_d = visual.TextStim(win, text= Statement0, units = 'norm', color='Black',pos=(0,-.15), height = .05, alignHoriz = 'center', flipHoriz=False)
Statement1_d = visual.TextStim(win, text= Statement1, units = 'norm', color='Black',pos=(0,-.30), height = .05, alignHoriz = 'center', flipHoriz=False)
Statement2_d = visual.TextStim(win, text= Statement2, units = 'norm', color='Black',pos=(0,-.45), height = .05, alignHoriz = 'center', flipHoriz=False)
Statement3_d = visual.TextStim(win, text= Statement3, units = 'norm', color='Black',pos=(0,-.60), height = .05, alignHoriz = 'center', flipHoriz=False)
Statement4_d = visual.TextStim(win, text= Statement4, units = 'norm', color='Black',pos=(0,-.75), height = .05, alignHoriz = 'center', flipHoriz=False)

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

Fatal = 'Oeps! Er is iets fout gegaan... \n \nRoep de experimentleider.'
FatalMessage = visual.TextStim(win, text=Fatal,units='norm',height=0.12, color='Black',pos=[0,0], alignHoriz='center',flipHoriz=False)

experiment_data = []

trialnumber = 0

with open("Phase_Familiarity_PP_%02dFailSave.txt" %proefpersoonNR, 'w') as f:

    writer = csv.writer(f, delimiter='\t')
    writer.writerow([datetime.datetime.now()])
    writer.writerow(['Product','Key','Statement','RT (in ms)'])

    try:

        while trialnumber < len(productList):
            Pathway = "C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/PieterHuycke_paradigma/PieterHuycke/implicit/"

            Product = productList[trialnumber]

            New = Pathway+Product
            Newer = New + "/regular/"

            StimProduct = Newer + Product + ".png"
            product = visual.ImageStim(win, image= StimProduct, pos = [0,.5])

            name = refName[trialnumber]
            name_drawing = visual.TextStim(win, text= name, units = 'norm', color='Black',pos=(0,0), height = .05, alignHoriz = 'center', flipHoriz=False)

            product.draw()
            name_drawing.draw()

            Statement0_d.draw()
            Statement1_d.draw()
            Statement2_d.draw()
            Statement3_d.draw()
            Statement4_d.draw()

            win.flip()

            event.clearEvents()
            FirstKey = event.waitKeys()
            t1 = int(round(time.time() * 1000))

            if FirstKey[0] in ['Escape','escape', 'esc']:
                break

            if FirstKey[0] in ['a','b','c','d','e']:

                answer = FirstKey[0]
                Answered = visual.TextStim(win, text= 'Antwoord: %s' %answer, units = 'norm', color='Black',pos=(0,-.90), height = .05, alignHoriz = 'center', flipHoriz=False)

                product.draw()
                name_drawing.draw()

                Statement0_d.draw()
                Statement1_d.draw()
                Statement2_d.draw()
                Statement3_d.draw()
                Statement4_d.draw()
                Answered.draw()

                win.flip()

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

            elif FirstKey[0] not in ['a','b','c','d','e']:

                win.flip(clearBuffer=True)

                instructions = "Een verkeerde toets werd ingedrukt! \n \nAlleen de 'a'-,'b'-,'c'-,'d'- & 'e'-toets kunnen gebruikt worden! \n \nDruk een willekeurige toets in om verder te gaan."

                warningMessage = visual.TextStim(win, text= instructions, units = 'norm', color='Black',pos=(0,0), height = .08, alignHoriz = 'center', flipHoriz=False)
                warningMessage.draw()

                writer.writerow([Product,FirstKey[0],'Wrong key pressed','Wrong key pressed'])
                experiment_data.append([Product,FirstKey[0],'Wrong key pressed','Wrong key pressed'])

                win.flip()
                event.waitKeys()
                continue

            if trialnumber+1 == len(productList):
                writer.writerow([datetime.datetime.now()])

            trialnumber += 1

    except:

        win.flip(clearBuffer=True)
        FatalMessage.draw()
        win.flip()
        event.waitKeys()

        with open("Phase_Familiarity_PP_%02d_LoggingFile.txt" %proefpersoonNR, 'w') as f:

            e1 = sys.exc_info()[0]
            e2 = sys.exc_info()[1]

            writer = csv.writer(f,delimiter=' ')
            writer.writerow([i,e1, e2])

exp_Familiarity_Data = pd.DataFrame(experiment_data, columns = ['Product','Key','Statement','RT (in ms)'])
print len(exp_Familiarity_Data)
print exp_Familiarity_Data

exp_Familiarity_Data.to_csv("Phase_Familiarity_PP_%02d.txt" %proefpersoonNR, sep = '\t')

