import csv
import requests
from scraper_configs import *  


def get_html(url):
  """ Returns the HTML of the url page """

  r = requests.get(url)
  html = r.text

  return html


def parse_html(html, showConfig):
    """ Parses the input HTML for episode ratings"""

    lines = html.split('\n')

    data = []
    start_search = False
    for line in lines:
        if showConfig['line_search'] in line:
            start_search = True
        if showConfig['line_start'] in line and start_search:
            rating = line.split(showConfig['line_start'])[1].split(showConfig['line_end'])[0]
            data.append(rating)
            start_search = False

    return data


def transform_data(data):
    """ Transforms the input data into an array of { season, episode, rating } objects """
    transformed = []

    for season in data:
        for i in range(0, len(data[season])):
            datum = {}
            datum['season'] = season
            datum['episode'] = i + 1
            datum['rating'] = data[season][i]
            transformed.append(datum)

    return transformed


def write_csv(data, filename):
    """ Writes a CSV file of the ratings data """

    with open('data/' + filename + '.csv', 'w') as file:
        writer = csv.DictWriter(file, fieldnames=['season','episode','rating'])                                               
        writer.writeheader()
        for row in data:
            writer.writerow(row)



def process_show(showConfig):
    """ For each show, scrape the websites and get the ratings for each season, for each episode """

    all_seasons = {}
    for i in range(1, showConfig['num_seasons'] + 1):
        print("\tProcessing Seasion " + str(i))
        url = showConfig['imdb_url'] + str(i)
        html = get_html(url)
        data = parse_html(html, showConfig)
        all_seasons[i] = data
    
    return all_seasons


def main():
    for showConfig in CONFIGS:
        print("Processing " + showConfig['show'] + "...")
        all_seasons = process_show(showConfig)

        transformed = transform_data(all_seasons)
        write_csv(transformed, showConfig['data_file_name'])

    print('Done!\n')

if __name__ == '__main__':
    main()