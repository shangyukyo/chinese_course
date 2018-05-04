Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect("/bread/index.html") 

  scope :admin, module: 'admin', as: 'admin' do 	  
    match :login, to: 'index#login', via: [:get , :post]    

    resources :lessons
    resources :payments
    resources :students
    resources :teachers
    resources :products

  end  

  resources :addresses
  resources :students
  resources :products

  match :sign_in, to: 'index#sign_in', via: [:get, :post]
end
