require './config/environment'
require 'sinatra/base'
require 'rack-flash'


class ApplicationController < Sinatra::Base
  enable :sessions
  use Rack::Flash
  configure do
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end




  get '/users/:slug' do
    slug = params[:slug]
    @user = User.find_by_slug(slug)
    erb :"users/show"
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end
