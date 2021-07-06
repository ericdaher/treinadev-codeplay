class CoursesController < ApplicationController
  before_action :set_course, only: %i[show enroll]

  def index
    @courses = Course.available
  end

  def show; end

  def enroll
    Enrollment.create(user: current_user, course: @course, price: @course.price)
    redirect_to mine_courses_path, notice: 'Curso comprado com sucesso'
  end

  def mine
    @enrollments = current_user.enrollments
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
