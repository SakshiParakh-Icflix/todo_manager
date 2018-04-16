Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	scope module: :v1, as: :v1, constraints: RouteConstraint.new(version: 1) do
		post 'sessions/sign_in' => 'sessions#create'
    delete 'sessions/sign_out' => 'sessions#destroy'
		resources :todos, except: [:show] do
			get 'list_tasks', on: :member
			resources :tasks
		end
	end
end
