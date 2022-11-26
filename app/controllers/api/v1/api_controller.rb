class Api::V1::ApiController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :set_default_format
    before_action :authorized
  
    def authenticate_customer!
      return if current_user
  
      render json: { message: 'Error - no access' }, status: :unauthorized
    end
  
    def encode_token(payload)
      JWT.encode(payload, 's3cr3t')
      JsonWebToken.encode(payload)
    end
  
    def auth_header
      request.headers['Authorization']
    end
  
    def decoded_token
      if auth_header
        token = auth_header.split(' ')[1]
        begin
          # JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
          JsonWebToken.decode(token)
        rescue JWT::DecodeError
          nil
        end
      end
    end
  
    def current_user
      @current_user
    end
  
    def current_customer
      current_user
    end
    
    def logged_in_user
      if decoded_token
        user_id = decoded_token['user_id']
        @user = User.find_by(id: user_id)
        @current_user = @user
      end
    end
  
    def logged_in?
      !!logged_in_user
    end
  
    def authorized
      render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
  
    def not_found
      render json: { error: 'not_found' }
    end
  
    def authorize_request
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
  
    def authenticate_user
      if request.headers['Authorization'].present?
        # binding.pry
        authenticate_or_request_with_http_token do |token|
          begin
            jwt_payload = JWT.decode(token, Rails.application.secret_key_base).first
  
            @current_user_id = jwt_payload['user_id']
          rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
            head :unauthorized
          end
        end
      end
    end
   
    private

    def set_user
      render json: 401 unless current_user
    end
    
    def set_default_format
      request.format = :json
    end
  end