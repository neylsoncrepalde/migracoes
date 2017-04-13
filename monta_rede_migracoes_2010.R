# Migration Network - 2010
# Montando a rede
# Data - UN
# Neylson Crepalde
############################

library(readr)
library(magrittr)
library(dplyr)

bd <- read_csv2("~/Documentos/Neylson Crepalde/Doutorado/sea_populacoes/Seminario Big Data/migration_residence.csv",
                na = "..")

#Transforma 0 em NA
for (col in 10:43){
  bd[[col]] %<>% as.character
  bd[[col]] = recode(bd[[col]], "0" = "NA")
  bd[[col]] %<>% as.integer
}

# Separando os valores para o ano 2010
mig.2010 = bd[,c(1:9,44,45,40)]

# Organizando os dados
# 2010
rede.2010 = data.frame()
for (row in 1:length(mig.2010$Type)){
  if (mig.2010$Type[row] == "Emigrants"){
    rede.2010[row,1] = mig.2010$country[row]
    rede.2010[row,2] = mig.2010$OdName[row]
    rede.2010[row,3] = mig.2010$`2010`[row]
  }
  
  if (mig.2010$Type[row] == "Immigrants"){
    rede.2010[row,1] = mig.2010$OdName[row]
    rede.2010[row,2] = mig.2010$country[row]
    rede.2010[row,3] = mig.2010$`2010`[row]
  }
}
#View(rede.2010)
rede.2010 %<>% na.omit