require_relative 'models/run'
require_relative 'models/route'

class TimeJudge

  def self.run_checkpoint_times(run)
    route = Route.find(run.route_id)
    checkpoints = route.gps_points.to_a

    run_candidate_milestones = checkpoints.map { |checkpoint| GpsPoint.closest_point(checkpoint, run.gps_points) }

    relative_times = []
    run_candidate_milestones.each_cons(2) do |race_segment|
      run_relative_time = race_segment[-1].gps_timestamp - race_segment[0].gps_timestamp
      relative_times << run_relative_time
    end

    checkpoints.shift

    Hash[checkpoints.zip(relative_times)]
  end

  def self.split_times(run1, run2)
    raise(ArgumentError, 'Run objects belongs to different routes') if run1.route_id != run2.route_id

    route = Route.find(run1.route_id)
    checkpoints = route.gps_points.to_a

    # Find the GPS coordinates for each run that is closest to the checkpoints
    # and then merge them into one array
    run1_candidate_milestones = checkpoints.map { |checkpoint| GpsPoint.closest_point(checkpoint, run1.gps_points) }
    run2_candidate_milestones = checkpoints.map { |checkpoint| GpsPoint.closest_point(checkpoint, run2.gps_points) }
    milestones = run1_candidate_milestones.zip(run2_candidate_milestones)

    # The resulting array is actually an array of arrays of
    # two GpsPoint objects each (one from each run)
    # We compute the relative time of each segment by examining
    # two elements of the larger array at a time
    checkpoint_split_times = []
    milestones.each_cons(2) do |race_segment|
      run1_relative_time = race_segment[-1].first.gps_timestamp - race_segment[0].first.gps_timestamp
      run2_relative_time = race_segment[-1].last.gps_timestamp - race_segment[0].last.gps_timestamp

      checkpoint_split_times << (run2_relative_time - run1_relative_time)
    end
    # Get rid of the first checkpoint (the starting point) because we have
    # one fewer split time value than checkpoint
    checkpoints.shift

    # Return a hash between checkpoint and the two runs' split times
    Hash[checkpoints.zip(checkpoint_split_times)]
  end
end
