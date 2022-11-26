json.extract! subfolder, :id, :title, :folder_path, :parent_folder_id

json.archives subfolder.archives do |a|
    json.title a.title
    json.files Rails.application.routes.url_helpers.rails_blob_url(a.file.attachment, only_path: true) rescue ""
end

json.parent_folder do
    json.title subfolder.parent_folder.title
    json.path subfolder.parent_folder.folder_path
end