class UsersController < ApplicationController

    get '/login-signup' do
        erb :'users/login_signup'
    end

    post '/signup' do
        if params[:username] == "" || params[:password] == ""
            redirect to '/failure'
        end

        user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if user.save
            redirect to '/login-signup'
        else
            redirect to '/failure'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
         if @user && @user.authenticate(params[:password])
           session[:user_id] = @user.id
           erb :"/users/my_tweets"
         else
           redirect to "/failure"
         end
      end

      get "/logout" do
        session.clear
        redirect "/"
      end

      get '/failure' do
        erb :failure
      end



end
