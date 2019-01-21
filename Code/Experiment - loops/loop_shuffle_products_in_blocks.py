################################################################
##  Deze loop wordt gebruikt om de MP code 60 keer te runnen  ##
##  Op deze manier worden er 60 randomisatiefiles gemaakt     ##
##  Een voor elke proefpersoon, de files worden genoemd per   ##
##  iteraties, zoals we zien bij 'for nummer'                 ##
################################################################

for Subjectnumber in range(1,61):
    exec(open("C:/Users/Pieter/Dropbox/Academiejaar 2016-2017/Masterproef I/Code/RandomisatieFiles/Code & uitleg/Shuffle_products_in_blocks.py").read())
