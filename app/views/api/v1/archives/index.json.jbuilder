json.total_pages @archives.total_pages
json.total_count @archives.total_count
json.archives do |u|
    u.array! @archives, partial: "api/v1/archives/archive", as: :archive do |archive|
        json.extract! archives
    end
end