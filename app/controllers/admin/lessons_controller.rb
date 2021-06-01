class Admin::LessonsController < ApplicationController
  before_action :set_course, only: %i[show new create]

  def show
    @lesson = @course.lessons.find(params[:id])
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.new(lesson_params)
    if @lesson.save
      redirect_to admin_course_path(@course), notice: 'Aula cadastrada com sucesso'
    else
      render :new
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :duration, :description)
  end
end