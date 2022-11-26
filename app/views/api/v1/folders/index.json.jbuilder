json.total_pages @folders.total_pages
json.total_count @folders.total_count
json.folders do |u|
    u.array! @folders, partial: "api/v1/folders/folder", as: :folder do |folder|
        json.extract! folders
    end
end