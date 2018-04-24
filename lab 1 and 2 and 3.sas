/*PROGRAM       : lab 1 and2 and 3.sas
 *LOCATION      :add in your path where you store the file
 *PURPOSE       : prepare examples/exercises for Epi 298, introduction to SAS programming, 
				   lab 1,2,3
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


************************************************************
* use list input to read in raw data separated by spaces;
 ************************************************************;
*input hyp data manually;
 data hyp;
   input smoking obesity snoring ntot nhyp ratio;
   datalines;
 0 0 0 60 5 0.0833333333333333
 1 0 0 17 2 0.117647058823529
 0 1 0 8 1 0.125
 1 1 0 2 0 0
 0 0 1 187 35 0.18716577540107
 1 0 1 85 13 0.152941176470588
 0 1 1 51 15 0.294117647058824
 1 1 1 23 8 0.347826086956522
;
run;
*preview view of the data;
proc print data=hyp;
run;
*run the logistic regression;
proc logistic data=hyp;
model nhyp/ntot = smoking obesity snoring;
run;


 ************************************************************;
*  load the SAS data set named juul;
data juul ;
*define the location where we store the data;
  infile '/folders/myfolders/juul.txt' firstobs=2 DLM=",";
  *input the column of the data;
  input obs $ age  menarche  sex  igf1  tanner $ testvol ;
  *delete those are not qualified you can choose baesd on your study purpose;
  drop igf1 testvol;
  if age <= 8 then delete;
  if age >= 20 then delete;
  if tanner="NA" then delete;
  if missing(menarche) then delete;
  if missing(age) then delete;
  if missing(sex) then delete;
  if missing(tanner) then delete;
 run;
 
 
* Print the data set;
 proc print data=juul( obs=10);
 run;
* Fitting logistic regression;

proc logistic data=juul;
*define the reference group;
class tanner (ref="1" param=ref);
*desc here means your model "menarche"=1 first;
model menarche(desc) = age tanner; run;

*what is wrong about the process below of loading the data?;
data evans;
infile '/folders/myfolders/evans.txt' ;
  input ID  CHD CAT AGE CHL SMK ECG DBP SBP HPT CH CC ;
 run;

/* Change the data set above to the right type then continue to the following.*/
 proc print data=evans;
 run;
* Fitting logistic regression DO NOT RUN, this is just an example, make sure you use the "class" ;

proc logistic data=evans;
class ;
model ;


