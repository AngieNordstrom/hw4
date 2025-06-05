class EntriesController < ApplicationController
  def index
    @entries = Entry.where({ "user_id" => session["user_id"] })
  end

  def show
    @entry = Entry.find_by({ "id" => params["id"] })

    if @entry.user_id != session["user_id"]
      flash[:alert] = "Access denied!"
      redirect_to "/entries"
    end
  end

  def new
    @entry = Entry.new
    @places = Place.all
  end

  def create
    @entry = Entry.new
    @entry.title = params[:entry][:title]
    @entry.description = params[:entry][:description]
    @entry.occurred_on = params[:entry][:occurred_on]
    @entry.place_id = params[:entry][:place_id]
    @entry.user_id = session["user_id"]

    if params[:entry][:image]
      @entry.image.attach(params[:entry][:image])
    end

    if @entry.save
      redirect_to "/places/#{@entry.place_id}", notice: "Entry created!"
    else
      render :new, alert: "Something went wrong."
    end
  end
end



