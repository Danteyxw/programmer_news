post '/post/:id/comment' do
  @post = Post.find(params[:id])
  @user = User.find_by(username: session[:user])
  @post.comments.create(content: params[:content], user_id: @user.id)
  redirect "/post/#{params[:id]}"
end