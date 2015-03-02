class Import 

  def initialize(gpxFile, route_id = nil)
    @gpxFile = gpxFile
    @route_id = route_id
    @points = []
  end

  def initializer
    Parse
    if @route_id
      create_run(@route_id)
    else
      create_route_checkpoints
      create_run(@route.id)
    end 
  end

  
  private

  def parse(@gpxFile)
    @doc = Nokogiri::XML(File.open(@gpxFile))
    #@doc.xpath("//xmlns:trkpt") returning all data
    trackpoints = @doc.search("trkpt")
    ## parsing xml doc by accessing child arrays in order by position
    trackpoints.each do |trkpt|
      @points << [trkpt.attributes['lat'].value.to_f, trkpt.attributes['lon'].value.to_f, DateTime.parse(trkpt.children[3].children[0].text)]
    end   
  end

  def create_route_checkpoints
    data_points = []
    checkpoints = []

    data_points << @points.first
    last_point = @points.last 
    points.drop(1).pop
    @points.slice((@points.length/5).round)
    @points.each do |slice|
      @data_points << slice.last
    end
    data_points << last_point

    data_points.each do |point|
      gps_point = GpsPoint.new(latitude: point[0], longitude: point[1], gps_timestamp: point[2])
      gps_point.save
      checkpoints << gps_point 
      end
      checkpoints
  end

  def create_run_points
    run_points = []

    @points.each do |point|
      gps_point = GpsPoint.new(latitude: point[0], longitude: point[1], gps_timestamp: point[2])
      gps_point.save
      run_points << gps_point
    end
    run_points
  end

  def create_run(route_id)
    run = Run.new(gps_points: create_run_points, route_id: route_id)
    run.save
  end

  def create_route
    # @route= Route.new(gps_points: create_route_checkpoints)
    @route= Route.new()
    # @route = Route.create(gps_points: create_route_checkpoints)
  end

end