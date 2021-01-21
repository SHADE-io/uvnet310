# UVnet parse -- improves on Shayak's python script for UVnet parsing (uvnetParsing.py)
#   * in R
#   * accepts all scans, not just one per hour
#   * dumps data to a binary file for quick reload
#
#  Background
#   UVnet data are at https://archive.epa.gov/uvnet/web/html/index.html
#   But also in our filesystem at: "Team Drives/Research/Data science/Monte Carlo simulation for diode evaluation/UVnet (EPA)"
#
# 
library(tidyr)

parseUVNetRWFile <- function(fname){
  fcontents <- readLines(fname)
  if(length(fcontents)==0){
    return(NULL)
  }
  print(paste0("read ", fname, ". now to parse."))
  fcontents[length(fcontents)+1]<- ""
  # read title info line
  pstring <- fcontents[1] %>% strsplit("\\s+") %>% unlist
  data_file_info <- data.frame(year=as.numeric(pstring[1]), day=as.numeric(pstring[2]),
                               qcdate=pstring[3], qcfile=pstring[4], latitude=pstring[5],
                               longitude=pstring[6], location=pstring[7], instrument=pstring[8])
  rname_prefix <- paste0(data_file_info$location, data_file_info$year, data_file_info$day)
  lambda <- seq(286.5, 363, 0.5)
  ind <- 2
  if(exists("rwf")){rm(rwf)}
  if(exists("sp2")){rm(sp2)}
  while(ind<length(fcontents)-1){
    while(str_length(fcontents[ind])==0){ind <- ind+1}
    # read scan info
    pstring <- fcontents[ind] %>% strsplit("\\s+") %>% unlist
    scan_info <- data.frame(scan=gsub('#', '', pstring[2]) %>% as.numeric,
                            zenith=as.numeric(pstring[5]), hour=as.numeric(pstring[6]))
    scan_info$spec_name <- paste0(rname_prefix,"s",scan_info$scan)
       # print(scan_info)
    # read spectrum
    sp <- data.frame(lambda=lambda, irrad = rep(0,length(lambda)))
    while(str_length(fcontents[ind]) > 10){
      spect_line <- fcontents[ind] %>% gsub('^ *','',.) %>% strsplit("\\s+") %>% unlist %>% as.numeric
      sp$irrad[sp$lambda == spect_line[2]/10] <- spect_line[3]
      ind <- ind + 1
    }
    spm <- as.matrix(sp) %>% t() 
    if(exists("sp2")){
      sp2 <- rbind(sp2, spm[2,])
    } else {
      sp2 <- spm[2,]
    }
    if(exists("rwf")){rwf <- rbind(rwf,scan_info)} else {rwf <- scan_info}
  }
  if(!(is.null(nrow(sp2)))){
    colnames(sp2) <- spm[1, ] %>% round(1) %>% paste0("nm", .)
    rownames(sp2) <- rwf$spec_name 
  }
  return(list(file_info = data_file_info, scan_info=rwf, spectra=sp2, lambda=lambda))
}

for(place in c("Acadia NP ME",  "Albuquerque NM",     "Atlanta GA", "Big Bend TX",               
               "Boulder CO", "Canyonlands NP UT", "Chicago IL", "Gaithersburg MD",              
                "Research Triangle Park NC" , "Riverside CA" , "Big Bend TX"))
{
  setwd(place)
  flist <- list.files(patt="RW[0-9]*")
  fc <- 0
  for(f in flist){
    fc <- fc + 1
    print(paste0(fc,"/",length(flist)))
    s <- parseUVNetRWFile(f)
    if(length(s)==4){
    if(exists("data_file_info")) {data_file_info <- rbind(data_file_info, s$file_info)} else {data_file_info <- s$file_info}
    if(exists("scans_info"))     {scans_info <- rbind(scans_info, s$scan_info)} else {scans_info <- s$scan_info}
    if(exists("spectra"))        {spectra <- rbind(spectra, s$spectra)} else {spectra <- s$spectra}
  }}
  lambda <- s$lambda
  save(data_file_info, scans_info, spectra, lambda, file=paste0(place,".RData"))
  rm(data_file_info, scans_info, spectra, lambda)
  setwd("..")
}

