setwd("~/Developer/southpark-episode-ratings")
library(ggplot2)

data = read.csv('data/pokemon.csv')
title = "Pokemon"


ggplot(data, aes(x = as.factor(season), y = factor(episode, levels = rev(sort(unique(episode)))), fill = rating)) + 
  geom_tile(color = "white") + 
  scale_fill_gradient(low = "#b0f2bc", high = "#257d98") + 
  coord_equal(ratio = 1) + 
  labs(
    x = "Season",
    y = "Episode",
    title = title,
    subtitle = "From IMDb User Ratings",
    caption = "Visualization by @yaylinda",
    fill = "Rating"
  ) + 
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), 
    axis.ticks = element_blank()
  ) +
  theme(strip.text.y = element_text(size = 12, angle = 180)) +
  theme(strip.text.x = element_text(size = 12)) +
  theme(plot.title = element_text(size = 20))
