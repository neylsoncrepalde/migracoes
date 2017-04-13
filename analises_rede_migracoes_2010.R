# Migration Network - 2010
# Análises
# Data - UN
# Neylson Crepalde
#############################

setwd("~/Documentos/Neylson Crepalde/Doutorado/sea_populacoes/migracoes")
source("monta_rede_migracoes_2010.R")

#########
# Se precisar do latlon para plotagem...
#latlon = read_csv2("~/Documentos/Neylson Crepalde/Doutorado/sea_populacoes/Seminario Big Data/rede_latlon.csv")
#########

library(igraph)
library(texreg)

# Montando a rede de migrações para 2010
g.2010 = graph_from_edgelist(as.matrix(rede.2010[,1:2]))

# Adicionando pesos aos edges
E(g.2010)$weight = rede.2010[,3]

# Retirando UNKNOWN e TOTAL
g.2010 = delete_vertices(g.2010, c('Unknown','Total'))

# Plotando com Fruchterman-Rheingold
plot(g.2010, vertex.size=3, vertex.label.cex=.7, edge.arrow.size=.3, 
     #edge.width=log(E(g.2010)$weight), 
     edge.color=adjustcolor("grey70", .4),
     main="Rede de fluxos migratórios - 2010")

# Plotando em círculo
plot(g.2010, vertex.size=3, vertex.label.cex=.7, edge.arrow.size=.3, 
     #edge.width=log(E(g.2010)$weight), 
     edge.color=adjustcolor("grey70", .4),
     layout=layout_in_circle, main="Rede de fluxos migratórios - 2010")

###########################################################################
#### Métricas a nível de rede

# Densidade
graph.density(g.2010)




