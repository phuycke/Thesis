
# Thesis - Master Experimental Psychology - Ghent university

[![GitHub license](https://img.shields.io/apm/l/test.svg)](https://github.com/CogComNeuroSci/Pieter_H/blob/master/LICENSE)
[![Python version](https://img.shields.io/badge/Python-3.7.0-blue.svg)](https://img.shields.io/badge/Python-3.7.0-blue.svg)
[![Spyder version](https://img.shields.io/badge/R-3.5.1-blue.svg)](https://img.shields.io/badge/R-3.5.1-blue.svg)
[![Build version](https://img.shields.io/badge/build-passing-green.svg)](https://img.shields.io/badge/build-passing-green.svg)


## How to navigate this repository

The repository consists of two different folders:   
- [Code][code]   
- [Analyse][analyse]   

[code]: https://github.com/phuycke/Thesis/tree/master/Code
[analyse]: https://github.com/phuycke/Thesis/tree/master/Analyse  

---

**Code directory**   
The code directory contains _four_ different subfolders:   
- [Experiment - versions][versions]   
- [Experiment - create datasets][datasets]   
- [Experiment - loops][loops]   
- [Experiment - unused][unused]   

__Folder outline__:

* [... - versions][versions]
    * Contains all the versions of the used Python script
* [... - datasets][datasets]:
    * Used to create stimulus datasets
        * These datasets are used to determine stimulus order, presentation ...
* [... - loops][loops]:
    * Automatisation: serial execution of the scripts located in the "create datasets" directory
    * This yields as an advantage that we can create n datasets (with n = the number of participants)
* [... - unused][unused]:
    * Scripts that were already created, but were left out of the data collection

[versions]: https://github.com/phuycke/Thesis/tree/master/Code/Experiment%20-%20versions
[datasets]: https://github.com/phuycke/Thesis/tree/master/Code/Experiment%20-%20create%20datasets
[loops]: https://github.com/phuycke/Thesis/tree/master/Code/Experiment%20-%20loops
[unused]: https://github.com/phuycke/Thesis/tree/master/Code/Experiment%20-%20unused

---

**Analyse directory**   
The code directory contains _three_ different subfolders:   
- [Offline data - experiment 01][exp01]   
- [Offline data - experiment 02][exp02]   
- [Online data - Google forms][forms]   

__Folder outline__:

* [... - 01][exp01]
    * Bundle.R
    * Clean and plot.R
    * Analyse.R
* [... - 02][exp02]:
    * Bundle.R
    * Clean.R
    * Plot.R
    * Analyse.R
* [... - forms][forms]:
    * Clean and plot.R

_Bundle_   
Loop over the different separate data files, and bundle them together to read them in as one large file.   

_Clean_   
Clean the dataset by removing outliers, looking at the data, removing odd observations, making new variables based on other variables ...

_Plot_   
Create plots based on the cleaned data, plots can be saved automatically

_Analyse_   
Perform actual analysis on the data and formulate conclusions

[exp01]: https://github.com/phuycke/Thesis/tree/master/Analyse/Offline%20data%20-%20experiment%2001
[exp02]: https://github.com/phuycke/Thesis/tree/master/Analyse/Offline%20data%20-%20experiment%2002
[forms]: https://github.com/phuycke/Thesis/tree/master/Analyse/Online%20data%20-%20Google%20forms

---

## Programming information

We used [PsychoPy3][psycho] as main programming language.  

[psycho]: http://www.psychopy.org/installation.html

__Required modules__:

    * __future__
    * csv
    * datetime
    * functools
    * math
    * numpy
    * os
    * pandas
    * psychopy
    * random
    * sys
    * time
    * webbrowser

All can be installed in your _Python environment_ by using _pip_:  
`pip install moduleName`

_Version 6 is a stable version and can be executed without issues on a Windows computer_  


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

**Last edit: 21-01-2019**  



```python

```
