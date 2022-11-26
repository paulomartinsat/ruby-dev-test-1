json.extract! user, :id, :email
json.folders user.folders do |f|
    json.title f.title
    json.path f.folder_path
    json.parent_folder_id f.parent_folder_id
end