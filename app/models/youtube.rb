require 'google/apis/youtube_v3'

class Youtube
  @@service = nil
  def initialize
    @@service = Google::Apis::YoutubeV3::YouTubeService.new
    @@service.key = ENV["GOOGLE_API_KEY"]
  end

  def All
    return @@service.list_playlist_items(
      "contentDetails,snippet", 
      max_results:50, 
      playlist_id: "UUASYHw_S6bt_7bUhyWWu61Q").items
  end
end