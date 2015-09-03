get '/profile/:id' do
  @user = User.find(params[:id])

  unless (@user.nil?)
    erb :profile
  else
    @error = "Please login or sign up to view your profile."
    redirect "/login?error=#{@error}"
  end
end

get '/profile/posts/:id' do
  @user = User.find(params[:id])
  @posts = @user.posts

  erb :posts
end

get '/profile/comments/:id' do
  @user = User.find(params[:id])
  @comments = @user.comments

  erb :comments
end

post '/post/:id/delete' do
  post = Post.find(params[:id])
  if (session[:user] == post.user.username)
    post.comments.each {|comment| comment.delete}
    post.delete
    redirect "/profile/#{post.user.id}/posts"
  else
    @error = "You are not #{post.user.username}."
    redirect "/profile/#{post.user.id}/posts/?error=#{@error}"
  end
end