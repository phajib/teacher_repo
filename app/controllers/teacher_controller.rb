class TeacherController < ApplicationController
    get '/signup' do
        if logged_in?
            redirect to '/repos'
        else
            erb :'/users/signup'
        end
    end

    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect to '/signup'
        else
            @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/repos'
        end
    end

    get '/login' do
        if logged_in?
          redirect '/repos'
        else
          erb :'/users/login'
        end
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/reposs'
        else
            redirect '/login'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
        end
            redirect '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        if @user
            erb :'/users/show'
        else
            redirect '/repos'
        end
    end
end