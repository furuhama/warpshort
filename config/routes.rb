Rails.application.routes.draw do
  resource :root, only: %i[show], path: '/'
  resources :urls, only: %i[show create], param: :code, path: '/'
end
