json.array!(@videos) do |video|
  json.extract! video, :title, :description, :yt_video_id, :is_complete
  json.url video_url(video, format: :json)
end
