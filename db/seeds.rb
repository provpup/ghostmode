require 'nokogiri'

def create_route_checkpoints(points)
  data_points = []

  first_point = points.shift
  data_points << first_point

  last_point = points.pop
  (points.size / 5..points.length - 1).step(points.size / 5).each { |index| data_points << points[index] }

  data_points << last_point

puts data_points.inspect

  data_points.map { |point| GpsPoint.create(latitude: point[0], longitude: point[1], gps_timestamp: point[2]) }
end

['lunchrun_01.gpx', 'lunchrun_02.gpx', 'lunchrun_03.gpx'].each do |filename|
  gpxPath = Pathname.new(File.expand_path(filename, File.dirname(__FILE__)))
  @doc = Nokogiri::XML(File.open(gpxPath))

  trackpoints = @doc.search("trkpt")
  ## parsing xml doc by accessing child arrays in order by position
  points = []
  trackpoints.each do |trkpt|
    points << [trkpt.attributes['lat'].value.to_f, trkpt.attributes['lon'].value.to_f, DateTime.parse(trkpt.children[3].children[0].text)]
  end

  user = User.first

  unless user
    user = User.create(username: 'username', password: 'password')
  end

  route = Route.first

  unless route
    # Create route
    checkpoints = create_route_checkpoints(points)
    route = Route.new
    route.gps_points.concat(checkpoints)
    route.save!
  end

  run_points = []
  points.each do |point|
    run_points << GpsPoint.new(latitude: point[0], longitude: point[1], gps_timestamp: point[2])
  end

  run = Run.new(user_id: user.id, route_id: route.id)
  run.gps_points.concat(run_points)
  run.save
end
