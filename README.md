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

### Descriptions of folders, scripts and other files
Scripts in folders `Scripts_SEIR_main`, `Scripts_SEIR_figure`, `Scripts_SEIR_sensitivity` are used to conduct the mathematical model analysis, and `Scripts_Markov_analysis` is used to conduct the economic analysis through decision tree-Markov model.

* Tree map of the folders
  * `Scripts_SEIR_main`
   * `model estimation and fitting`
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
Matlab scripts are used for our main analyses which conclude folder `model estimation and fitting` and `scenarios simmulation and prediction`.





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












