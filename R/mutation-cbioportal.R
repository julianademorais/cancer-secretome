#load packages

library(tidyverse)
library(viridis)


data <- read.csv ("https://raw.githubusercontent.com/julianademorais/cancer-secretome/master/R/mutation-cbioportal.csv")

# Set a number of 'empty bar' to add at the end of each group
empty_bar=1
to_add = data.frame( matrix(NA, empty_bar*nlevels(data$group), ncol(data)) )
colnames(to_add) = colnames(data)
to_add$group=rep(levels(data$group), each=empty_bar)
data=rbind(data, to_add)
data=data %>% arrange(group)
data$id=seq(1, nrow(data))

# Get the name and the y position of each label
label_data=data
number_of_bar=nrow(label_data)
angle= 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
label_data$hjust<-ifelse( angle < -90, 1, 0)
label_data$angle<-ifelse(angle < -90, angle+180, angle)

# prepare a data frame for base lines
base_data=data %>% 
  group_by(group) %>% 
  summarize(start=min(id), end=max(id) - empty_bar) %>% 
  rowwise() %>% 
  mutate(title=mean(c(start, end)))

# prepare a data frame for grid (scales)
grid_data = base_data
grid_data$end = grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
grid_data$start = grid_data$start - 1
grid_data=grid_data[-1,]

# Make the plot

p = ggplot(data, aes(x=as.factor(id), y=value, fill=individual)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  
  geom_bar(aes(x=as.factor(id), y=value, fill=individual), stat="identity", alpha=0.5) +
  
  # Add a val=100/75/50/25 lines. I do it at the beginning to make sur barplots are OVER it.
  geom_segment(data=grid_data, aes(x = end, y = 80, xend = start, yend = 80), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
  geom_segment(data=grid_data, aes(x = end, y = 60, xend = start, yend = 60), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
  geom_segment(data=grid_data, aes(x = end, y = 40, xend = start, yend = 40), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
  geom_segment(data=grid_data, aes(x = end, y = 20, xend = start, yend = 20), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
  
  # Add text showing the value of each 100/75/50/25 lines
  annotate("text", x = rep(max(data$id),6), y = c(10, 20, 30, 40, 50, 60), label = c("1", "2", "3", "4", "5", "%") , color="grey", size=2.0 , angle=0, fontface="bold", hjust=0.5) +
  
  geom_bar(aes(x=as.factor(id), y=value, fill=individual), stat="identity", alpha=0.5) +
  
  #geom_bar(aes(x=as.factor(id), y=value, fill=individual), stat="identity", alpha=0.5) +
  
  
  #scale_fill_manual("legend", values = c("Mama" = "#ffc0cb", "Cólon" = "#ffa500", "Sarcoma de Ewing" = "darkblue", "Melanoma" = "#800080", "Ovário"="#ff0000", "Próstata"="#63b8ff", "c"="black", "d"="black", "e"="black", "f"="black", "g"="white", "h"= "white", "i"="black", "j"="black", "k"="black", "l"="black", "m"="black"))+
  
  
  scale_fill_manual("legend", values = c("Breast" = "#ffc0cb", "Colon" = "#ffa500", "Ewing sarcoma" = "darkblue", "Melanoma" = "#800080", "Ovary"="#ff0000", "Prostate"="#63b8ff", "c"="black", "d"="black", "e"="black", "f"="black", "g"="white", "h"= "white", "i"="black", "j"="black", "k"="black", "l"="black", "m"="black"))+
  
  
  
  #scale_fill_manual("legend", values = c("Breast" = "cornflowerblue", "Colon" = "cornflowerblue", "Ewing sarcoma" = "cornflowerblue", "Melanoma" = "cornflowerblue", "Ovary"="cornflowerblue", "Prostate"="cornflowerblue", "c"="black", "d"="black", "e"="black", "f"="black", "g"="white", "h"= "white", "i"="black", "j"="black", "k"="black", "l"="black", "m"="black"))+
  
  
  
  
  #scale_fill_manual("legend", values = c("EIF4B" = "darkmagenta", "LMNA" = "cornflowerblue", "NPM1" = "cadetblue2", "SEPTIN9" = "darkgoldenrod1", "TRIM28" = "burlywood1"))+
  
  

ylim(-100,120) +
  theme_minimal() +
  
  
  theme(
    legend.position = "none",
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-1,4), "cm") 
  ) +
  
  
  
  coord_polar() + 
  geom_text(data=label_data, aes(x=id, y=value+5, label=individual, hjust=hjust), color="black", fontface="bold",alpha=0.6, size=1.8, angle= label_data$angle, inherit.aes = FALSE ) +
  
  # Add base line information
  geom_segment(data=base_data, aes(x = start, y = -5, xend = end, yend = -5), colour = "black", alpha=0.8, size=0.6 , inherit.aes = FALSE )  +
  
  # Gene names 
  geom_text(data=base_data, aes(x = title, y = -18, label=group), hjust=c(0.58,  0.58, 0.7,  0.55,   0.7,   0.6,    0.5,     0.5,    0.4,   0.3,   0.3,     0.25,   0.3,   0.26,   0.52), colour = "black", alpha=0.8, size=3.0, fontface="bold", inherit.aes = FALSE)

p
