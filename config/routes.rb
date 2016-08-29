Rails.application.routes.draw do

  resources :users, only: [:new, :create]

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  # delete "/sessions" => "sessions#destroy"
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  # this defines a route that when we receive a `GET` request with URL `/home`
  # it will invoke the `welcome_controller` with `index` action
  # get({"/home" => "welcome#index"})
  # this is calle DSL: Domain Specific Language. It's just Ruby written in a
  # special way for a special purpose (in this case for defining Routes)
  get "/home" => "welcome#index"

  # we can use `as:` option to set a path/url helper
  get "/about" => "welcome#about_me", as: :about_us

  get "/contact" => "contact#new", as: :new_contact
  post "/contact" => "contact#create", as: :contact

  resources :questions do
    # # collection is used when we don't need to specify a particular question but we expect a collection of question. Examples: index / create
    # post :search, on: :collection
    #
    # # member is used when we need to identify a particular question. Examples are: show / edit / update / destroy
    # post :search, on: :member
    #
    # # This is when we want to have nested routes for our resources. Example: answers for questions.
    # post :search

    resources :answers, only: [:create, :destroy]

    resources :likes, only: [:create, :destroy]

    resources :votes, only: [:create, :update, :destroy]
  end


  # get "/questions/new" => "questions#new",    as: :new_question
  # post "/questions"    => "questions#create", as: :questions
  # get "/questions/:id" => "questions#show",   as: :question
  # get "/questions"     => "questions#index"
  # get "/questions/:id/edit" => "questions#edit", as: :edit_question
  # patch "/questions/:id" => "questions#update"
  # delete "/questions/:id" => "questions#destroy"

  # This is basically defining: get "/"
  root "welcome#index"
end
