Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: redirect("/bread/index.html")

  scope(module: :admin, path: :admin, as: :admin) do

  	resources :index do 
  		collection do 
  			get :login
  		end
  	end
  	
  end
end
