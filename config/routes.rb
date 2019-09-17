Rails.application.routes.draw do
  resources :votes
  devise_for :users

=begin
  devise_scope :user do
    root to: "devise/sessions#new"
  end
=end

  root :to => "votes#new"

  resources :passwords
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
