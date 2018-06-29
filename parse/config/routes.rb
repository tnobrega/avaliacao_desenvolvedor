Rails.application.routes.draw do
  resources :lines
  resources :attachments do
    get 'line_list',  to: 'attachments#line_list'
  end
  root to: 'lines#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
