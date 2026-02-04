class Api::ProfilesController < ApplicationController
  # CAMBIO: Usa el nombre exacto del método que tengas en ApplicationController
  # Si en ApplicationController se llama "authenticate_user_from_token", pon ese.
  before_action :authenticate_user_from_token

  def show
    render json: @current_user
  end

  def update
    if @current_user.update(user_params)
      render json: @current_user
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
  params.require(:user).permit(:name, :birthdate, :city, :phone, :address, :bio, :linkedin_url, :github_url, :portfolio_url, :avatar_base64)
end
def destroy
  if @current_user.destroy
    render json: { message: "Cuenta eliminada correctamente" }, status: :ok
  else
    render json: { error: "No se pudo eliminar la cuenta" }, status: :unprocessable_entity
  end
end
end