Rails.application.routes.draw do
  # Authentication routes
  post '/auth/register', to: 'auth#register'
  post '/auth/login', to: 'auth#login'
  
  # Protected routes
  resources :courses, only: [:index, :show, :create]
  
  # Health check endpoint
  get '/health', to: proc { [200, {}, ['OK']] }
end
