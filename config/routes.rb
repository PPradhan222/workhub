Rails.application.routes.draw do
  get 'tasks/show'
  get 'tasks/create'
  get 'tasks/index'
  get 'task/show'
  get 'task/create'
  get 'task/index'
  get 'task/delete'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'registrations' }

  mount ActionCable.server => '/cable'
  
  resources :users do
    resources :member_ships
    resources :user_tasks
  end

  resources :groups do
    resources :member_ships
    member do
      get 'info'
    end
  end

  resources :tasks do
    resources :user_tasks
    member do
        patch :assigned
        patch :in_progress
        patch :backlog
        patch :done
      end
  end

  resources :invitations do
    member do 
      get 'accept'
    end
  end

  resources :messages
  
  resources :posts do
    scope module: 'post' do
      resources :likes, only: [:create, :destroy]
    end
  end

  resources :comments do
    scope module: 'comment' do
      resources :likes, only: [:create, :destroy]
    end 
  end

  resources :member_ships, only: [:destroy, :update]
 
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: :show
end
