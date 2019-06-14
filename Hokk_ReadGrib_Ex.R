#Operational Forecast Data Extraction
#NCEP output is always in GRIB2 format - this makes things easy for us
#An example for the Global Forecast System 0.5 degree model

# install.packages("rNOMADS")
library(rNOMADS)

filename_Am='gfs.t18z.pgrb2full.0p50.f006.grb'

#Get the latest model url
## Not run: 
# urls.out <- CrawlModels(abbrev = "gfs_0p50", depth = 1)

#Get a list of forecasts, variables and levels
# model.parameters <- ParseModelPage(urls.out[1])
model.parameters <- ParseModelPage('gfs.t18z.pgrb2full.0p50.f006.grb')

#Figure out which one is the 6 hour forecast
#provided by the latest model run
#(will be the forecast from 6-12 hours from the current date) 


my.pred <- model.parameters$pred[grep("06$", model.parameters$pred)]

#What region of the atmosphere to get data for
levels <- c("2 m above ground", "800 mb")

#What data to return
variables <- c("TMP", "RH") #Temperature and relative humidity

#Get the data
# model.info <- GribGrab(urls.out[1], my.pred, levels, variables)
model.info <- GribGrab(filename_Am, my.pred, levels, variables)

# model.info
# model.info[[1]]
# model.info[[1]]$file.name

#Extract the data
# model.data <- ReadGrib(model.info[[1]]$file.name, levels, variables)
model.data <- ReadGrib('gfs.t18z.pgrb2full.0p50.f006.grb', levels, variables)

###### Japanese data 
#####http://database.rish.kyoto-u.ac.jp/arch/jmadata/data/gpv/original/2018/12/31/
# filename='Z__C_RJTD_20181231180000_GSM_GPV_Rgl_FD0018_grib2.bin'
# filename='Z__C_RJTD_20181231180000_MSM_GPV_Rjp_Lsurf_FH00-15_grib2.bin''

# model.data <- ReadGrib(filename, levels, variables)

