# uvnet310
Code for "The Ultraviolet Index is well estimated by the terrestrial irradiance at 310nm." 

The code requires that the data directory be populated.
We recommend running the code from R studio.

## Requirements
Packages:

- tidyverse
- latex2exp
- minpack.lm

## Obtaining data

During review all data can be downloaded from our google cloud bucket [uvnet310](https://console.cloud.google.com/storage/browser/uvnet310?project=nimble-volt-867). The contents of this bucket should be placed in the folder `data`.

Ozone Cross sections,
download 'SCIA_O3_Temp_cross-section_V4.1.DAT' from http://igaco-o3.fmi.fi/ACSO/cross_sections.html

The solar irradiance spectrum can be found at 'http://bdap.ipsl.fr/voscat/SOLAR_ISS_V1.html'

UV Net Data: TODO describe how to populate...

## File summary

- data_check.R  check if the correct files have been located in the data folder
- figure_1.Rmd  generates and describes the content of each figure  
- figure_2.Rmd
- figure_3.Rmd  contains parameters to reproduce graphic derivation at different locations on different days
- figure_4.Rmd
