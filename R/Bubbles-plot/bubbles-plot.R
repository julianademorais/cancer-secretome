#Bubbles plot

install.packages(pkgs = c("ggplot2","plotly"),
                 dependencies = T)

library(ggplot2)
library(plotly)

data <- read.csv(file.choose(), header=T, sep=";") #select file

plot_ly(data, x = data$x, y = data$y , type="scatter", mode="markers" , marker=list(color="darkcadetblue" , size=40 , opacity=0.5) )%>%

  layout(title = 'Cancer type',
       xaxis = list(title = '-log10(p-value)',
                    showgrid = TRUE),
       
       yaxis = list(title = 'Location in the cell',
                    showgrid = TRUE),
       showlegend = FALSE)

#example of colors= pink, orange, gold, golden rod, magenta, plum, red, turquoise, navy, black