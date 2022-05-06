require 'json'

class Click
  attr_reader :bitlink, :user_agent, :timestamp, :referrer, :remote_ip

  def initialize(attributes)
    @bitlink = attributes['bitlink']
    @user_agent = attributes['user_agent']
    @timestamp = attributes['timestamp']
    @referrer = attributes['referrer']
    @remote_ip = attributes['remote_ip']
  end

# This will convert all elements from the decodes.json file
# and turn them into objects
  def self.all_clicks(click_json_file)
    data_hash = JSON.parse(click_json_file)
    data_hash.map do |click|
      Click.new(click)
    end
  end

# Selects all clicks that can will select all clicks based on year
  def self.clicks_by_year(click_list, year)
    click_list.find_all { |i| i.timestamp.include?(year.to_s) }
  end

# This counts all the clicks for each long_url
  def self.url_click_count(link_objects, yearly_clicks)

# Lines 32 - 38 creates the array of hashes that sets up the solution
# Default value for each long_url is 0 and is our accumulator
    list_count = []
    results = {}
    urls = link_objects.each do |shortened|
      results = {}
      results[shortened.long_url] = 0
      list_count << results
    end

# So we our grabbing our variables "yearly_clicks" (json data) and "link_objects" (csv data)
# and we are iterating through each of them. So the way it starts is that it will grab
# the first element of the json data and will loop though all of the objects from our csv data.

# So if the combination of the domain and hash is equal to the click's bitlink,
# then it add 1 (+1)to its respective long_url. This process will repeat for
# each object in "link_objects"
    yearly_clicks.each do |click|
      link_objects.each do |shortened|
        if click.bitlink.include?(shortened.domain + '/' + shortened.hash)
          list_count.find { |bit| bit[shortened.long_url] }[shortened.long_url] += 1
        end
      end
    end

# This grabs our solution (list_count) and converts each hash in the array
# into an array. It will then sort it by the numerical value in each array in descending order.
# Then it converts each array back to a hash.
    list_count_as_array = list_count.map { |x| x.to_a }
    lc_descending = list_count_as_array.sort_by { |x| x[0][1] }.reverse
    lc_descending.map { |x| x.to_h }
  end
end
