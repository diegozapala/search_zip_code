Rails.application.routes.draw do
  root 'home#index'

  post '/login', to: 'auth#login'

  namespace :api do
    get  '/' , to: 'general#index'

    namespace :v1 do
      get  '/'          , to: 'general#index'
      get  '/:zip_code' , to: 'general#search'
    end
  end

end
