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
  resources :products do
    collection do 
      post :upload_photo
      post :pay

      get :success
    end

    member do 
      get :confirm
    end    
  end

  resources :payments do 
    collection do 
      post :notify
    end
  end

  resources :payments

  match :sign_in, to: 'index#sign_in', via: [:get, :post]
end
