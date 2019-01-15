#### main program

#### Purpose: to generate met data required by a model based on PACE experiment
#### needs daily data, at per vegetation plot level
#### Author: Mingkai Jiang (m.jiang@westernsydney.edu.au)
#### Script generated on 14-01-2019

### prepare required repository
source("prepare.R")

### prepare wind speed data
wdDF <- prepare_pace_wind_data()

### prepare tair data
tairDF <- prepare_pace_tair_data()

### prepare irrigation data
irrigDF <- prepare_pace_irrigation_data()

