setwd("~/Developer/episode-ratings")
library(ggplot2)
library(reshape)
library(scales)

#==============================================================================
# CONSTANTS
#==============================================================================
PLOT_SAVE_PATH = "~/Developer/episode-ratings/plots"

#==============================================================================
# HELPER FUNCTIONS
#==============================================================================

#--------------------------------------
# Plot and save combined data with facet_wrap
#--------------------------------------
do_facet_plot = function(data, title, subtitle) {
  ggplot(
    data, 
    aes(
      x = as.factor(season), 
      y = factor(episode, levels = rev(sort(unique(episode)))), 
      fill = rating
    )
  ) + 
    facet_wrap(
      vars(name),
      scales = "free",
      ncol = 3,
    ) +
    geom_tile(color = "white") + 
    scale_fill_gradient2(
      low = "red", 
      mid = "white", 
      high = "green", 
      midpoint = median(data$rating)
    ) + 
    labs(
      x = "Season",
      y = "Episode",
      title = title,
      subtitle = subtitle,
      caption = "Visualization by @yaylinda",
      fill = "Rating"
    ) + 
    theme(
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(), 
      axis.ticks = element_blank(),
      strip.text.y = element_text(size = 12, angle = 180),
      strip.text.x = element_text(size = 12),
      plot.title = element_text(size = 24),
      aspect.ratio = 1,
      plot.margin = margin(0.5, 0, 0.5, 0, "in"),
    )
  
  ggsave(
    "combined.png",
    path = PLOT_SAVE_PATH,
    dpi = 320,
    width = 17,
    height = 17,
    device = "png",
    units = "in"
  )
}

#--------------------------------------
# Plot and save one dataset (one TV show)
#--------------------------------------
do_one_plot = function(data, title, height = 10, width = 10) {
  ggplot(
    data, 
    aes(
      x = as.factor(season), 
      y = factor(episode, levels = rev(sort(unique(episode)))), 
      fill = rating
    )
  ) + 
    geom_tile(color = "white") + 
    scale_fill_gradient2(
      low = "red", 
      mid = "white", 
      high = "green", 
      midpoint = median(data$rating)
    ) + 
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
      axis.ticks = element_blank(),
      strip.text.y = element_text(size = 12, angle = 180),
      strip.text.x = element_text(size = 12),
      plot.title = element_text(size = 20)
    )
  
  ggsave(
    paste(gsub("'", "", gsub(" ", "", title, fixed = TRUE)), ".png", sep = ""), 
    path = PLOT_SAVE_PATH,
    dpi = 320,
    width = width,
    height = height,
    device = "png",
    units = "in"
  )
}

#==============================================================================
# READ DATA
#==============================================================================

bobsburgers = read.csv('data/bobsburgers.csv')
bobsburgers$name = "Bob's Burgers"

familyguy = read.csv('data/familyguy.csv')
familyguy$name = "Family Guy"

friends = read.csv('data/friends.csv')
friends$name = "Friends"

greysanatomy = read.csv('data/greysanatomy.csv')
greysanatomy$name = "Grey's Anatomy"

iasip = read.csv('data/iasip.csv')
iasip$name = "It's Always Sunny In Philadelphia"

pokemon = read.csv('data/pokemon.csv')
pokemon$name = "Pokemon"

simpsons = read.csv('data/simpsons.csv')
simpsons$name = "The Simpsons"

southpark = read.csv('data/southpark.csv')
southpark$name = "South Park"

spongebob = read.csv('data/spongebob.csv')
spongebob$name = "SpongeBob SquarePants"

thewalkingdead = read.csv('data/thewalkingdead.csv')
thewalkingdead$name = "The Walking Dead"

#==============================================================================
# MASSAGE DATA
#==============================================================================

# Combine the data (just picking 9 from the above)
combined = do.call(
  "rbind", 
  list(
    bobsburgers, 
    familyguy, 
    friends, 
    greysanatomy, 
    iasip, 
    thewalkingdead, 
    simpsons, 
    southpark, 
    spongebob
  )
)

combined$name = as.factor(combined$name)

#==============================================================================
# PLOT DATA
#==============================================================================

do_facet_plot(
  combined, 
  "TV Show Ratings", 
  "From IMDb User Ratings of popular US shows with 10+ seasons"
)

for (show_name in unique(combined$name)) {
  data = combined[which(combined$name == show_name), ]
  do_one_plot(data, show_name)
}

do_one_plot(pokemon, "Pokemon", height = 12, width = 12)


