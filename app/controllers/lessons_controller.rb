class LessonsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :set_course, only: %i[show new create]
  before_action :user_has_enrollment, only: %i[show]

  def show
    @lesson = @course.lessons.find(params[:id])
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def user_has_enrollment 
    redirect_to @course unless current_user.courses.include?(@course)
  end
end