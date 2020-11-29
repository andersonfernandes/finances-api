Rails.application.routes.draw do
  apipie

  namespace :v1 do
    post 'authenticate' => 'authentication#authenticate'

    resources :accounts, only: %i[index]
    resources :categories, only: %i[index show create update destroy]
    resources :transactions, only: %i[index show create update destroy]
  end
end
