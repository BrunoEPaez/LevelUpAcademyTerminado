class Api::UsersController < ApplicationController
  # Esto permite que el registro sea accesible sin estar logueado
  skip_before_action :authenticate_user_from_token, only: [:create], raise: false
  
  # Esto permite que Rails responda en formato JSON
  respond_to :json

  def create
    # Creamos el usuario usando los parámetros permitidos abajo
    user = User.new(user_params)

    if user.save
      # Generamos el token de inmediato para que el frontend lo guarde
      # Usamos JwtService o JsonWebToken según lo que tengas en tu app
      token = JwtService.encode(user_id: user.id) rescue JsonWebToken.encode(user_id: user.id)
      
      render json: { 
        user: { id: user.id, email: user.email, name: user.name }, 
        token: token 
      }, status: :created
    else
      # Si hay error (ej: email repetido), devolvemos los mensajes de error
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    # Permitimos explícitamente los campos necesarios
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end