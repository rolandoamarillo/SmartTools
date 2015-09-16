class VideosController < ApplicationController
  #before_action :set_video, only: [:show, :edit, :update, :destroy]

  before_filter :load_parent

  # GET /videos
  # GET /videos.json
  def index
    @videos = @contest.videos.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = @contest.videos.find(params[:id])
  end

  # GET /videos/new
  def new
    @video = @contest.videos.new
  end

  # GET /videos/1/edit
  def edit
    @video = @contest.videos.find(params[:id])
  end

  # POST /videos
  # POST /videos.json
  def create

    #@contest = Contest.find(params[:parent_id])

    @video =  @contest.videos.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to [@contest,@video] , notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @contest.videos.update(video_params)
        format.html { redirect_to [@contest,@video], notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = @contest.videos.find(params[:id])
    @video.destroy
    respond_to do |format|
      format.html { redirect_to [@contest,@video], notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:name, :lastname, :email, :message, :converted, :contest_id, :video)
    end
  def load_parent
    @contest = Contest.find(params[:contest_id])
  end
end
