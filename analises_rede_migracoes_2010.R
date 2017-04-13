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

graph.density(g.2010)  # Densidade
diameter(g.2010)       # Diâmetro
mean_distance(g.2010)  # Distância média


##########################################################################
#### Métricas a nível do invidíduo

indegree = degree(g.2010, mode='in')
outdegree = degree(g.2010, mode='out')
inter = betweenness(g.2010)
constraint = constraint(g.2010)

### Descritiva quanto aos processos
triades = triad_census(g.2010)



#########################################################################
###################  Rede Egocentrada do Brasil  ########################
#########################################################################

brasil = make_ego_graph(g.2010, order = 1, nodes = 'Brazil')
brasil = brasil[[1]]

plot(brasil, vertex.size=5, vertex.label.cex=.9, edge.arrow.size=.3, 
     #edge.width=log(E(g.2010)$weight), 
     edge.color=adjustcolor("grey70", .4),
     main="Rede de fluxos migratórios do Brasil - 2010")




