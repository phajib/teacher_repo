class RepoController < ApplicationController
    get '/repos' do
        if logged_in?
            @teacher = current_user
            @repos = Repo.all
            erb :'/repos/index'
        else
            redirect '/login'
        end
    end

    get '/repos/new' do
        if logged_in?
            erb :'/repos/new'
        else
            redirect '/login'
        end
    end

    post '/repos' do
        if logged_in?
            if !params[:content].empty?
                current_user.repos << Repo.create(content: params[:content], user_id: current_user.id)
            else
                redirect '/repos/new'
            end
            redirect "repos/#{@repo.id}"
        else
            redirect '/login'
        end
    end

    get '/repos/:id' do
        if logged_in?
          @repo = Repo.find_by_id(params[:id])
          erb :'repos/show'
        else
          redirect '/login'
        end
    end

    get '/repos/:id/edit' do
        if logged_in?
          @repo = Repo.find(params[:id])
            if @repo && @repo.user == current_user
              erb :'repos/edit'
            else
              redirect "/repos"
            end
        else
          redirect '/login'
        end
    end

    patch '/repos/:id' do
        if logged_in?
            @repo = Repo.find_by_id(params[:id])
            if params[:content].empty?
                redirect to "/repos/#{@repo.id}/edit"
            else
                if @repo && @repo.user == current_user
                    @repo.update(:content => params[:content])
                else
                    # redirect "/repos/#{@repo.id}/edit"
                    redirect "/repos/#{params[:id]}/edit"
                end
                # redirect "/repos"
                redirect "/repos/#{params[:id]}"
            end
        else
            redirect '/login'
        end
    end

    delete '/repos/:id/delete' do
        if logged_in?
          @tweet = Repo.find_by_id(params[:id])
          if @repo.user == current_user
            @repo.destroy
          end
          redirect '/repos'
        else
          redirect '/login'
        end
    end
end