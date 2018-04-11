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

proc print data=hyp;
run;

proc logistic data=hyp;
model nhyp/ntot = smoking obesity snoring;
run;

*NA's in data file changed to .*
* Create a SAS data set;
data juul ;
  infile '/folders/myfolders/juul.txt' firstobs=2 DLM=",";
  input obs $ age  menarche  sex  igf1  tanner $ testvol ;
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
class tanner (ref="1" param=ref);
model menarche(desc) = age tanner; run;


















