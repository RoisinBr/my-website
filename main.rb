require 'sinatra'
require 'sinatra/reloader' if settings.development?
require 'pry'
require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/article'
require_relative 'models/quote'
require_relative 'models/counter'


enable :sessions

helpers do 
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !! current_user
  end
end

get '/' do
  erb :index
end

get '/about' do
  erb :about
end

get '/gender-equality' do
  @articles = Article.where(category: "gender")
  @counter = Counter.first
  # binding.pry
  erb :gender_equality
end

get '/other' do
  @articles = Article.where(category: "other")
  erb :other
end

get '/sport' do
  @articles = Article.where(category: "sport")
  erb :sport
end

get '/supernatural' do
  @articles = Article.where(category: "super")
  erb :supernatural
end

get '/technology' do
  @articles = Article.where(category: "tech")
  erb :technology
end 

get '/articles/:id' do
  @article = Article.find(params[:id])
  @article_author = "#{User.find(@article.user_id).first_name} #{User.find(@article.user_id).surname}"
  erb :show
end

get '/articles/:id/edit' do
  @article = Article.find(params[:id])
  @article_author = "#{User.find(@article.user_id).first_name} #{User.find(@article.user_id).surname}"
  redirect '/' unless logged_in?
  erb :update
end

put '/articles/:id' do
  article = Article.find(params[:id])
  article.hero_image = params[:hero_image]
  article.title = params[:title]
  article.article = params[:article]
  article.category = params[:category]
  article.save
  redirect "articles/#{params[:id]}"
end

get '/login' do
  erb :login
end

post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/admin'
  else 
    erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end

get '/admin' do 
  if current_user
    redirect '/login' unless current_user.permission == 'admin'
    erb :admin
  else
    erb :error
  end
end

post '/articles' do
  article = Article.new
  article.hero_image = params[:hero_image]
  article.title = params[:title]
  article.article = params[:article]
  article.category = params[:category]
  article.date_published = Time.now
  article.user_id = current_user.id
  article.save
  redirect '/admin'
end

post '/quotes' do
  quote = Quote.new
  quote.quote = params[:quote]
  quote.author = params[:author]
  quote.more_detail = params[:more_detail]
  quote.date_published = Time.now
  quote.user_id = current_user.id
  quote.save
  redirect '/admin'
end

post '/users' do
  user = User.new
  user.first_name = params[:first_name]
  user.surname = params[:surname]
  user.email = params[:email]
  user.phone = params[:phone]
  user.profile_picture = params[:profile_picture]
  user.password = params[:password]
  user.permission = params[:permission]
  user.save
  redirect '/admin'
end

delete '/articles/:id' do
  article = Article.find(params[:id])
  article.delete
  redirect '/'
end

put '/counters/:id' do
  count = Counter.find(params[:id])
  count.dead_women = count.dead_women += 1;
  count.save
  redirect '/gender-equality'
end

