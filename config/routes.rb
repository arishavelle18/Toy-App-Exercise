Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'user#index'
  # for users

  # Defines the root path route ("/")
  # load the user action
  get 'users' => 'user#index' , as: "index"
  # load show action
  get 'users/:id' => 'user#show' ,constraints: {id:/\d+/}, as:"user"
  get 'users/new' => 'user#new', as:"new"
  post "users" => 'user#create'
  get 'users/:id/edit' => 'user#edit', as:"edit"
  patch 'users/:id' => 'user#update', as:"update"

  # delete
  delete 'users/:id/delete' => 'user#destroy', as:"user_delete"
  get 'users/:id/delete' => 'user#destroy'  
 
  # for micropost
  
  # # all micropost routes
  get 'microposts/' => 'microposts#index',as:"microposts"
  # navigate to create micropost
  get 'microposts/new' => 'microposts#new',as:"micropost_new_post"
  # create post 
  post 'microposts/' => 'microposts#create' 
  # show the specific post
  get 'microposts/:id' => 'microposts#show', as:"micropost"
  # edit 
  get 'microposts/:id/edit' => "microposts#edit",as:"edit_micropost"
  # update micropost route
  patch 'microposts/:id' => "microposts#update"
  # delete micropost route
  delete 'microposts/:id/delete' => "microposts#destroy", as:"micropost_delete"
  get 'microposts/:id/delete' => "microposts#destroy"

  resource:microposts
  
end
