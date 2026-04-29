/* ========================================
   DEMO 1: PROC R syntax
   ======================================== */

proc r; 
    submit;
    print('Hello from R!');
    endsubmit;
run;

/* ========================================
   DEMO 2: access R packages
   ======================================== */

proc r; 
    submit;
    library(tidyverse)
    carsdf <- sd2df("sashelp.cars")
    carsAudi <- carsdf %>% filter(Make == "Audi")
    df2sd(carsAudi, "AUDI", "WORK");
    endsubmit;
run;

proc print data=work.audi;
run;

/* ========================================
   DEMO 3: Call and assign macro variables
   ======================================== */

%let Make = Honda;

/* R: filter data and create a macro variable */
proc r;
submit;
library(tidyverse)

VMake <- symget("Make")
carsdf <- sd2df("sashelp.cars")

mycars <- carsdf %>%
filter(Make == VMake)

/* Create a macro variable in SAS from R */
avg_msrp <- mean(mycars$MSRP, na.rm = TRUE)
symput("AvgPrice", avg_msrp)

df2sd(mycars, "filtered_cars", "WORK")
endsubmit;
run;

/* SAS: use the macro variable created in R */
%put Average MSRP from R = &AvgPrice;

proc print data=filtered_cars(obs=5);
title "First 5 &Make Cars (Avg MSRP = &AvgPrice)";
run;


/* ========================================
   DEMO 4: Output results with show()
   ======================================== */

/*without show*/
proc r;
    submit;
    head(carsAudi);
    endsubmit;
run;


/*with show */
proc r;
    submit;
    show(head(carsAudi), title = "Audi Vehicles");
    endsubmit;
run;

