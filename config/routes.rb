Rails.application.routes.draw do
  root to: redirect('/documentation')
  apipie

  namespace :v1 do
    post 'auth/access_token'  => 'authentication#access_token'
    post 'auth/refresh_token' => 'authentication#refresh_token'
    post 'auth/revoke'        => 'authentication#revoke'

    resources :accounts, only: %i[index show create update destroy]
    resources :categories, only: %i[index show create update destroy]
    resources :transactions, only: %i[index show create update destroy]
    resources :financial_institutions, only: %i[index show]
    resources :credit_cards, only: %i[index show create update destroy]

    get 'users/me' => 'users#me'
  end
end
