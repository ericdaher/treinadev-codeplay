class Admin::HomeController < AdminController
  def index
    @courses = Course.all
  end
end
