class Admin::VideosController < ApplicationController

  before_action :set_video, only: %i[ show edit update destroy submit_for_review approve reject ]

  # GET /videos or /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1 or /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
    @video.build_content
  end

  # GET /videos/1/edit
  def edit
    @video.build_content if @video.content.nil?
  end

  # POST /videos or /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to [:admin, @video], notice: "Video was successfully created." }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to [:admin, @video], notice: "Video was successfully updated." }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    @video.destroy!

    respond_to do |format|
      format.html { redirect_to admin_videos_path, status: :see_other, notice: "Video was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /videos/:id/submit_for_review
  def submit_for_review
      if @video.content.draft?
          @video.content.submit_for_review!
          ContentMailer.with(content: @video.content).notify_content_submitted.deliver_now
          redirect_to admin_videos_path, notice: "Video submitted for review."
      else
          redirect_to admin_videos_path, alert: "Video cannot be submitted for review."
      end
  end

  # POST /videos/:id/approve
  def approve
      if @video.content.in_review?
          @video.content.approve!
          redirect_to admin_videos_path, notice: "Video approved."
      else
          redirect_to admin_videos_path, alert: "Video cannot be approved."
      end
  end

  # POST /videos/:id/reject
  def reject
      if @video.content.in_review?
          @video.content.reject!
          ContentMailer.with(content: @video.content).notify_content_submitted.deliver_now
          redirect_to admin_videos_path, notice: "Video rejected."
      else
          redirect_to admin_videos_path, alert: "Article cannot be rejected."
      end
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:video_url, :cover, content_attributes: [:title, :description])
    end    
end
