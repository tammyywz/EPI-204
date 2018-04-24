/*PROGRAM       : lab 5.sas
 *LOCATION      :add in your path where you store the file
 *PURPOSE       : prepare examples/exercises for Epi 298, introduction to SAS programming, 
				   lab 5
 *CREATED BY    : yunwei zhang
 */

* use options to specify system options;
* put it the first line in general, and all statements behind it will be affected; 
OPTIONS linesize=256 pagesize=50 NONUMBER NOCENTER; 
* linesize = n controls the maximum length of output lines;
* pagesize = n controls the maximum number of lines per page of output, 15 - 32767
* number|nonumber controls whether page numbers appear on each page of output
	default number
* center|nocenter controls whether output is centered or left-justified
	default center;

* create a library, "lab5" called libref, must be less than 8 characters;
* LIBNAME lab5 "your path"; 
 /* you need to change the directory to the directory you want to use */


********************************************************
* create a SAS data set using the evans.txt data set;
data evans;
infile '/folders/myfolders/evans.txt' ;
  input ID  CHD CAT AGE CHL SMK ECG DBP SBP HPT CH CC ;
run;

/* using proc print to look at and check the data set */
 proc print data=evans;
 run;

/*SAS uses significance tests for adding and dropping
terms. This is all specified in the MODEL statement
using SELECTION=FORWARD, BACKWARD, or
STEPWISE.*/


*what you need to pay attention here is that do not forget the slash sign;

/* you need to determine which one to be categorical ,this is just an example below*/;

*We do the forward selection below for the CAT AGE CHL SMK ECG covariances;
proc logistic data=evans;
CLASS CAT(ref='1')  SMK(ref='1')  ECG(ref='1')/param=reference; 
*CLASS CHD(ref='1')/param=reference;
model CHD= CAT AGE CHL SMK ECG  /selection=forward;
run;

/* in sas, both the "contrast" and "test" only give you the 
Wald chi-square score and p-value not the confidence interval*/

/*when you do this below you will get error, what you can do to use "test" or "contrast" is 
not to use "class"*/
proc logistic data=evans;
model CHD=CAT AGE CHL SMK CAT*SMK CAT*AGE;
contrast '1 vs. 0 '  CAT  1 -1;
test1 : test CAT=AGE;
test2 :test  intercept + .5 * AGE;
run;

*correction;  
proc logistic data=evans;
CLASS CAT(ref='1') SMK(ref='1') ECG(ref='1')/param=reference; 
model CHD=CAT AGE CHL SMK CAT*SMK CAT*AGE;
*testing whether the effect of CAT and AGE are equal;
test1 : test CAT=AGE;
*testing whether there are differnce inside the smoking group with differnt weight;
test2 :test  intercept + .5 * SMK;
run;








