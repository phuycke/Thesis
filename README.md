
# Thesis
## First master Experimental Psychology - Ghent university

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

* [... - 01][exp1]
    * Contains all the versions of the used Python script
* [... - 02][exp2]:
    * Used to create stimulus datasets
        * These datasets are used to determine stimulus order, presentation ...
* [... - forms][forms]:
    * Automatisation: serial execution of the scripts located in the "create datasets" directory
    * This yields as an advantage that we can create n datasets (with n = the number of participants)

[exp01]: https://github.com/phuycke/Thesis/tree/master/Analyse/Offline%20data%20-%20experiment%2001
[exp02]: https://github.com/phuycke/Thesis/tree/master/Analyse/Offline%20data%20-%20experiment%2002
[forms]: https://github.com/phuycke/Thesis/tree/master/Analyse/Online%20data%20-%20Google%20forms

---

`test`:  

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

_All three Python scripts are needed for a successful simulation run!_  


## Conclusion


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
