Rails.application.routes.draw do
  apipie

  namespace :v1 do
    post 'authenticate' => 'authentication#authenticate'

    resources :categories, only: %i[index show create update destroy]
    resources :expenses, only: %i[index show create update destroy]
  end
end
