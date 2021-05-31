class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy enroll]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @instructors = Instructor.all
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      @instructors = Instructor.all
      render :new
    end
  end

  def edit
    @instructors = Instructor.all
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: t('.success')
    else
      @instructors = Instructor.all
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: t('.success')
  end

  def enroll
    Enrollment.create(user: current_user, course: @course, price: @course.price)
    redirect_to mine_courses_path, notice: 'Curso comprado com sucesso'
  end

  def mine
    @enrollments = current_user.enrollments
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :instructor_id, :banner, :code, :price, :enrollment_deadline)
  end

  def set_course
    @course = Course.find(params[:id])
  end
end