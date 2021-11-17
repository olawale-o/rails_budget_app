Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    confirmatios: 'confirmations'
  }, pathname: {
    sign_in: 'login',
    sign_up: 'account',
    sign_out: 'seeyousoon'
  }
  root to: 'home#index'
end
