# app/controllers/api/courses_controller.rb
module Api
  class CoursesController < ApplicationController
    # Permitir ver cursos sin token
    skip_before_action :authenticate_user_from_token, only: [:index, :show], raise: false

    # GET /api/courses
    def index
      @courses = Course.all
      # Enviamos los datos necesarios para las Cards
      render json: @courses.as_json(
        only: [:id, :title, :description, :thumbnail_url, :instructor, :category, :job_type]
      )
    end

    # GET /api/courses/:id
    def show
      begin
        @course = Course.find(params[:id])
        # IMPORTANTE: Incluimos las lecciones para que aparezcan en el detalle del curso
        render json: @course.as_json(include: { 
          lessons: { 
            only: [:id, :title, :description, :youtube_id, :position] 
          } 
        })
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Curso no encontrado" }, status: :not_found
      end
    end
  end
end