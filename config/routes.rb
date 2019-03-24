Rails.application.routes.draw do
  apipie
  namespace :v1 do
    post 'authenticate' => 'authentication#authenticate'
  end
end
