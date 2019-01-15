prepare_pace_aboveground_data <- function() {
    #### Download the data 
    ### Above ground PAR, air temperature, humidity, surface IR temperatures of warmed and control plots.
    myDF <- download_pace_aboveground_data()
    
    #### Assign ring information
    myDF <- myDF[order(myDF$Date),]

    #### Assign plot information
    myDF$Plot <- sub("PACE_AUTO_", "", myDF$Source)
    myDF$Plot <- sub("_ABVGRND_R_.*", "", myDF$Plot)
    
    
    #### Calculate vapor pressure based on tair, relative humidity
    ### saturation vapor pressure (es)
    myDF$es_1 <- 0.6108 * exp(17.27 * myDF$AirT1_Avg / (myDF$AirT1_Avg + 273.3))
    myDF$es_2 <- 0.6108 * exp(17.27 * myDF$AirT2_Avg / (myDF$AirT2_Avg + 273.3))
    
    ### actual vapor pressure (ea)
    myDF$ea_1 <- myDF$RH_Avg / 100 * myDF$es_1
    myDF$ea_2 <- myDF$RH_Avg / 100 * myDF$es_2
    
    
    ### Calculate daily tair min
    dDF1 <-aggregate(myDF[c("AirT1_Avg","AirT2_Avg")], 
                     by=myDF[c("Date", "Plot")], 
                     FUN=min, na.rm = T) 
    
    ### Calculate daily tair max
    dDF2 <-aggregate(myDF[c("AirT1_Avg","AirT2_Avg")], 
                     by=myDF[c("Date", "Plot")], 
                     FUN=max, na.rm = T) 
    
    ### Calculate daily par mean and vapor pressure
    dDF3 <-aggregate(myDF[c("ea_1","ea_2", "PAR_Avg")], 
                     by=myDF[c("Date", "Plot")], 
                     FUN=mean, na.rm = T) 
    
    ### combine df
    dDF <- data.frame(dDF1, dDF2, dDF3)
    colnames(dDF) <- c("Date", "Plot", "AirT1_min", "AirT2_min", 
                       "Date2", "Plot2", "AirT1_max", "AirT2_max",
                       "Date3", "Plot3", "VP1", "VP2", "PAR")

    return(dDF)

}