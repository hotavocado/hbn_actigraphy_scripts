# GGIR version 2.0-0

library(GGIR)



################################################################################################################################
 
myshell<-function(studyname,datadir,outputdir,mode=c(1,2,3,4,5),f0=0,f1=c(),desiredtz = "Etc/GMT+5"){ 
 
g.shell.GGIR(#=======================================
             # INPUT NEEDED:
              mode=mode, 
             datadir=datadir,
             outputdir= outputdir,
             f0=f0, f1=f1, 
             studyname=studyname,
             overwrite = FALSE,
             idloc=1,
             print.filename=TRUE,
             storefolderstructure = FALSE,
             dformat=2,
             mon=3,
             #-------------------------------
             # Part 1:
             #-------------------------------
             # Key functions: reading file, auto-calibration, and extracting features
             desiredtz = desiredtz,
             do.enmo = TRUE,
             do.anglez=TRUE,
             do.hfen = FALSE,
             windowsizes = c(5,900,3600), 
             do.cal=TRUE,
             chunksize=1,
             printsummary=TRUE,

			 #-------------------------------
             # Part 2:
             #-------------------------------
             
             strategy = 1,
             hrs.del.start = 0,  # for strategy = 1
             hrs.del.end = 0,
             maxdur = 0,    # for strategy = 1, changed from NIMH script
             includedaycrit = 16,
             winhr = c(5,10),
             epochvalues2csv=FALSE,
             L5M5window = c(0,24),
             M5L5res = 10,
             qlevels = c(c(1380/1440),c(1410/1440)),
             qwindow=c(0,24),
             ilevels = c(seq(0,400,by=50),8000),
             mvpathreshold =c(125),
             do.imp=TRUE,

             #-------------------------------
             # Part 3:
             # (detection of sustained inactivity periods as needed for sleep detection in g.part4)
             #-------------------------------
             # Key functions: Sleep detection
             timethreshold= c(5),
             anglethreshold=5,
             ignorenonwear = TRUE,
             #-------------------------------
             # Part 4:
             # \uff08Labels detected sustained inactivity periods by g.part3 as either nocturnal sleep or daytime sustained inactivity)
             #-------------------------------
             # Key functions: Integrating sleep log (if available) with sleep detection
             # storing day and person specific summaries of sleep

             excludefirstlast = FALSE,
             includenightcrit = 16,
             def.noc.sleep = c(1),
             # loglocation= "~/Desktop/NIMH Family Study/sleeplog_final02202018_wide.csv",
             # colid=1,
             # coln1=2,
             outliers.only = FALSE,
             relyonsleeplog = FALSE,
             sleeplogidnum = FALSE,
             do.visual = TRUE,
             criterror = 0,
             nnights = 60, #changed from NIMH script

             #-------------------------------
             # Part 5:
             #-------------------------------
             # Key functions: merge output from physical activity and sleep analysis into one report
             threshold.lig = c(30,40,50),
             threshold.mod = c(100,120,125),
             threshold.vig = c(400,500),
             boutcriter = 0.8,
             boutcriter.in = 0.9,
             boutcriter.lig = 0.8,
             boutcriter.mvpa = 0.8,
             boutdur.in = c(10,20,30),
             boutdur.lig = c(1,5, 10),
             boutdur.mvpa = c(1,5,10),
             timewindow = c("WW", "MM"),
            # -----------------------------------
            # Report generation
            # -----------------------------------
            # Key functions: Generating reports based on meta-data
             #do.report=c(2,4,5),	
             visualreport=TRUE,
             dofirstpage = TRUE,
             viewingwindow=1
)


}



 
