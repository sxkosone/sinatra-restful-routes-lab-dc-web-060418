class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    #list all recipes
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    #create a new recipe with params from user's form
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/new' do
    #display form to create new recipe
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    #shows an editing form
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    #update recipe information with params from form
    recipe = Recipe.find(params[:id])
    name = params[:name]
    ingredients = params[:ingredients]
    cook_time = params[:cook_time]
    recipe.update(name: name, ingredients: ingredients, cook_time: cook_time)

    redirect "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id/delete' do
    #delete that post
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect '/recipes'
  end
end