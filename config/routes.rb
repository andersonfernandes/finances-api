Rails.application.routes.draw do
  namespace :v1 do
    post 'authenticate' => 'authentication#authenticate'
  end
end
