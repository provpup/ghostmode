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

get '/video' do
  erb :'video'
end

# get '/user_checktimes' do
#   @ary = ['a','b','c','e','f']
#   erb :'user_checktimes'
# end

# idea for listing table data

# <table>
# <% @ary.each do |elem| %>
#   <tr>
#     <td>
#       <%= elem %>
#     </td>
#   </tr>
# <% end %>
# </table> 
  





# get '/authentication' do
#   redirect "https://www.strava.com/oauth/authorize?client_id=4926&response_type="code"&redirect_uri=http://localhost:3000&scope=read"
# end