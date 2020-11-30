import csv
import requests

NUM_SEASONS = 24
BASE_URL = 'https://www.imdb.com/title/tt0121955/episodes?season='
LINE_SEARCH = '<div class="ipl-rating-star small">'
LINE_START ='<span class="ipl-rating-star__rating">'
LINE_END = '</span>'


def get_html(url):
  """ Returns the HTML of the url page """

  r = requests.get(url)
  html = r.text

  return html


def parse_html(html):
    """ Parses the input HTML for episode ratings"""

    lines = html.split('\n')

    data = []
    start_search = False
    for line in lines:
        if LINE_SEARCH in line:
            start_search = True
        if LINE_START in line and start_search:
            rating = line.split(LINE_START)[1].split(LINE_END)[0]
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


def write_csv(data):
    """ Writes a CSV file of the ratings data """

    with open('data.csv', 'w') as file:
        writer = csv.DictWriter(file, fieldnames=['season','episode','rating'])                                               
        writer.writeheader()
        for row in data:
            writer.writerow(row)


def main():
    all_seasons = {}
    for i in range(1, NUM_SEASONS + 1):
        print('Processing season: ' + str(i))
        url = BASE_URL + str(i)
        html = get_html(url)
        data = parse_html(html)
        all_seasons[i] = data

    transformed = transform_data(all_seasons)
    write_csv(transformed)
    print('\nDone!')


if __name__ == '__main__':
    main()