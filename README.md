
## Model - January 2019

[![GitHub license](https://img.shields.io/apm/l/test.svg)](https://github.com/CogComNeuroSci/Pieter_H/blob/master/LICENSE)
[![Python version](https://img.shields.io/badge/Python-3.7.0-blue.svg)](https://img.shields.io/badge/Python-3.7.0-blue.svg)
[![Spyder version](https://img.shields.io/badge/Spyder-3.3.2-red.svg)](https://img.shields.io/badge/Spyder-3.3.2-red.svg)
[![Build version](https://img.shields.io/badge/build-experimental-orange.svg)](https://img.shields.io/badge/build-experimental-orange.svg)


## First some explanation

This README explains how the three scripts included in [this directory][code] lead to a sensical output.  
However, before referring to the actual code, we will first explain what our goal was, and what we expected to find using our code.  

[code]: https://github.com/CogComNeuroSci/Pieter_H/tree/master/PhD/Year%201%20(2018%20-%202019)/Code/Huycke/SERVER

**Our aim**  
To create a simulation of a participant performing a simple [Stroop task][Stroop].  
In our initial modelling attempts, we aimed to investigate how performance on this Stroop task differed depending on several mechanisms that might be observed during learning.

[Stroop]: https://en.wikipedia.org/wiki/Stroop_effect

Specifically, we aimed to investigate the impact of two mechanisms:

    * Rescorla-Wagner learning
    * Binding by random bursts

**Explaining some concepts**  

`Rescorla-Wagner (RW) learning`:  
The mechanism where weights between the input units and the output units in a connectionist model are altered during learning.  
Specifically, the weights between the layers are altered when the output of the model differs from the expected / desired output (i.e. when the model is wrong = saying '**green**' when it should have been '**red**').  
Thus, RW learning is an instance of supervised learning. The idea is that these weight alterations will lead to an improvement when it comes to performance (the weights are altered using the provided feedback). Thus, more learning experience will lead to more 'robust' weight changes (weight changes that make sense).  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --> Performance increases with more learning experience.

_Reference_:  
Rescorla, R. A., & Wagner, A. R. (1972). A theory of Pavlovian conditioning: Variations in the effectiveness of
reinforcement   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;and nonreinforcement. Classical conditioning II: Current research and theory, 2, 64-99.

---

`Binding by random bursts`:  
In short, synchrony between two different brain areas / processing areas can be achieved by a random theta frequency-locked neural burst that is sent to both areas. The choice of areas that receive this burst is determined by lateral frontal cortex (thus functioning as a controller in this case). As a result of this synchrony, communication between the two areas becomes more efficient. The conclusion here is that this improved communcation between brain areas will also lead to better performance when task-relevant brain areas become synchronised due to these random bursts.  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --> Performance increases when bursts are given that synchronize the relevant brain areas.

_Reference_:  
Verguts, T. (2017). Binding by random bursts: A computational model of cognitive control.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Journal of cognitive neuroscience, 29(6), 1103-1118.

**Our hypothesis**  
We aimed to look at the deviations in performance across four different conditions:  


  1. Burst NO &nbsp;&nbsp;- RW NO
  2. Burst NO &nbsp;&nbsp;- RW YES
  3. Burst YES - RW NO
  4. Burst YES - RW YES


We also looked at several measures:  

    * Accuracy
        * How often is the model correct when making a decision between GREEN or RED
    * Rate of Success:
        * Activation of the most active output unit / the sum of the activation of all output units
    * Reaction time (in ms):
        * How long does it take for one of the output units to reach a certain activation threshold?
    * Norm of the weights:
        * The sum of the squared weights (four weight numbers, as there are two input units and two output units)
    * Theta power:
        * Squared activation levels of the MFC
            * Across trials
            * Across time steps
            
All measures are plotted and saved as `.png` files using Python.  

---

## The programming part

We used `Python 3` (version 3.7.0) as main programming language.  
As editor, we opted for `Spyder` (version 3.3.2) integrated in the [Anaconda environment][Anaconda].  

[Anaconda]: https://www.anaconda.com/download/

__Required modules__:

    * matplotlib.pyplot (2.2.3) 
    * numpy (1.15.1)
    * os
    * time
    * warnings

All can be installed in the _Anaconda environment_ by typing the following the _Anaconda prompt_:  
`conda install moduleName`

__Required Python files__:

    * model_script.py
        * The code that contains the model, this code outputs all our results (accuracies, RT measures ...)
    * model_run.py
        * Helper code to create a decent folder structure and loop over all possibilities ( RW N/Y x Bursts N/Y )
        * This code relies on a specific folder structure that I explain immediately below
        * By default, this script will run each combination of RW and Burst 250 times
            * Thus, we have several instances of a certain situation
            * This allows us to draw more valid conclusions about our model and its properties
    * plot_results.py
        * Plots the results saved by model_run.py
            * This again relies on a specific folder structure

__Symbolic links__:   
[model_script.py][model_script]   
[model_run.py][model_run]   
[plot_results.py][plot_results]   

[model_script]: https://github.com/CogComNeuroSci/Pieter_H/blob/master/PhD/Year%201%20(2018%20-%202019)/Code/Huycke/SERVER/model_script.py
[model_run]: https://github.com/CogComNeuroSci/Pieter_H/blob/master/PhD/Year%201%20(2018%20-%202019)/Code/Huycke/SERVER/model_run.py
[plot_results]: https://github.com/CogComNeuroSci/Pieter_H/blob/master/PhD/Year%201%20(2018%20-%202019)/Code/Huycke/SERVER/plot_results.py

_All three Python scripts are needed for a successful simulation run!_  

__Required folder structure__:  

$HOME_DIR = the directory that is considered to be the 'home directory'  
This directory contains the following folders:  

    * Code
        * Contains the three "Required Python files"
    * Figures
        * An empty folder, for now...

`model_script.py`:  
Does **not** rely on path definitions.  

`model_run.py`:  
Relies on the HOME_DIR, as it loads relevant code from the Code directory.  
This script will create **four** additional folders in your HOME_DIR, each filled with an additional X folders.  
The X is determined by the amount of simulations you decide to run, so if you leave everything untouched, you will have 250 folders within each of the four newly created folders.  
! Note that you have to manually change the variable HOME_DIR in `model_script.py` to an existing path. !

`plot_results.py`:  
Relies on the$HOME_DIR to `cd` to the Figures folder.  
There it will save the created figures in the `.png` format, as mentioned above.

! Note that you have to manually change the variable HOME_DIR in `plot_results.py` to an existing path. !

## Conclusion

One can run all scripts with minor adaptations, as the code is able to execute without user input.  
The only thing that should be defined by the user is the HOME_DIR (i.e. the directory where the data will be stored, and where the folder containing the Python scripts can be found).  

## Author

---

Pieter Huycke  

Mail: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Pieter.Huycke@UGent.be](mailto:Pieter.Huycke@UGent.be)  
GitHub: [@phuycke][GitHub]

[GitHub]: https://github.com/phuycke

PhD student @ [Verguts lab][Labsite].  

[Labsite]: https://cogcomneurosci.com/

---

[Ghent University][UGent]  

[Faculty of Psychology and Educational Sciences][Faculty]  
[Department of Experimental Psychology][Department]  

[UGent]:      https://www.ugent.be/en
[Faculty]:    https://www.ugent.be/pp/en
[Department]: https://www.ugent.be/pp/experimentele-psychologie/en/research

Henri Dunantlaan 2  
B-9000 Gent  

Phone: +32 (0)9 264 64 07  
Fax: &nbsp;&nbsp;&nbsp;&nbsp;+32 (0)9 264 64 96  

---

**Last edit: 16-01-2019**  



```python

```
