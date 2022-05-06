require 'CSV'
require 'json'
require './lib/shortened_link'
require './lib/click'

RSpec.describe Click do
  it 'exists' do
    click_object = Click.new({
                               'bitlink' => 'http://bit.ly/2kkAHNs',
                               'user_agent' => 'Mozilla',
                               'timestamp' => '2020-02-15T00:00:00Z',
                               'referrer' => 'direct',
                               'remote_ip' => '4.14.247.63'

                             })

    expect(click_object).to be_an_instance_of(Click)
  end

  it 'has attributes' do
    click_object = Click.new({
                               'bitlink' => 'http://bit.ly/2kkAHNs',
                               'user_agent' => 'Mozilla',
                               'timestamp' => '2020-02-15T00:00:00Z',
                               'referrer' => 'direct',
                               'remote_ip' => '4.14.247.63'

                             })

    expect(click_object.bitlink).to eq('http://bit.ly/2kkAHNs')
    expect(click_object.user_agent).to eq('Mozilla')
    expect(click_object.timestamp).to eq('2020-02-15T00:00:00Z')
    expect(click_object.referrer).to eq('direct')
    expect(click_object.remote_ip).to eq('4.14.247.63')
  end

  it 'converts json objects to ruby objects' do
    file = File.read('./data/dummy.json')

    conversion = Click.all_clicks(file)

    expect(conversion.count).to eq(16)

    expect(conversion[0].bitlink).to eq('http://bit.ly/2kkAHNs')
    expect(conversion[0].user_agent).to eq('Mozilla')
    expect(conversion[0].timestamp).to eq('2021-02-15T00:00:00Z')
    expect(conversion[0].referrer).to eq('t.co')
    expect(conversion[0].remote_ip).to eq('4.14.247.63')
  end

  it 'selects all clicks by year (year as a string)' do
    json_file = File.read('./data/dummy.json')

    click_objects = Click.all_clicks(json_file)

    expect(Click.clicks_by_year(click_objects, '2021').count).to eq(12)
  end

  it 'selects all clicks by year (year as an int)' do
    json_file = File.read('./data/dummy.json')

    click_objects = Click.all_clicks(json_file)

    expect(Click.clicks_by_year(click_objects, 2021).count).to eq(12)
  end

  it 'counts all clicks' do
    file = File.read('./data/dummy.json')

    shortened_link_path = './data/encodes.csv'
    shortened_link_objects = CSV.read(shortened_link_path, headers: true).map {|row| ShortenedLink.new(row)}

    all_clicks = Click.all_clicks(file)
    clicks_by_year = Click.clicks_by_year(all_clicks, '2021')
    click_counts = Click.url_click_count(shortened_link_objects, clicks_by_year)

    expect(click_counts[0]['https://linkedin.com/']).to eq(5)
    expect(click_counts[1]['https://youtube.com/']).to eq(3)
    expect(click_counts[2]['https://twitter.com/']).to eq(2)
    expect(click_counts[3]['https://github.com/']).to eq(1)
    expect(click_counts[4]['https://google.com/']).to eq(1)
    expect(click_counts[5]['https://reddit.com/']).to eq(0)

  end
end
