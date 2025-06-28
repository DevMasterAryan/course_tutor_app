class ApplicationController < ActionController::API
  before_action :authenticate_user!
  rescue_from StandardError, with: :handle_internal_error

  private

  def authenticate_user!
    token = extract_token_from_header
    payload = JwtService.decode(token)

    if payload && payload['user_id']
      @current_user = User.find(payload['user_id'])
    else
      render json: { error: 'Invalid or missing token' }, status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :unauthorized
  end

  attr_reader :current_user

  def extract_token_from_header
    request.headers['Authorization']&.split&.last
  end

  def handle_internal_error(exception)
    Rails.logger.error "Internal Server Error: #{exception.message}"
    Rails.logger.error exception.backtrace.join("\n")

    render json: { error: 'Internal Server Error' }, status: :internal_server_error
  end
end
