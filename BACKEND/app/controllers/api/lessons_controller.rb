module Api
  class LessonsController < ApplicationController
    # Permitimos ver lecciones sin token si es necesario
    skip_before_action :authenticate_user_from_token, only: [:index, :show], raise: false
    before_action :set_lesson, only: [:show, :update, :destroy]

    # GET /api/lessons o /api/courses/:course_id/lessons
    def index
      if params[:course_id]
        @lessons = Lesson.where(course_id: params[:course_id]).order(:id)
      else
        @lessons = Lesson.all
      end
      render json: @lessons
    end

    # GET /api/lessons/:id
    def show
      render json: @lesson
    end

    # POST /api/lessons
    def create
      @lesson = Lesson.new(lesson_params)
      if @lesson.save
        render json: @lesson, status: :created
      else
        render json: @lesson.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/lessons/:id
    def update
      if @lesson.update(lesson_params)
        render json: @lesson
      else
        render json: @lesson.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/lessons/:id
    def destroy
      @lesson.destroy!
      head :no_content
    end

    private

    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def lesson_params
      # Asegúrate de incluir youtube_id que es lo que usa tu React
      params.require(:lesson).permit(:title, :description, :course_id, :youtube_id, :position)
    end
  end
end