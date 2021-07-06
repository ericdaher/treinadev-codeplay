module Admin
  class HomeController < Admin::AdminController
    def index
      @courses = Course.all
    end
  end
end
