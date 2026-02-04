# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  # Esto obliga a todos los controladores a pedir token por defecto
  before_action :authenticate_user_from_token

  def authenticate_user_from_token
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    if token.blank?
      render json: { error: 'Token faltante' }, status: :unauthorized
      return # Detiene la ejecución aquí
    end

    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Usuario no encontrado' }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { error: 'Token inválido' }, status: :unauthorized
    rescue => e
      render json: { error: "Error de autenticación: #{e.message}" }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end