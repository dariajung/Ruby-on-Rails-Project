class EventsController < ApplicationController

  skip_before_filter :authenticate_admin, :only => [:index, :show, :rank, :suggest]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html
      format.json { render json: @events }
    end
  end

  def rank
    @event = Event.find(params[:id])

    if params[:item]
        params[:item].each_with_index do |id, index|
         ranking = Ranking.find(id)
         #if ranking.nil?
         ranking.position = index + 1
         ranking.save
       end
     end

    @rankings = @event.rankings(current_user)
  end

  def suggest
    @event = Event.find(params[:id])

    if params[:suggestions] and params[:suggestions][:cds]
      for id in params[:suggestions][:cds]
       unless id.blank?
       cd = Cd.find(id)
       @event.cds << cd unless @event.cds.include? cd
      end
    end
   end
  end
  
  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html #{ notice: 'An event was successfully created'} # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end