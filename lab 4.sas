/*PROGRAM       : lab 4.sas
 *LOCATION      :add in your path where you store the file
 *PURPOSE       : prepare examples/exercises for Epi 298, introduction to SAS programming, 
				   lab 4
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

* create a library, "lab4" called libref, must be less than 8 characters;
* LIBNAME lab4 "your path"; 
 /* you need to change the directory to the directory you want to use */


********************************************************

*topic: calculate confidence interval;

/*Using the Byssisnosis data here in case you have trouble doing the hw2 
In SAS, for different C.I. you just need to change the order of your reference
group for categorical variable with multi-levels*/;

*load the data;
data hw2; 
  infile '/folders/myfolders/Byssinosis.csv' dlm="," firstobs=2; 
  input Employment $ Smoking $	Sex	$ Race $ Workspace	$ Byssinosis Non_Byssinosis;
run;
PROC PRINT DATA=hw2;
RUN;
*make column "total" for logistic regression;
data WORK.HW2;
 set HW2;
 total=Non_Byssinosis+Byssinosis;
run;
PROC PRINT DATA=hw2;
RUN;
*example for calculating the C.I.for workspace 2 vs 3;
proc logistic data=hw2;
class Smoking (ref="Yes" param=ref);
class Sex (ref="M" param=ref);
class Race (ref="W" param=ref);
class Workspace (ref="2" param=ref);
class Employment(ref="<10" param=ref);
model Byssinosis/total= Smoking Sex Race Workspace Employment;
run;








