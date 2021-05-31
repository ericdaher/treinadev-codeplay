class LessonsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :set_course, only: %i[show new create]
  before_action :user_has_enrollment, only: %i[show]

  def show
    @lesson = @course.lessons.find(params[:id])
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.new(lesson_params)
    if @lesson.save
      redirect_to @course, notice: 'Aula cadastrada com sucesso'
    else
      render :new
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def user_has_enrollment 
    redirect_to @course unless current_user.courses.include?(@course)
  end

  def lesson_params
    params.require(:lesson).permit(:name, :duration, :description)
  end
end