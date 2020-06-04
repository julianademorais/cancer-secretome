#install packages
install.packages(pkgs = c("pheatmap", "RColorBrewer"),
                 dependencies = T)

#load packages
library(pheatmap)
library(RColorBrewer)

data <- read.csv ("https://raw.githubusercontent.com/julianademorais/cancer-secretome/master/R/heatmap-shared15.csv")

#rename rows after attributes
rownames(data) <- data[,1]

#strip attribute column out
data2 <- data[,-1]

#create heatmap 
pheatmap(data2, scale="row", kmeans_k=NA, cluster_rows=TRUE, cluster_cols=TRUE, color=c("gray96", "royalblue4"), treeheight_row=0, 
         treeheight_col=0,legend=FALSE, show_colnames=TRUE, fontsize=20, fontface="bold", border_color="gray", 
         width=10, heigth=10, cellwidth=40)
