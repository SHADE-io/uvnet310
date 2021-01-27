data_dir <- 'data'

if (!file.exists(paste(data_dir,"astmg173.csv",sep="/"))){
  print('Figure 1: Missing astmg173.csv')
  print('Download https://www.nrel.gov/grid/solar-resource/assets/data/astmg173.xls. Then convert to .csv by saving the astmg173 tab as .csv using Microsoft Excel.')
}
if (!file.exists(paste(data_dir, "SOLAR_ISS_V1.Rdat", sep='/'))){
  print('Figure 1 and 4: Missing file: SOLAR_ISS_V1.html')
  print('download from: http://bdap.ipsl.fr/voscat/SOLAR_ISS_V1.html ')
}
if (!file.exists(paste(data_dir,'SCIA_O3_Temp_cross-section_V4.1.DAT',sep="/"))){
  print('Figure 1: Missing file SCIA_O3_Temp_cross-section_V4.1.DAT')
  print('download from: http://igaco-o3.fmi.fi/ACSO/cross_asections.html')
}
if (!file.exists(paste(data_dir,'uvnet.Rdat', sep="/"))){
  print('Figure 2: missing file uvnet.Rdat')
  print('notes are below')
}
if (!file.exists(paste(data_dir,'uvnet_all.Rdat', sep="/"))){
  print('Figure 2: missing file uvnet.Rdat')
  print('notes are below')
}
uvnet_path <- data_dir
uvnet_sites <- c("Acadia NP ME", "Albuquerque NM", "Boulder CO", "Canyonlands NP UT",
                 "Chicago IL", "Gaithersburg MD", "Research Triangle Park NC",
                 "Riverside CA", "Big Bend TX")
uvnet_files <- paste(uvnet_path, uvnet_sites, uvnet_sites, sep="/")
uvnet_files <- uvnet_files %>% paste0(".RData")
for (f in uvnet_files){
  if (!file.exists(f)){
    print(paste0('Figure 3: missing file ',f,'. notes are below'))
  }
}
