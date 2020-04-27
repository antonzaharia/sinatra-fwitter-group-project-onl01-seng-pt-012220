class TweetsController < ApplicationController

    get '/my-tweets' do
        @user = User.find(session[:user_id])
        erb :'users/my_tweets'
    end

    get '/tweets/new' do
        erb :'/tweets/new'
    end

    post '/tweets' do
        @tweet = Tweet.create(content: params[:content])
        @tweet.user = current_user
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        
        erb :'/tweets/edit'
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
    
        redirect to("/tweets/#{@tweet.id}")
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.delete
        redirect to '/my-tweets'
    end


    get '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/show'
    end



end
