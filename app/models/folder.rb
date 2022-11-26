class Folder < ApplicationRecord
    belongs_to :parent_folder, class_name: "Folder", optional: true
    has_many :subfolders, class_name: "Folder", foreign_key: "parent_folder_id"
    has_many :archives

    validates :title, presence: true, uniqueness: {scope: [:parent_folder_id, :title]}
end
