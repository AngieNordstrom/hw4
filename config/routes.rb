Rails.application.routes.draw do
  get("/", { :controller => "places", :action => "index" })
  get "/login" => "sessions#new"
  post "/sessions" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources "users"
  resources "sessions", only: [:new, :create, :destroy]
  resources "places"
  resources "entries"
end
