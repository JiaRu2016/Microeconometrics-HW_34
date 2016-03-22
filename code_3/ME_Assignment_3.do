/***************************************************
       Microeconometrics Assignment 3
                  Jia Ru   
****************************************************/

clear
version 12
cd  "/Users/jiaru2014/Desktop/ME_Assignment_3"
capture log close  
log using "data/logg.smcl", replace               
#delimit cr
set more off

/***************************************************
0. import data
****************************************************/
import excel "data/data_assignment4.xls", sheet("Sheet1") firstrow

save "data/data.dta", replace

use "data/data.dta", clear
/***************************************************
1.Explore the data set.
Identify which variables are time variant, 
individual variant or both.
****************************************************/

sort idby id: summ 
sort timeby time:summ

/***************************************************
2.Set panel Structure. 
Compute summary statistics for all the variables.
Are there any suspicious values?
****************************************************/
xtset , clear 
xtset id time 
xtdescribe 
xtsum

/***************************************************
3. GLS regression
****************************************************/
gen EXP2 = EXP*EXP
global Y "LWAGE"global X "EXP EXP2 WKS OCC IND SOUTH SMSA MS FEMUNION ED BLK"
est clearset matsize 595, permanently
xtgls $Y $X, i(id) corr(ind) 
est store GLS

/***************************************************
4. 
¥ Fixed effects (within) 
¥ Random effects (GLS) 
¥ Between¥ Random effects (ML)
****************************************************/

xtreg $Y $X , fe 
est store fextreg $Y $X , re 
est store re_GLSxtreg $Y $X , be 
est store bextreg $Y $X , mle 
est store re_MLoutreg2 [GLS fe re_GLS be re_ML] using "tex/reg.tex" ///, nose replace tex(frag) title("Regression Resutlts")

/***************************************************
5.Compute the estimates of specific effects (fixed and random). 
Comment. 
Would you prefer the fixed ef- fects or the random effects results? 
Why? (you can use the Hausman test).
****************************************************/
hausman fe re_GLS

