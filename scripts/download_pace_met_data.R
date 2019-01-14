download_pace_met_data <- function() {
    s <- searchHIEv("PACE_AUTO_ALL_[1-6]_T1_general")
    downloadTOA5(hievSearch=s, maxnfiles=10000)
}