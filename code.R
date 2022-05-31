setwd("~/Developer/episode-ratings")
library(ggplot2)
library(reshape)
library(scales)

#==============================================================================
# CONSTANTS
#==============================================================================
PLOT_SAVE_PATH = "~/Developer/episode-ratings/plots"

#==============================================================================
# READ DATA
#==============================================================================

# bobsburgers = read.csv('data/bobsburgers.csv')
# bobsburgers$name = "Bob's Burgers"
# 
# familyguy = read.csv('data/familyguy.csv')
# familyguy$name = "Family Guy"
# 
# friends = read.csv('data/friends.csv')
# friends$name = "Friends"
# 
# greysanatomy = read.csv('data/greysanatomy.csv')
# greysanatomy$name = "Grey's Anatomy"
# 
# iasip = read.csv('data/iasip.csv')
# iasip$name = "It's Always Sunny In Philadelphia"
# 
# pokemon = read.csv('data/pokemon.csv')
# pokemon$name = "Pokemon"
# 
# simpsons = read.csv('data/simpsons.csv')
# simpsons$name = "The Simpsons"
# 
# southpark = read.csv('data/southpark.csv')
# southpark$name = "South Park"
# 
# spongebob = read.csv('data/spongebob.csv')
# spongebob$name = "SpongeBob SquarePants"
# 
# thewalkingdead = read.csv('data/thewalkingdead.csv')
# thewalkingdead$name = "The Walking Dead"

# thebachelor = read.csv('data/thebachelor.csv')
# thebachelor$name = "The Bachelor (2002-2020)"
# 
# thebachelorette = read.csv('data/thebachelorette.csv')
# thebachelorette$name = "The Bachelorette (2003-2019)"

shameless = read.csv('data/shameless.csv')
shameless$name = "Shameless"

#==============================================================================
# HELPER FUNCTIONS
#==============================================================================

#--------------------------------------
# Plot and save combined data with facet_wrap
#--------------------------------------
do_facet_plot = function(
  data, 
  title, 
  subtitle, 
  height = 17, 
  width = 17,
  plotFile = "combined.png", 
  numFacetColumns = 3, 
  doSave = TRUE
) {
  plot = ggplot(
    data, 
    aes(
      x = factor(episode, levels = sort(unique(episode))), 
      y = factor(season, levels = rev(sort(unique(season)))), 
      fill = rating
    )
  ) + 
  facet_wrap(
    vars(name),
    scales = "free",
    ncol = numFacetColumns,
  ) +
  geom_tile(color = "white") + 
  geom_text(
    aes(label = rating), 
    size = 2
  ) +
  scale_x_discrete(position = "top") +
  scale_fill_gradient2(
    low = "red", 
    mid = "white", 
    high = "green", 
    midpoint = median(data$rating)
  ) + 
  labs(
    x = "Episode\n",
    y = "Season\n",
    title = title,
    subtitle = paste(subtitle, "\n", sep = ""),
    caption = "\nVisualization by @yaylinda",
    fill = "Rating"
  ) + 
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), 
    axis.ticks = element_blank(),
    strip.text.y = element_text(size = 12, angle = 180),
    strip.text.x = element_text(size = 12),
    plot.title = element_text(size = 18),
    aspect.ratio = 1,
    plot.margin = margin(0.5, 0.5, 0.5, 0.5, "in"),
    panel.spacing.x = unit(2, "lines")
  )
  
  if (doSave) {
    ggsave(
      plotFile,
      path = PLOT_SAVE_PATH,
      dpi = 320,
      width = width,
      height = height,
      device = "png",
      units = "in"
    )
  }
  
  plot
}

#--------------------------------------
# Plot and save one dataset (one TV show)
#--------------------------------------
do_one_plot = function(data, title, height = 10, width = 10, doSave=TRUE) {
  plot = ggplot(
    data, 
    aes(
      x = factor(episode, levels = sort(unique(episode))), 
      y = factor(season, levels = rev(sort(unique(season)))), 
      fill = rating
    )
  ) + 
  geom_tile(color = "white") + 
  geom_text(
    aes(label = rating), 
    size = 2
  ) +
  scale_fill_gradient2(
    low = "red", 
    mid = "white", 
    high = "green", 
    midpoint = median(data$rating)
  ) + 
  coord_equal(ratio = 1) + 
  scale_x_discrete(position = "top") +
  labs(
    x = "Episode\n",
    y = "Season\n",
    title = title,
    subtitle = "From IMDb User Ratings\n",
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
  
  if (doSave) {
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
  
  plot
}

#==============================================================================
# MASSAGE DATA
#==============================================================================

# Combine the data (just picking 9 from the above)
# combined = do.call(
#   "rbind", 
#   list(
#     bobsburgers, 
#     familyguy, 
#     friends, 
#     greysanatomy, 
#     iasip, 
#     thewalkingdead, 
#     simpsons, 
#     southpark, 
#     spongebob
#   )
# )

combined = do.call(
  "rbind", 
  list(
    shameless
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

#--------------------------------------
# Plot The Bachelor stuff
#--------------------------------------
do_one_plot(thebachelor, "The Bachelor (2002-2020)")
do_one_plot(thebachelorette, "The Bachelorette (2003-2019)")

combined_bach = do.call(
  "rbind",
  list(
    thebachelor,
    thebachelorette
  )
)

combined_bach$name = as.factor(combined_bach$name)

do_facet_plot(
  combined_bach, 
  "The Bachelor(ette) Ratings", 
  "",
  plotFile = "thebachcombined.png",
  numFacetColumns = 2,
  height = 10,
  width = 12
)

