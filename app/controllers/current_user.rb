# require_relative '../serializers/user_serializer'

class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  # include UserSerialzier

  def index
    render json: UserSerializer.new(current_user).serializeable_hash[:data][:attributes], status: :ok
  end
end
