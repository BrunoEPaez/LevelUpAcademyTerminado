class Api::SessionsController < ApplicationController
  # ESTA LÍNEA VA AQUÍ AFUERA, NO ADENTRO DE 'CREATE'
  skip_before_action :authenticate_user_from_token, only: [:create], raise: false

  def create
    # Buscamos al usuario por email
    user = User.find_by(email: params[:user][:email])

    # Usamos valid_password? (Método de Devise)
    if user && user.valid_password?(params[:user][:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { 
        token: token, 
        user: { id: user.id, email: user.email, name: user.name } 
      }, status: :ok
    else
      render json: { error: 'Email o contraseña incorrectos' }, status: :unauthorized
    end
  end
end