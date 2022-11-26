class Api::V1::UsersController < Api::V1::ApiController
	before_action :authenticate_user, only: [:show, :update, :destroy, :index]
	before_action :set_user, only: [:show, :update, :destroy, :edit]
	before_action :authorized, only: [:auto_login, :destroy]
	  
	def index
		@users = User.all.page(params[:page]).per(params[:size])
	end
	
	def destroy
    	@user.destroy
  	end

	def update
		if @user.update(user_params)
			render 'show'
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end
	
	def create
		@user = User.find_or_initialize_by(user_params)
		if (user_params[:encrypted_password].present? && user_params[:encrypted_password_confirmation].present?) && (user_params[:encrypted_password] == user_params[:encrypted_password_confirmation])
			if @user.save
				token = encode_token({user_id: @user.id})
				render 'show', status: :ok
			else
				render json: {error: "unauthorized"}, status: 400
			end
		else
			render json: {error: "Invalid username or password"}, status: 400
		end
	end
  
	def login
		@user = User.find_by(email: user_params[:email])
		if @user&.encrypted_password == user_params[:password] || @user&.valid_password?(user_params[:password])
			current_user = @user
			token = encode_token({user_id: @user&.id})
			render json: { token: token,
										user: @user&.as_api_response }, status: :ok
		else
			render json: { error: 'unauthorized' }, status: :unauthorized
		end
	end

  
	private 
		def set_user
			@user = User.find_by(id:params[:id] ? params[:id]: params[:user_id])
		end
		
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation, :encrypted_password, :encrypted_password_confirmation) 
		end
end