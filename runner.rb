require 'CSV'
require 'json'
require './lib/shortened_link'
require './lib/click'

# encodes.csv and decodes.json files
encodes_csv_file = './data/encodes.csv'
decodes_json_file = File.read('./data/decodes.json')

# csv and json files converted to ruby objects respectively
encodes_objects = ShortenedLink.csv_import(encodes_csv_file)
decodes_objects = Click.all_clicks(decodes_json_file)

# filtering clicks by year
yearly_clicks = Click.clicks_by_year(decodes_objects, 2021)

# counts all of the clicks of each bitlink
# for the selected year (this case being the year 2021)
click_count = Click.url_click_count(encodes_objects, yearly_clicks)

# prints the results in json format
puts click_count.to_json
