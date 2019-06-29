class TeacherController < ApplicationController
    get '/signup' do
        if logged_in?
            redirect to '/repos'
        else
            erb :'/teachers/signup'
        end
    end

    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect to '/signup'
        else
            @teacher = Teacher.create(:username => params[:username], :email => params[:email], :password => params[:password])
            @teacher.authenticate(params[:password])
            session[:user_id] = @teacher.id
            redirect '/repos'
        end
    end

    get '/login' do
        if logged_in?
          redirect '/repos'
        else
          erb :'/teachers/login'
        end
    end

    post '/login' do
        @teacher = Teacher.find_by(:username => params[:username])
        if @teacher && @teacher.authenticate(params[:password])
            session[:user_id] = @teacher.id
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

    get '/teachers/:slug' do
        @teacher = User.find_by_slug(params[:slug])
        if @teacher
            erb :'/teachers/show'
        else
            redirect '/repos'
        end
    end
end