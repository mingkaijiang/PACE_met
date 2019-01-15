prepare_pace_irrigation_data <- function() {
    #### Download the data 
    myDF <- download_pace_irrigation_data()
    
    #### Assign ring information
    myDF <- myDF[order(myDF$DateTime),]
    myDF$Date <- format(as.Date(myDF$DateTime), "%Y-%m-%d")
    
    #### Assign plot information
    myDF$Plot <- sub("PACE_AUTO_", "", myDF$Source)
    myDF$Plot <- sub("_EXTRAIR_R_.*", "", myDF$Plot)

    ### Calculate daily mean
    dDF <-aggregate(myDF[c("XSBTemp_Avg.1.","XSBTemp_Avg.2.","XSBTemp_Avg.3.","XSBTemp_Avg.4.",
                           "XTargTemp_Avg.1.","XTargTemp_Avg.2.","XTargTemp_Avg.3.","XTargTemp_Avg.4.")], 
                    by=myDF[c("Date", "Plot")], 
                    FUN=mean, na.rm = T, keep.names=T) 
    ### Save  data
    #write.csv(dDF, "output/pace_met_wind_speed_daily.csv", row.names=F)

    return(dDF)

}