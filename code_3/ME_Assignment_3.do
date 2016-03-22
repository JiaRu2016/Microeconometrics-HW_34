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

sort id
sort time

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



est store GLS

/***************************************************
4. 
� Fixed effects (within) 
� Random effects (GLS) 
� Between
****************************************************/

xtreg $Y $X , fe 
est store fe
est store re_GLS
est store be
est store re_ML

/***************************************************
5.Compute the estimates of specific effects (fixed and random). 
Comment. 
Would you prefer the fixed ef- fects or the random effects results? 
Why? (you can use the Hausman test).
****************************************************/
hausman fe re_GLS
