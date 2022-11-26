json.extract! folder, :id, :title, :folder_path, :parent_folder_id
json.user do
    json.email folder.user.email
    json.id folder.user.id
end

json.archives folder.archives do |a|
    json.title a.title
    json.files Rails.application.routes.url_helpers.rails_blob_url(a.file.attachment, only_path: true) rescue ""
end