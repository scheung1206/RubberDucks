class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @calendar = Calendar.find(params[:calendar_id])
  end

  # GET /events/1
  # GET /events/1.json
  def show
      @calendar = Calendar.find(params[:calendar_id])
      @events = Event.find(params[:id])
      @post = Post.new
  end

  # GET /events/new
  def new
    @calendar = Calendar.find(params[:calendar_id])
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @calendar = Calendar.find(params[:calendar_id])
    @events = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @calendar = Calendar.find(params[:calendar_id])
    @events = @calendar.events.all
    puts @events
    @events_by_date = @events.group_by(&:date)
    puts
    puts @events_by_date
    @d = params[:event][:date]
    @t = params[:event][:title]
    puts @t
    @newStart = (params[:event]["startTime(4i)"].to_s + ":" + params[:event]["startTime(5i)"].to_s).to_time.strftime("%I:%M%p")
    @newEnd = (params[:event]["endTime(4i)"].to_s + ":" + params[:event]["endTime(5i)"].to_s).to_time.strftime("%I:%M%p")
    #@newStart = convertTime(params[:event]["startTime(4i)"].to_i , params[:event]["startTime(5i)"].to_i)
    #@newEnd = params[:event]["endTime(4i)"].to_s + ":" + params[:event]["endTime(5i)"].to_s
    puts @d.to_s + " | " + @newStart + " | " + @newEnd
    if !@d.nil?
      @date = Date.parse(@d)
      if @events_by_date[@date]
        @break = false
        @events_by_date[@date].each do |event|

          if event.startTime.strftime("%I:%M%p") <= @newEnd && event.endTime.strftime("%I:%M%p") >= @newStart
            @break = true
          end
        end
        if @break
          redirect_to new_calendar_event_path(@calendar),
                      alert: 'Error on creating post'
                      return
        end
      end
    end

    #@event = Event.new(event_params)
    if @calendar.events.create(event_params)
          redirect_to @calendar,
                      notice: 'Post successfully created.'
    end
  end

  def convertTime(hour, min)
    if hour > "12"
      hour = hour - "12"
    end
    return @time
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @calendar = Calendar.find(params[:calendar_id])
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to [@calendar,@event], notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @calendar = Calendar.find(params[:calendar_id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to @calendar, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :date, :startTime, :endTime)
    end
end
