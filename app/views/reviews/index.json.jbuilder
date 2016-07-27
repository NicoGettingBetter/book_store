json.array!(@reviews) do |review|
  json.extract! review, :id, :text, :rating
  json.url review_url(review, format: :json)
end
