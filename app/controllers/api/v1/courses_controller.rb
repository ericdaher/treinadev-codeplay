class Api::V1::CoursesController < Api::V1::ApiController

  def index
    @courses = Course.all
    render json: @courses.as_json(except: [:id, :created_at], include: :instructor), status: 200
  end

  def show
    @course = Course.find_by!(code: params[:code])
    render json: @course
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :instructor_id, :banner, :code, :price, :enrollment_deadline)
  end
end