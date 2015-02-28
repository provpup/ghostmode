require 'nokogiri'
require 'pry'
require 'pry-nav'

# @doc.xpath("//xmlns:trkpt") returning all data
@doc = Nokogiri::XML(File.open('LunchRun.gpx'))

trackpoints = @doc.search("trkpt")
points = []
## parsing xml doc by accessing child arrays in order by position
trackpoints.each do |trkpt|
  points << [trkpt.attributes['lat'].value.to_f, trkpt.attributes['lon'].value.to_f, DateTime.parse(trkpt.children[3].children[0].text)]
  binding.pry
end

  puts points
