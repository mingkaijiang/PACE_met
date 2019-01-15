download_pace_aboveground_data <- function() {
    s <- searchHIEv("PACE_AUTO_S[1-6]_ABVGRND_R_")
    downloadTOA5(hievSearch=s, maxnfiles=10000)
}