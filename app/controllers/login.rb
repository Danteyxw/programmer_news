get '/login' do
  erb :login
end

# add validations later
post '/login' do
  username = params[:username]
  password = params[:password]

  user = User.find_by(username: username)

  unless (user.nil?)
    if (password == user.password)
      session[:user] = user.username
      redirect '/'
    else
      @error = "password does not match."
    end
  else
    @error = "user does not exist."
  end
  redirect "/login?error=#{@error}"
end

post '/signup' do
  username = params[:username]
  password = params[:password]

  user = User.find_by(username: username)

  if (user.nil?)
    User.create(username: username, password: password)
    session[:user] = user.username
    redirect '/'
  else
    @error = "user already exist."
  end
  redirect "/login?error=#{@error}"
end

get '/logout' do
  session[:user] = nil

  redirect '/'
end