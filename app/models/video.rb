class Video < ActiveRecord::Base

	scope :completes,   where(:is_complete => true)
  scope :incompletes, where(:is_complete => false)

  def self.yt_session
    @yt_session ||= YouTubeIt::Client.new(:username => "cspltesting" , :password => "complitech", :dev_key => "AI39si43R-yMtRCFFx3K8zy0sNit0OQ3aDoWflkRAh9KruEgqLvTAOZM2AKxDHnCQOt821J_nzC72rdDO9wPj6YC4MtZKedxTg")    
  end

  def self.delete_video(video)
    yt_session.video_delete(video.yt_video_id)
    video.destroy
      rescue
        video.destroy
  end

  def self.update_video(video, params)
    yt_session.video_update(video.yt_video_id, video_options(params))
    video.update_attributes(params)
  end

  def self.token_form(params, nexturl)
    yt_session.upload_token(video_options(params), nexturl)
  end

  def self.delete_incomplete_videos
    self.incompletes.map{|r| r.destroy}
  end

  private
    def self.video_options(params)
      opts = {:title => params[:title],
             :description => params[:description],
             :category => "People",
             :keywords => ["test"]}
      params[:is_unpublished] == "1" ? opts.merge(:private => "true") : opts
    end
    
end
