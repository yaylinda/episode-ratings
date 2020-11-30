# Episode Ratings

## How to get data for a show
Put a new entry in the `CONFIGS` array, in `scraper_configs.py`, for the show.

Example: 
```
{
    # Title of the show
    "show": "It's Always Sunny in Philadelphia",
    
    # URL of the IMDB seasons/episodes list (note: do not copy+paste the actual season param value here)
    "imdb_url" : "https://www.imdb.com/title/tt0472954/episodes?season=",
    
    # Number of seasons of the show
    "num_seasons" : 15,
    
    # The name of the output data file. Will be saved in `data/<name>.csv`
    "data_file_name" : "iasip",
    
    # These three lines are used for paring and should NOT be modified, unless something goes wrong
    "line_search" : '<div class="ipl-rating-star small">',
    "line_start" : '<span class="ipl-rating-star__rating">',
    "line_end" : '</span>',
},
```
Then run `scraper.py`. The data files will be generated in `data/<name>.csv`

### Visualize the Data

In `code.R` import the CSV by adding it to the "READ DATA" section (follow examples for naming)

Run the function `do_one_plot(data, title)` to plot one dataset. This will automatically save the plot to the `/plots` directory.

Run the function `do_facet_plot(data, title, subtitle)` to plot multiple datasets in a facet grid. Note that in this case, `data` is a long dataframe of multiple shows (see the data structure of `combined`). This will automatically save the plot to the `/plots` directory.

Adjust the labels and size of the plots, as necessary.

## Plots

### Combined (9 popular shows with 10+ seasons)
![combined](/plots/combined.png)

### South Park
![South Park Episode Ratings](/plots/South Park.png)

### Pokemon
![Pokemon Episode Ratings](/plots/Pokemon.png)

### The Simpsons
![The Simpsons Episode Ratings](/plots/The Simpsons.png)

### Family Guy
![Family Guys Episode Ratings](/plots/Family Guy.png)

### Grey's Anatomy
![Grey's Anatomy Episode Ratings](/plots/Grey's Anatomy.png)

### Bob's Burgers
![Bob's Burgers Episode Ratings](/plots/Bob's Burgers.png)

### Friends
![Friends Episode Ratings](/plots/Friends.png)

### It's Always Sunny in Philadelphia
![It's Always Sunny in Philadelphia Episode Ratings](/plots/It's Always Sunny in Philadelphia.png)

### The Walking Dead
![The Walking Dead Episode Ratings](/plots/The Walking Dead.png)

### SpongeBob SquarePants
![SpongeBob SquarePants Episode Ratings](/plots/SpongeBob SquarePants.png)
