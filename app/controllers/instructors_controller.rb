class InstructorsController < ApplicationController
  before_action :set_instructor, only: %i[show edit update destroy]

  def index
    @instructors = Instructor.all
  end

  def show
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      redirect_to @instructor
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @instructor.update(instructor_params)
      redirect_to @instructor, notice: 'Professor atualizado com sucesso'
    else
      render :new
    end
  end

  def destroy
    @instructor.destroy
    redirect_to instructors_path, notice: 'Professor excluído com sucesso'
  end

  private

  def instructor_params
    params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
  end

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end
end