class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :email, format: {with: /\A[^@]+@[^@]+\z/}

    has_many :archives, class_name: "Archive"
    has_many :folders, class_name: "Folder"
    
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :trackable, :jwt_authenticatable, jwt_revocation_strategy: JwtDenyList

    def as_api_response
        as_json(only: [:id, :email])
    end

    def password_required?
        return false
        super
    end
end