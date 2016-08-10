Rails.application.routes.draw do

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

  # This is basically defining: get "/"
  root "welcome#index"
end
