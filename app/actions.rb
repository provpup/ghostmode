# Homepage (Root path)
get '/' do
  erb :index
end

get '/user/dashboard' do
  erb :'dashboard'
end

get '/user/route' do
  erb :'route'
end

get '/user/post' do
  erb :'post'
end

get '/user/compare' do
  erb :'compare'
end

post '/comparison' do
  # DO stuff
  route_id = params[:route_id]
  user_id = params[:user_id]
  comparative_user_id = params[:comparative_user_id]

  run = Run.find_by(user_id: user_id, route_id: route_id)
  if run
    route = Route.find(route_id)
    # @all_runs_for_route = Run.find_by(route_id: route_id)
    @all_runs_for_route = Run.where(route_id: route_id).to_a

    run1 = @all_runs_for_route.last
    @run1 = TimeJudge.run_checkpoint_times(run1).values
    run2 = @all_runs_for_route.first
    @run2 = TimeJudge.run_checkpoint_times(run2).values

    @check_points_with_split_times = TimeJudge.split_times(run1, run2)
    @check_points = @check_points_with_split_times.keys
    @split_times = @check_points_with_split_times.values

    split_total = @split_times.inject(0.0) { |sum, time| sum + time }
    if split_total > 0
      @winner_message = "User 1 Wins"
    else
      @winner_message = "User 1 Loses"
    end
  
    # redirect 'user/compare'
    erb :'compare'
  end

end

  

