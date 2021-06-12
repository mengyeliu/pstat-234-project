setwd("/Users/apple/234")

library(dplyr)
library(ggplot2)
library(ggthemes)
library(hrbrthemes)
library(viridis)

restaurant = read.csv("restaurants_v2.csv")


p1 <- ggplot(restaurant, aes(x=ReviewsNum)) +
        geom_histogram(aes(y=..density..), position="identity",
                       color="black",alpha=.8) +
        labs(x="Number of Reviews", y="Probability Density") +
        theme_light() + 
        theme(plot.title = element_text(hjust = 0.5))
p1

RatingFreq = data.frame(table(restaurant$Rating))
colnames(RatingFreq) = c('rating','Freq')

p2 <- ggplot(RatingFreq, aes(x=rating, y=Freq)) +
        geom_bar(stat="identity", alpha=.8) +
        coord_flip() +
        xlab("Rating") +
        ylab("Count") + 
        theme_light()
p2

p3 <-  ggplot(restaurant, aes(x = ReviewsNum, y = Rating)) + 
        geom_point() +
        geom_point(aes(x=3647,y=4.5),color="darkred",shape=8,size=3) +
        labs(x = "Restaurants' number of ratings", y = "Restaurants' average ratings") +
        scale_color_viridis() +
        theme_light() +
        theme(
                axis.title = element_text(size = 12),
                axis.text.x=element_text(size = 12),
                axis.text.y=element_text(size = 12,angle = 90),
                legend.position = "None"
        )
p3
