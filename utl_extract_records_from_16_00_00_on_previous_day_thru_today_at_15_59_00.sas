Extract records from 16:00:00 the previous day thru today at 15:59:00

SAS Forum
https://communities.sas.com/t5/SAS-Programming/Datetime-function/m-p/528390

Daniel Langley (based on Dans approach)
https://communities.sas.com/t5/user/viewprofilepage/user-id/209943

INPUT
=====

data have;
 format dteTym datetime16.;
 input dteTym ANYDTDTM30.;
cards4;
1/18/2019 1:19
1/18/2019 6:12
1/18/2019 7:20
1/18/2019 8:20
1/18/2019 10:05
1/18/2019 10:33
1/18/2019 10:48
1/18/2019 11:19
1/18/2019 11:28
1/18/2019 11:30
1/19/2019 8:35
1/19/2019 10:35
1/19/2019 11:56
1/19/2019 13:13
1/19/2019 13:23
1/19/2019 13:47
1/19/2019 15:10
1/19/2019 15:31
1/19/2019 16:40
1/19/2019 19:07
1/19/2019 21:44
1/20/2019 6:38
1/20/2019 6:41
1/20/2019 8:45
1/20/2019 9:36
1/20/2019 10:04
1/20/2019 10:33
1/20/2019 11:19
1/20/2019 12:36
1/20/2019 12:41
1/20/2019 13:08
1/20/2019 13:38
1/20/2019 13:52
1/20/2019 14:54
1/20/2019 15:10
1/20/2019 17:41
1/20/2019 21:12
1/20/2019 22:31
;;;;
run;quit;


OUTPUT
======

HAVE total obs=38
                                RULES
Obs         DTETYM              Extract 16:00:00 the previous day thru today at 15:59:00

  1    18JAN19:01:19:00
  2    18JAN19:06:12:00
  3    18JAN19:07:20:00
  4    18JAN19:08:20:00
  5    18JAN19:10:05:00
  6    18JAN19:10:33:00
  7    18JAN19:10:48:00
  8    18JAN19:11:19:00
  9    18JAN19:11:28:00
 10    18JAN19:11:30:00
 11    19JAN19:08:35:00
 12    19JAN19:10:35:00
 13    19JAN19:11:56:00
 14    19JAN19:13:13:00
 15    19JAN19:13:23:00
 16    19JAN19:13:47:00
 17    19JAN19:15:10:00
 18    19JAN19:15:31:00

 19    19JAN19:16:40:00 ---+
 20    19JAN19:19:07:00    |
 21    19JAN19:21:44:00    |
 22    20JAN19:06:38:00    |
 23    20JAN19:06:41:00    |
 24    20JAN19:08:45:00    |
 25    20JAN19:09:36:00    |
 26    20JAN19:10:04:00    |
 27    20JAN19:10:33:00    |  Extract these records
 28    20JAN19:11:19:00    |
 29    20JAN19:12:36:00    |
 30    20JAN19:12:41:00    |
 31    20JAN19:13:08:00    |
 32    20JAN19:13:38:00    |
 33    20JAN19:13:52:00    |
 34    20JAN19:14:54:00    |
 35    20JAN19:15:10:00    |
 36    20JAN19:17:41:00 ---+  ** getting this one is the hard part

 37    20JAN19:21:12:00
 38    20JAN19:22:31:00



PROCESS
=======

data want(keep=dteTym) ;
  retain flg beenthere 0;
  set have;
  if dteTym ge dhms(  today() - 1 , 16,0,0 ) and dteTym lt dhms( today(), 15,59,0 ) then do;
     flg=1;
     output;
  end;
  * all this to get the end time;
  if flg=1 and dteTym ge dhms( today(), 15,59,0 ) and beenthere=0 then do;
     output;
     beenthere=1;
  end;
run;quit;


OUTPUT
======
see above

