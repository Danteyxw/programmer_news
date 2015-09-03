get '/' do
  @posts = Post.all
  erb :index
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
    erb :submit
  else
    @error = "Please login or sign up to submit a post."
    redirect "/login?error=#{@error}"
  end
end