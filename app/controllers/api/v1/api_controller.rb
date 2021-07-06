module Api
  module V1
    class ApiController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      private

      def not_found
        head :not_found
      end

      def parameter_missing
        render status: :precondition_failed, json: { errors: 'paramêtros inválidos' }
      end
    end
  end
end
