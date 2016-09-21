class ReactHomeController < ApplicationController
  def index
    render component: 'App'
  end
end
