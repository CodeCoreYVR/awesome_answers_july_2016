class WelcomeController < ApplicationController
  # by default all actions will render with views/layouts/application.html.erb
  # unless you specify something like:
  # layout "special"
  # by convention the line above will use: views/layouts/special.html.erb

  # this defines a controller `action`
  def index

    # this will render `index.html.erb`
    # index: refers to the controller action
    # html: refers to the format (default is html)
    # erb: refers to the templating system (erb is built-in with Rails)
  end

  def about_me
  end
end
