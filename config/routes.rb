# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts do
    collection do
      post :generate
      get :missing_body_count
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
