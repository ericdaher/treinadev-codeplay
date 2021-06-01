class HomeController < ApplicationController
  before_action :user_has_enrollment

  def index
    @courses = Course.available
  end

  private

  def user_has_enrollment
    return if current_user.nil?

    redirect_to mine_courses_path unless current_user.courses.empty?
  end
end
