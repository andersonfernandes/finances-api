Rails.application.routes.draw do
  apipie

  namespace :v1 do
    post 'auth/access_token' => 'authentication#access_token'

    resources :accounts, only: %i[index show create update destroy]
    resources :categories, only: %i[index show create update destroy]
    resources :transactions, only: %i[index show create update destroy]
    resources :financial_institutions, only: %i[index show]
  end
end
