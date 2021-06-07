class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def not_found
    head 404
  end

  def parameter_missing
    render status: :precondition_failed, json: { errors: 'paramêtros inválidos'}
  end
end