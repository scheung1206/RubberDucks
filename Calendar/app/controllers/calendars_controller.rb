class CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = current_user.calendars.all #gets all of user's calendars
    if @calendars.empty?
      redirect_to new_calendar_path   #if user has no calendar, redirect to new calendar
    end
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
    @events = @calendar.events.all
    @events_by_date = @events.group_by(&:date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
    @calendar.user_id = current_user.id
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)
    @calendar.user_id = current_user.id
    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def freetime
    require "date"
    @calendar = Calendar.find(params[:calendar_id])
    @events = @calendar.events.all
    @events_by_date = @events.group_by(&:date)
    @startRange = params[:startRange]
    @endRange = params[:endRange]
    if !@startRange.nil? && !@endRange.nil?
      @loopdate = Date.parse(@startRange)
      @freetimelist = ""
      while (@loopdate <= Date.parse(@endRange))
        @begintime = Time.new(2000,1,1,12).to_s(:time)+ "AM"
        @freetimelist << @loopdate.to_s + ": "
          if @events_by_date[@loopdate]
              @events_by_date[@loopdate].each do |event|
              @freetimelist <<  @begintime.to_s + " - " + event.startTime.strftime("%I:%M%p").to_s
              @freetimelist <<  ", " + event.endTime.strftime("%I:%M%p").to_s + " - " + @begintime.to_s
              end
          else
              @freetimelist << "All Day!"
          end

        @freetimelist << "\n\n"
        @loopdate = @loopdate + 1.days
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:title)
    end

end
