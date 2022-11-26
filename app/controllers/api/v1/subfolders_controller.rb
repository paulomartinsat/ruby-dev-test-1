class Api::V1::SubfoldersController < Api::V1::ApiController
    before_action :authenticate_user, only: [:create, :update, :destroy, :show, :index]
    before_action :set_folder
    before_action :set_subfolder, only: [:show, :update, :destroy]
    
    def create
        @subfolder = @folder.subfolders.new(folder_params.merge(user_id: current_user.id))
        if @subfolder.save!
            render 'show', status: :ok
        else
            render json: {error: 'missing required fields', status: :unprocessable_entity}
        end
    end

    def index
        @subfolders = @folder.subfolders.all.page(params[:page]).per(params[:size])
    end

    def show;end

    def update
        if @subfolder.update(folder_params)
            render 'show'
        else
            render json: @subfolder.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @subfolder.destroy
    end

    private

    def folder_params
        params.require(:folder).permit(:title, :folder_path, :parent_folder_id, :user_id)
    end

    def set_folder
        @folder = current_user.folders.find_by(id:params[:folder_id])
    end

    def set_subfolder
        @subfolder = @folder.subfolders.find_by(id:params[:id] ? params[:id]: params[:subfolder_id])
    end

end