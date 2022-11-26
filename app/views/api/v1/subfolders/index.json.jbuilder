json.total_pages @subfolders.total_pages
json.total_count @subfolders.total_count
json.subfolders do |u|
    u.array! @subfolders, partial: "api/v1/subfolders/subfolder", as: :subfolder do |subfolder|
        json.extract! subfolders
    end
end