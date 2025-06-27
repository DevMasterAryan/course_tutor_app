Rails.application.routes.draw do
  resources :courses, only: [:index, :show, :create]
  
  # Health check endpoint
  get '/health', to: proc { [200, {}, ['OK']] }
end
