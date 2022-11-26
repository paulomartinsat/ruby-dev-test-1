class Api::V1::ArchivesController < Api::V1::ApiController
    before_action :authenticate_user, only: [:create, :update, :destroy, :show, :index]
    before_action :set_folder
    before_action :set_archive, only: [:show, :update, :destroy, :create]
    
    def create
        @archive = @folder.archives.new(archive_params.merge(user_id: current_user.id))
        if @archive.save!
            render 'show', status: :ok
        else
            render json: {error: 'missing required fields', status: :unprocessable_entity}
        end
    end

    def index
        @archives = @folder.archives.all.page(params[:page]).per(params[:size])
    end

    def show;end

    def update
        if @archive.update(archive_params)
            render 'show'
        else
            render json: @archive.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @archive.destroy
    end

    private

    def archive_params
        params.require(:archive).permit(:title, :file, :user_id, :folder_id)
    end

    def set_folder
        @folder = current_user.folders.find_by(id: params[:folder_id])
    end

    def set_archive
        @archive = @folder.archives.find_by(id:params[:id] ? params[:id]: params[:archive_id])
    end

end