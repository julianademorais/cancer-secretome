#install packages
install.packages(pkgs = c("UpSetR", "RColorBrewer"),
                 dependencies = T)

#load packages
library(UpSetR)
library(RColorBrewer)

data <- read.csv("https://raw.githubusercontent.com/julianademorais/cancer-secretome/master/R/all-proteins.csv")

#15 shared proteins

upset(data, nsets =9, nintersects= 4, number.angles = 1, order.by= "degree",  
      sets.bar.color= "#56B4E9",
      keep.order=TRUE,
      point.size = 3.5, line.size = 1.0, 
      mainbar.y.label = "Proteínas compartilhadas", sets.x.label = "Proteínas por tipo de câncer", 
      text.scale = c(5.0, 3.5, 3.0, 3.0, 3.5, 3.5))

#90 shared proteins

upset(data, nsets =9, nintersects=90, number.angles = 1, order.by= "degree", 
      #main.bar.color = "darkgrey", 
      sets.bar.color = "#56B4E9", 
      #matrix.color = "darkgrey",
      keep.order=TRUE,
      queries = list(list(query = intersects, 
                          params = list("prostate_PC3", "melanoma_HS895T", "melanoma_A375", "melanoma_SH4", "breast_MDAMB231",
                                        "colon_HCT116", "ewingsarcoma_TC32", "ovary_patientsample" ), color = "#56B4E9",
                          active = T), list(query = intersects, 
                                            params = list("prostate_PC3", "melanoma_HS895T", "melanoma_A375", "melanoma_SH4", "ewingsarcoma_CHLA10", 
                                                          "colon_HCT116", "ewingsarcoma_TC32", "ovary_patientsample" ), color = "#56B4E9", active = T),
                     list(query = intersects, 
                          params = list("prostate_PC3", "breast_MDAMB231", "melanoma_A375", "melanoma_SH4", "ewingsarcoma_CHLA10", 
                                        "colon_HCT116", "ewingsarcoma_TC32", "ovary_patientsample" ), color = "#56B4E9", active = T),
                     list(query = intersects, 
                          params = list("melanoma_HS895T", "breast_MDAMB231", "melanoma_A375", "melanoma_SH4", "ewingsarcoma_CHLA10", 
                                        "colon_HCT116", "ewingsarcoma_TC32", "ovary_patientsample" ), color = "#56B4E9", active = T)),
                     
      point.size = 3.5, line.size = 1.0, 
      mainbar.y.label = "Proteínas compartilhadas", sets.x.label = "Proteínas por tipo de câncer",
      text.scale = c(5.0, 3.5, 3.0, 3.0, 3.5, 3.5))

#unique proteins per cancer

data <- read.csv("https://raw.githubusercontent.com/julianademorais/cancer-secretome/master/R/unique-shared.csv")

upset(data, nsets =9, nintersects= 9, number.angles = 1, order.by= "freq",  
      sets.bar.color= "#56B4E9",
      keep.order=TRUE,
      point.size = 3.5, line.size = 1.0, 
      mainbar.y.label = "Proteínas compartilhadas", sets.x.label = "Proteínas por tipo de câncer", 
      text.scale = c(5.0, 3.5, 3.0, 3.0, 3.5, 3.5))

#shared NLS genes

data <- read.csv("https://raw.githubusercontent.com/julianademorais/cancer-secretome/master/R/NLS-shared.csv")

upset(data, nsets =9, number.angles = 1, order.by= "freq",  
      sets.bar.color= "#56B4E9",
      keep.order=TRUE,
      point.size = 3.5, line.size = 1.0, 
      mainbar.y.label = "Genes compartilhados", sets.x.label = "Genes por tipo de câncer", 
      text.scale = c(5.0, 3.5, 3.0, 3.0, 3.5, 3.5))
