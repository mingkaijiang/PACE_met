prepare_pace_irrigation_data <- function() {
    #### Download the data 
    ### Irrigation for each plot (mm) with times.
    myDF <- download_pace_irrigation_data()
    
    #### Assign ring information
    myDF <- myDF[order(myDF$Date),]

    ### Calculate daily mean
    dDF <-aggregate(myDF[c("irrigsum", "residual", "elapsed", "irrigrate")], 
                    by=myDF[c("Date", "currentplot", "currenttrt")], 
                    FUN=mean, na.rm = T) 

    return(dDF)

}