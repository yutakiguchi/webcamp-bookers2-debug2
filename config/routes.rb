Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
     get 'follows' => 'relationships#follows', as: 'follows'
     get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books do
    resource :favorites,only:[:create,:destroy]
    resources :book_comments,only:[:create,:destroy]
  end
  
  resources :groups, only:[:new,:create,:edit,:update]
  post 'follow/:id' =>'relationships#follow',as: 'follow'
  post 'unfollow/:id' =>'relationships#unfollow',as: 'unfollow'

  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => "searchs#search"
  get 'chat/:id'=>'chats#show', as: 'chat'
  resources :chats,only:[:create]
end
