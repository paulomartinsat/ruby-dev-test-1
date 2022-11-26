json.total_pages @users.total_pages
json.total_count @users.total_count
json.users do |u|
    u.array! @users, partial: "api/v1/users/user", as: :user do |user|
        json.extract! users
    end
end