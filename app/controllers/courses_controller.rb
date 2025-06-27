class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  # GET /courses
  def index
    @courses = Course.includes(:tutors).all
    render json: @courses.as_json(include: :tutors), status: :ok
  end

  # GET /courses/:id
  def show
    render json: @course.as_json(include: :tutors), status: :ok
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course.as_json(include: :tutors), status: :created
    else
      render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Course not found' }, status: :not_found
  end

  def course_params
    params.require(:course).permit(
      :name,
      :description,
      :duration_hours,
      tutors_attributes: %i[name email phone experience_years]
    )
  end
end
