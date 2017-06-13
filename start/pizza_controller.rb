require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('models/pizza')

#everytime sinatra trys to find an action goes from top to bottom - so need to put NEW action above SHOW action as otherwise: get "/pizzas/new" would just pass in 'new' to id params in the route as :id can be anything...!


#index action using ruby code to get all pizzas saving into an instance variable to persist it to db and so can use instance variable in index.erb file:
get "/pizzas" do
  @pizzas = Pizza.all()
  erb(:index)
end

#the new action:
get "/pizzas/new"  do
  erb(:new)
end

# the show action:
get "/pizzas/:id" do
  @pizza = Pizza.find(params["id"].to_i())
  erb(:show)
end

# create action. First line of code calls the initialize, pass in the params hash got back from the form, then call save method on it.
post "/pizzas" do
  @pizza = Pizza.new(params)
  @pizza.save()
  erb(:create)
end

# delete action
post "/pizzas/:id/delete" do
  @pizza = Pizza.find(params["id"].to_i())
  @pizza.delete()
  erb(:delete)
end

# edit action
get "/pizzas/:id/edit" do
  @pizza = Pizza.find(params["id"].to_i())
  erb(:edit)
end

# update action
post "/pizzas/:id/update" do
  @pizza = Pizza.new(params)
  @pizza.update()
  erb(:update)
end