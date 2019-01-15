download_pace_irrigation_data <- function() {
    s <- searchHIEv("PACE_AUTO_ALL_IRRIG_R_")
    downloadTOA5(hievSearch=s, maxnfiles=10000)
}