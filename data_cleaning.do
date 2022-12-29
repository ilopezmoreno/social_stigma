***** Set working directory *****

global databases "C:\Users\d57917il\Documents\1paper1\5_ENOE_databases\Bases ENOE" 

cd "$databases\2005trim1_dta"


*Specify the database you want to use
use SDEMT105

***************************************
******** Data cleaning process ********
***************************************

* INEGI explains that it is necessary to execute a data cleaning process in the demographic dataset (SDEM) in case you want to combine it with the employment datasets (COE1 and COE2)
* All the specifications are explained in page 13 of the following document: https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/doc/con_basedatos_proy2010.pdf

* First, INEGI recommends to drop all the kids below 12 years old from the sample because those kids where not interviewed in the employment survey. Therefore, it is not necesarry to keep them.
* More specifically, they explain that all the values between 00 and 11 as well as those equal to 99 in "eda" variable should be dropped. Remember that variable "eda" is equal to "age".
tab eda 
* Data quality check: 76,468 observations are kids between 00 and 11 years old & 33 observations are classified with a "99". 
drop if eda<=11 // Result: 76,468 observations deleted
drop if eda==99 // Result: 33 observations deleted

*Second, INEGI recommends to drop all the individual that didn't complete the interview. 
* More specifically, the explain that I should eliminate those interviews where the variable "r_def" is different from "00", since "r_def" is the definitive result of the interview and "00" is the indicator that shows that the interview was completed. 
tab r_def
*Data quality check: 117 observations are different from "00" 
drop if r_def!=00 // Result: 117 observations deleted

* Third, INEGI recommends to dropp all the interviews of people who were absent during the interview, since there is no labor information or the questionnaire was not applied to the absentees.
*More specifically, they explain that I should eliminate those interviews where the variable "c_res" is equal to "2", since "c_res" shows the residence condition and "2" is for definitive absentees.  
tab c_res
* Data quality check: 8,016 interviews were classified with a "2"
drop if c_res==2 // Result: 8,016 observations deleted.


***************************************
********* Merging process *************
***************************************

* Now that the data cleaning process is complete, I will start the merging process. 
* The first step is to merge the SDEM Database with the COE1 survey 
merge m:m cd_a ent con v_sel n_hog h_mud n_ren using COE1T105
rename _merge merge_COE1T105
*Data quality check.
tab merge_COE1T105 // Result: All the observations matched. 

* The second step is to merge the SDEM Database with the COE2 survey 
merge m:m cd_a ent con v_sel n_hog h_mud n_ren using COE2T105
rename _merge merge_COE2T105
*Data quality check.
tab merge_COE2T105 //Result: All the observations matched.
