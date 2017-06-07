Rails.application.routes.draw do
  resources :tests, only: [:index] do
    get :cable, on: :collection
    get :cable_threads, on: :collection
    get :job, on: :collection
  end

  mount ActionCable.server => '/cable'
end
