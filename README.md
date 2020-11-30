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

Update `code.R` with the name of the CSV file to visualize, and the title. 

## Shows
### South Park
![South Park Episode Ratings](/plots/southpark.png)

### Pokemon
![Pokemon Episode Ratings](/plots/pokemon.png)

### The Simpsons
![The Simpsons Episode Ratings](/plots/simpsons.png)

### Family Guy
![Family Guys Episode Ratings](/plots/familyguy.png)

### Grey's Anatomy
![Grey's Anatomy Episode Ratings](/plots/greysanatomy.png)

### Bob's Burgers
![Bob's Burgers Episode Rations](/plots/bobsburgers.png)

### Friends
![Friends Episode Rations](/plots/friends.png)

### It's Always Sunny in Philadelphia
![It's Always Sunny in Philadelphia Episode Rations](/plots/iasip.png)
