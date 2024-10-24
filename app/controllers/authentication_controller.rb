class AuthenticationController < ApplicationController
  def login
    entity = Entity.authenticate(params[:name], params[:password])
    if entity
      token = entity.generate_token
      render json: { token: token }, status: :ok
    else
      render json: { error: "Invalid Credentials" }, status: :unauthorized
    end
  end
end
