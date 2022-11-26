class Api::V1::FoldersController < Api::V1::ApiController
    before_action :authenticate_user, only: [:create, :update, :destroy, :show, :index]
    before_action :set_folder, only: [:show, :update, :destroy]
    
    def create
        @folder = current_user.folders.new(folder_params)
        if @folder.save!
            render 'show', status: :ok
        else
            render json: {error: 'missing required fields', status: :unprocessable_entity}
        end
    end

    def index
        @folders = current_user.folders.all.page(params[:page]).per(params[:size])
    end

    def show;end

    def update
        if @folder.update(folder_params)
            render 'show'
        else
            render json: @folder.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @folder.destroy
    end

    private

    def folder_params
        params.require(:folder).permit(:title, :folder_path, :parent_folder_id, :user_id)
    end

    def set_folder
        @folder = @current_user.folders.find_by(id:params[:id] ? params[:id]: params[:folder_id])
    end

end