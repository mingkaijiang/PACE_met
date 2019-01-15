download_pace_wind_data <- function() {
    s <- searchHIEv("PACE_AUTO_ALL_WINDSPEED_R")
    downloadTOA5(hievSearch=s, maxnfiles=10000)
}