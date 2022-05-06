require 'CSV'

class ShortenedLink
  attr_reader :long_url, :domain, :hash
  def initialize(row)
    @long_url = row['long_url']
    @domain = row['domain']
    @hash = row['hash']
  end

# This converts our csv file to objects
  def self.csv_import(csv_file)
     CSV.read(csv_file, headers: true).map {|row| ShortenedLink.new(row)}
  end
end
