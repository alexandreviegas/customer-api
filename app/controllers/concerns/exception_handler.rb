module ExceptionHandler
  extend ActiveSupport::Concern
  included do
    #When the resource is not found on database
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { error: e.message }, status: :not_found
    end
    #When the resource is invalid
    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
end
