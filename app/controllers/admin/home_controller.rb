class Admin::HomeController < Admin::AdminController
  def index
    @courses = Course.all
  end
end
