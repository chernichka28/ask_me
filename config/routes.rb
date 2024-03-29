Rails.application.routes.draw do
  resources :hashtags, only: [:show], param: :name
  root to: "questions#index"

  resources :questions do
    member do
      put "hide"
    end
  end

  resource :session, only: %i[new create destroy update]

  resources :users, except: %i[index], param: :nickname
end
