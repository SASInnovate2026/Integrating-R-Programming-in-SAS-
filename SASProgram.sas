
libname mylib "/workspaces/myfolder/mydata";

data mylib.filtered_cars;
    set sashelp.cars;
    where Type = "SUV" and MSRP < 40000;
    keep Make Model Type Origin DriveTrain MSRP MPG_City Horsepower;
run;