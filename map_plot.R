setwd("/Users/apple/234")

#library(devtools)
#devtools::install_github("UrbanInstitute/urbnmapr")
library(urbnmapr)
library(dplyr)
library(ggplot2)
library(viridis)  # virids package for the color palette
library(plotly)
library(htmlwidgets)

data("counties")
SB<- counties %>% filter(county_fips=="06083")

restaurant = read.csv("restaurants_v2.csv")
names(restaurant)[6:7] = c("lat","long")

# Rorder data + Add a new column with tooltip text
restaurant <- restaurant %>% 
        arrange(ReviewsNum) %>%
        mutate( mytext=paste(
                "Restaurant: ", Name, "\n", 
                "Rating: ", Rating, "\n", 
                "Number of Reviews: ", ReviewsNum, sep="")
        )

# Make the map (static)
p <- ggplot() +
        geom_polygon(data = SB, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
        geom_point(data = restaurant, aes(x=long, y=lat, size=ReviewsNum, color=ReviewsNum, text=mytext, alpha=Rating)) +
        scale_size_continuous(range=c(1,10)) +
        scale_color_viridis() +
        scale_alpha_continuous(trans="sqrt") +
        theme_void() +
        xlim(-120.7,-119.4) +
        ylim(33.7,35) +
        coord_map() + 
        theme(axis.line=element_blank())

p <- ggplotly(p, tooltip="text")
p

# save the widget in a html file if needed.
saveWidget(p, file="bubblemapsb.html")
