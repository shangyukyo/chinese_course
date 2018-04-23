Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect("/bread/index.html") 

  scope :admin, module: 'admin' do 
	  scope shallow_path: 'index',  controller: 'index' do
	    get  :login
	    post :login

	    get :yijianxiang
	    get :zaixianzixun
	    get :vistor
	  end
  end  

  resources :yijianxiang
  resources :zaixianzixun
  resources :vistor
end
