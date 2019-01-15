prepare_pace_wind_data <- function() {
    #### Download the data - takes time to run
    myDF <- download_pace_wind_data()
    
    #### Assign ring information
    myDF <- myDF[order(myDF$DateTime),]
    myDF$Date <- format(as.Date(myDF$DateTime), "%Y-%m-%d")
    
    ### Calculate daily mean
    dDF <-aggregate(myDF[c("WS_ms_Avg")], 
                    by=myDF[c("Date")], 
                    FUN=mean, na.rm = T, keep.names=T) 
    ### Save  data
    #write.csv(dDF, "output/pace_met_wind_speed_daily.csv", row.names=F)

    return(dDF)

}