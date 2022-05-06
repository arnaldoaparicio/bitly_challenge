require 'CSV'
require 'json'
require './lib/shortened_link'


RSpec.describe ShortenedLink do
  it 'exists' do
    shortened_link_object = ShortenedLink.new({
                                                'long_url' => 'https://google.com/',
                                                'domain' => 'bit.ly',
                                                'hash' => '31Tt55y'
                                              })
    expect(shortened_link_object).to be_an_instance_of(ShortenedLink)
  end

  it 'has attributes' do
    shortened_link_object = ShortenedLink.new({
                                                'long_url' => 'https://google.com/',
                                                'domain' => 'bit.ly',
                                                'hash' => '31Tt55y'
                                              })
    expect(shortened_link_object.long_url).to eq('https://google.com/')
    expect(shortened_link_object.domain).to eq('bit.ly')
    expect(shortened_link_object.hash).to eq('31Tt55y')
  end



  it 'converts csv file to ruby object' do
    shortened_link_path = './data/encodes.csv'
    shortened_link_objects = ShortenedLink.csv_import(shortened_link_path)

    expect(shortened_link_objects.count).to eq(6)
    expect(shortened_link_objects[0].domain).to eq('bit.ly')
    expect(shortened_link_objects[0].hash).to eq('31Tt55y')
    expect(shortened_link_objects[0].long_url).to eq('https://google.com/')
  end
end
