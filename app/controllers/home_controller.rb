class HomeController < ApplicationController
  def index
    @courses = Course.available
  end
end
