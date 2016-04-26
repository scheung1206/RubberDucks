class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @event = Event.find(params[:event_id])
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @calendar = Calendar.find(params[:calendar_id])
    @event = @calendar.events.find(params[:event_id])
    #@post = Post.find[params[:id]]
  end

  # GET /posts/new
  def new
    @calendar = Calendar.find(params[:calendar_id])
    @event = @calendar.events.find(params[:event_id])
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @calendar = Calendar.find(params[:calendar_id])
    @event = Event.find(params[:event_id])
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @calendar = Calendar.find(params[:calendar_id])
    @event = Event.find(params[:event_id])
    if @event.posts.create(post_params)
      redirect_to url_for([@calendar,@event]),
                  notice: 'Post successfully created.'
    else
    redirect_to calendar_event_path(:calendar,:event),
                alert: 'Error on creating post'
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @calendar = Calendar.find(params[:calendar_id])
    @event = Event.find(params[:event_id])
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to [@calendar,@event,@post], notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @calendar = Calendar.find(params[:calendar_id])
    @event = Event.find(params[:event_id])
    @post = @event.posts.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to [@calendar,@event], notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      #@event = Event.find(params[:event_id])#
    end

    def set_event
    @event = Event.find(params[:event_id])#
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content,:created_at, :image)
    end
end
