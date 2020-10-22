require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    Articles.create(params)
    redirect '/articles'
  end

  get '/articles' do
    @articles = Articles.all
    erb :index
  end

  get '/articles/:id' do
    @article = Articles.find(params["id"])
    erb :show
  end
  

  get '/articles/:id/edit' do
    @articles = Articles.find(params["id"])
    erb :edit
  end

  patch '/articles/:id' do
    id = params["id"]
    new_params = {}
    old_post = Articles.find(id)
    new_params[:name] = params["name"]
    new_params[:content] = params["content"]
    old_post.update(new_params)

    redirect "/articles/#{id}"
  end

  delete '/articles/:id/delete' do
    @articles = Articles.find(params["id"])
    @articles.destroy
    erb :delete
  end
end