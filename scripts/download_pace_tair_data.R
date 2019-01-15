download_pace_tair_data <- function() {
    s <- searchHIEv("PACE_AUTO_S[1-4]_EXTRAIR_R")
    downloadTOA5(hievSearch=s, maxnfiles=10000)
}