# Migration Network - 2010
# Análises
# Data - UN
# Neylson Crepalde
#############################

setwd("~/Documentos/Neylson Crepalde/Doutorado/sea_populacoes/migracoes")
source("monta_rede_migracoes_2010.R")
source("multiplot.R")

#########
# Se precisar do latlon para plotagem...
#latlon = read_csv2("~/Documentos/Neylson Crepalde/Doutorado/sea_populacoes/Seminario Big Data/rede_latlon.csv")
#########

library(igraph)
library(texreg)
library(ggplot2)

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
     layout=layout_with_fr, main="Rede de fluxos migratórios - 2010")

###########################################################################
#### Métricas a nível de rede

graph.density(g.2010, loops = T)  # Densidade
diameter(g.2010)       # Diâmetro
mean_distance(g.2010)  # Distância média


##########################################################################
#### Métricas a nível do invidíduo

indegree = degree(g.2010, mode='in')
outdegree = degree(g.2010, mode='out')
inter = betweenness(g.2010)
constraint = constraint(g.2010)

g1 = ggplot(NULL, aes(indegree))+geom_histogram()+labs(title='Grau de entrada',x='',y='')
g2 = ggplot(NULL, aes(outdegree))+geom_histogram()+labs(title='Grau de saída',x='',y='')
g3 = ggplot(NULL, aes(inter))+geom_histogram()+labs(title='Centralidade Betweeness',x='',y='')
g4 = ggplot(NULL, aes(constraint))+geom_histogram()+labs(title='Constraint',x='',y='')

multiplot(g1, g3, g2, g4, cols=2)
### Descritiva quanto aos processos
triades = triad_census(g.2010)



#########################################################################
###################  Rede Egocentrada do Brasil  ########################
#########################################################################

brasil = make_ego_graph(g.2010, order = 1, nodes = 'Brazil')
brasil = brasil[[1]]

plot(brasil, vertex.size=5, vertex.label.cex=.9, edge.arrow.size=.3, 
     edge.width=E(brasil)$weight/1000, 
     edge.color=adjustcolor("grey70", .4),
     main="Rede de fluxos migratórios do Brasil - 2010")

###########################################################################
#### Métricas a nível de rede

brasil
edge_density(brasil, loops = T)   #Todos os laços
edge_density(simplify(brasil), loops = F)  #Desconsiderando loops e múltiplos
diameter(brasil)       # Diâmetro
mean_distance(brasil)  # Distância média


##########################################################################
#### Métricas a nível do invidíduo

br.indegree = degree(brasil, mode='in')
br.outdegree = degree(brasil, mode='out')
br.inter = betweenness(brasil)
br.constraint = constraint(brasil)

g5 = ggplot(NULL, aes(br.indegree))+geom_histogram(bins=15)+labs(title='BR - Grau de entrada',x='',y='')
g6 = ggplot(NULL, aes(br.outdegree))+geom_histogram(bins=15)+labs(title='BR - Grau de saída',x='',y='')
g7 = ggplot(NULL, aes(br.inter))+geom_histogram(bins=15)+labs(title='BR - Centralidade Betweeness',x='',y='')
g8 = ggplot(NULL, aes(br.constraint))+geom_histogram(bins=15)+labs(title='BR - Constraint',x='',y='')

multiplot(g5, g7, g6, g8, cols=2)

### Descritiva quanto aos processos
br.triades = triad_census(brasil)




