class Archive < ApplicationRecord
    belongs_to :folder
    has_one_attached :file

    validates :title, presence: true, uniqueness: {scope: [:folder_id, :title]}
    validates :file, presence: true
end
