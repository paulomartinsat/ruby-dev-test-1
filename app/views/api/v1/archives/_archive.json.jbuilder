json.extract! archive, :id, :title
json.file Rails.application.routes.url_helpers.rails_blob_url(archive.file.attachment, only_path: true) rescue ""

json.folder do
    json.title archive.folder.title
    json.path archive.folder.folder_path
end