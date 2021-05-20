class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Curso atualizado com sucesso'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: 'Curso excluído com sucesso'
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :banner, :code, :price, :enrollment_deadline)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end