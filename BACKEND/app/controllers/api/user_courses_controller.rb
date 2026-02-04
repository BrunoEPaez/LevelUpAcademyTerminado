module Api
  class UserCoursesController < ApplicationController
    before_action :authenticate_user_from_token

    # Esto se ejecuta cuando das F5
    def index
      user_tracks = UserCourse.where(user: @current_user)
      render json: {
        completedCourseIds: user_tracks.where(completed: true).pluck(:course_id),
        favoriteIds: user_tracks.where(favorite: true).pluck(:course_id)
      }
    end

    # Esto se ejecuta cuando haces click en un botón
    def update
      # Buscamos o creamos el registro
      user_course = UserCourse.find_or_initialize_by(
        user: @current_user, 
        course_id: params[:course_id]
      )

      if params[:action_type] == 'favorite'
        user_course.favorite = !user_course.favorite
      else
        user_course.completed = true
      end

      if user_course.save
        render json: { status: 'success' }, status: :ok
      else
        render json: { error: user_course.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end