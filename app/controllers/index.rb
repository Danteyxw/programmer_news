get '/' do
  @posts = Post.all
  erb :index
end

get '/login' do
  erb :login
end

get '/post/:id' do
  @post = Post.find(params[:id])
  @comments = @post.comments
  erb :post
end

post '/submit' do
  user = User.find_by(username: session[:user])
  title = params[:title]
  link = params[:link]

  unless (user.nil?)
    user.posts.create(title: title, link: link)
    redirect '/'
  else
    @error = "Please login or sign up to submit a post."
    redirect "/login?error=#{@error}"
  end
end

get '/submit' do
  unless (session[:user].nil?)
    erb :submissions
  else
    @error = "Please login or sign up to submit a post."
    redirect "/login?error=#{@error}"
  end
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

get '/signout' do
  session[:user] = nil

  redirect '/'
end