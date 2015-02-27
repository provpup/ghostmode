# Homepage (Root path)
get '/' do
  erb :index
end

# get '/authentication' do
#   redirect "https://www.strava.com/oauth/authorize?client_id=4926&response_type="code"&redirect_uri=http://localhost:3000&scope=read"
# end