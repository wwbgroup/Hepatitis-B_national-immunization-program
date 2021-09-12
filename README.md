# Hepatitis-B_national-immunization-program
Code and data supporting the paper "Impact and cost-effectiveness of the national Hepatitis B immunization program in China: a modelling study", Liu Z, Li M and Wang W, et.al.

## Table of Contents
* Background
* Analysis softwares
* Prerequisite third-party R packages
* Descriptions of folders, scripts and other files
* Maintainers

### Background
In this paper, we implemented dynamic models and a decision tree-Markov model to compare the disease burden and cost-effectiveness of hepatitis B under different counterfactual scenarios and status quo scenario.

### Analysis softwares
* Matlab
* R language
* TreeAge Pro 2019
* Microsoft Excel


### Prerequisite R packages
  * library(ggplot2)
  * library(ggforce)
  * library(readxl)
  * library(reshape2)
  * library(RColorBrewer)
  * library(patchwork)
  * library(scales) 
  * library(plyr)
  * library(tidyr)

### Descriptions of folders, scripts and other files
Scripts in folders `Scripts_SEIR_main`, `Scripts_SEIR_figure`, `Scripts_SEIR_sensitivity` are used to conduct the mathematical model analysis, and `Scripts_Markov_analysis` is used to conduct the economic analysis through decision tree-Markov model.

* Tree map of the folders
  * `Scripts_SEIR_main`
   * `model estimation and fitting`
   * `Re calculation`
   * `scenarios simmulation and prediction`
  * `Scripts_SEIR_figure`
   * `Model_output`
   * `Figure.R` (include Fig.1-4 and S5.Fig )
  * `Scripts_SEIR_sensitivity`
   * `S6_Fig_part`
   * `S7_Fig_part`
  * `Scripts_Markov_analysis`
   * `Decision Tree-Markov Model.trex`

#### Folder `Scripts_SEIR_main`
Matlab scripts are used for our main analyses.

* In the `model estimation and fitting`, we divided the estimation process into 4 code file. They are `ObjFun0.m`, `ObjFun3.m`, `ODEfunction.m` and  `SimpleTest.m` which
were included the estimation code of the whole mathematical model. `ObjFun3.m` was set to create the compartments of the model, and `ODEfunction.m` was created with parameter settings and estiamted parameter.

Although these four files are separated in form, the code is linked with each other and cannot be run separately. All the code can only be initiated by `SimpleTest`.
In addition, the file `HBV.mat` was the data for the eatimation and fitting analysis.

Note: All 5 files need to be in the same folder.

* `Re calculation`:
The function to calculate the R_e (effective reproduction number).

*  `scenarios simmulation and prediction`: this folder included all the scenarios analysis code which was aimed to evaluate the impact of HBV immunization strategies in China.
Taking the `status quo` as an example, Dataset `parameter c.mat` is a collection of multiple parameter vectors that change over time, and the `scenhbv_sq.m` is the specific code for the scenarios simulation . Neither of these files can be run independently and can only be launched by the `ST.m`.
The initiation method applies to other scenario analyses.
 


#### Folder `Scripts_SEIR_sensitivity`
Matlab scripts for out sensitivity analyses (S6-S7). 


#### Folder `Scripts_SEIR_figure`
The `Figure.R` for the figures of main and sensitivity analyses. And the data, which produces by above matlab code files, of `Model_output` are used for producing the figures.



####Folder `Scripts_Markov_analysis`

  **Click the following modules in order in the `TreeAge Pro 2019`.**

* Cost-effectiveness analysis
  
 **Steps:** Analysis→Cost-effectiveness→Text report

* Cohort analysis
 
 **Steps:** Analysis→Markov Cohort→Enter the number of children in the birth queue and stages→Summary report

* Sensitivity analyses
 
 **Steps:**
  
 1. One-way sensitivity: Analysis→Sensitive Analysis→Tornado Diagram→Select the required variables and enter the upper and lower value
 
 2. Probabilistic sensitivity analysis: Analysis→Monte Carlo simulation→Sampling (Probabilistic Sensitivity) →Number of samples(10000) → ICE scatterplot

### Maintainers
[Contact](wwb@fudan.edu.cn)





