prepare_pace_tair_data <- function() {
    #### Download the data 
    ### Extra IR sensors monitoring a subset of subplot surface temperatures.
    myDF <- download_pace_tair_data()
    
    #### Assign ring information
    myDF <- myDF[order(myDF$DateTime),]
    myDF$Date <- format(as.Date(myDF$DateTime), "%Y-%m-%d")
    
    #### Assign plot information
    myDF$Plot <- sub("PACE_AUTO_", "", myDF$Source)
    myDF$Plot <- sub("_EXTRAIR_R_.*", "", myDF$Plot)

    ### Calculate daily min
    dDF1 <-aggregate(myDF[c("XSBTemp_Avg.1.","XSBTemp_Avg.2.","XSBTemp_Avg.3.","XSBTemp_Avg.4.",
                           "XTargTemp_Avg.1.","XTargTemp_Avg.2.","XTargTemp_Avg.3.","XTargTemp_Avg.4.")], 
                    by=myDF[c("Date", "Plot")], 
                    FUN=min, na.rm = T) 
    
    ### Calculate daily max
    dDF2 <-aggregate(myDF[c("XSBTemp_Avg.1.","XSBTemp_Avg.2.","XSBTemp_Avg.3.","XSBTemp_Avg.4.",
                            "XTargTemp_Avg.1.","XTargTemp_Avg.2.","XTargTemp_Avg.3.","XTargTemp_Avg.4.")], 
                     by=myDF[c("Date", "Plot")], 
                     FUN=max, na.rm = T) 
    
    dDF <- data.frame(dDF1, dDF2)
    colnames(dDF) <- c("Date", "Plot", "XSBTemp1_min", "XSBTemp2_min", "XSBTemp3_min", "XSBTemp4_min",
                       "XTargTemp1_min","XTargTemp2_min","XTargTemp3_min","XTargTemp4_min",
                       "Date2", "Plot2", "XSBTemp1_max", "XSBTemp2_max", "XSBTemp3_max", "XSBTemp4_max",
                       "XTargTemp1_max","XTargTemp2_max","XTargTemp3_max","XTargTemp4_max")
    
    ### Save  data
    #write.csv(dDF, "output/pace_met_wind_speed_daily.csv", row.names=F)

    return(dDF)

}