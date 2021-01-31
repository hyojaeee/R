getwd()
setwd("/Users/hyojae/Desktop/R Studio/GGplot2")
project <- read.csv("Section6-Homework-Data.csv")

library(ggplot2)
str(project)

project$Genre <- factor(project$Genre)
project$Studio <- factor(project$Studio)
colnames(project) <- c("Day", "Director", "Genre", "Title", "ReleaseDate", "Studio", "Adjusted", "Budget", "Gross", "IMDb", "MovieLens", "OverseasMil", "Overseas", "ProfitMil", "Profit", "Runtime", "USMil", "GrossUS")

#filtering
G <- project$Genre == "action" | project$Genre == "adventure" | project$Genre == "animation" | project$Genre == "comedy" | project$Genre == "drama"
S <- project$Studio %in% c("Buena Vista Studios", "Fox", "Paramount", "Sony", "Universal", "WB")
p2 <- project[G & S,]


#plot
a <- ggplot(data = p2, aes(x = Genre, y = GrossUS))
b <- a + geom_jitter(aes(color = Studio, size = Budget)) + geom_boxplot(alpha = 0.6, outlier.color = NA) 

b <- b +
  xlab("Genre") +
  ylab("Gross % US") +
  ggtitle("Domestic Gross % by Genre") +
  
  theme(axis.title.x = element_text(color = "Blue", size = 15), 
        axis.title.y = element_text(color = "Blue", size = 15),
        plot.title = element_text(size = 20, family = "Courier"),
        legend.title = element_text(size = 10))

b$labels$size <- "Budget $M"
b
