#install packages
install.packages(pkgs = c("pheatmap", "RColorBrewer"),
                 dependencies = T)

#load the following packages
library(pheatmap)
library(RColorBrewer)


#data <- read.csv ("https://raw.githubusercontent.com/julianademorais/cancer-secretome/master/R/NLS-heatmap.csv")


data <- read.csv ("https://raw.githubusercontent.com/julianademorais/cancer-secretome/master/R/NLS-heatmap-mutation.csv")



#rename rows after attriubtes
rownames(data) <- data[,1]

#strip attribute column out
data2 <- data[,-1]

fancy_palette <- c("gray96", "white", "steelblue4", "#56B4E9", "salmon", "tomato3", "salmon")

#create heatmap 
pheatmap(data2, scale="none", kmeans_k=NA, cluster_rows=TRUE, cluster_cols=TRUE, color=fancy_palette, treeheight_row=0, 
         treeheight_col=0,legend=FALSE, show_colnames=TRUE, fontsize=12, fontface="bold", border_color="black", 
         width=10, heigth=10, cellwidth=10)
