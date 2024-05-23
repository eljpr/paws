class WalksController < ApplicationController
  def index
    @walks = Walk.all
    @walk = Walk.last
    @markers = @walks.map do |walk|
      {
        start_lng: walk.start_lng,
        start_lat: walk.start_lat,
        end_lng: walk.end_lng,
        end_lat: walk.end_lat
      }
    end
    if params[:query].present?
      sql_subquery = <<~SQL
        walks.location @@ :query
    SQL
    @walks = @walks.where(sql_subquery, query: params[:query])
    @mapbox_api_key = ENV['MAPBOX_API_KEY']
    end
  end
  def new
    @walk = Walk.new
  end
  def show
    @walk = Walk.find(params[:id])
  end
def create
  puts params.inspect
  @walk = Walk.new
  @walk.dog = current_user.dogs.first
  puts current_user.dogs.first
  @walk.start_time ||=  Time.current # if @walk.start_time.nil?  #set start time
  @walk.end_time  ||=  Time.current #if @walk.end_time.nil?

  @walk.user = current_user

  @walk.path = params["path"]
  @walk.set_coords_calc_dist_pace
 respond_to do |format|
  if @walk.save!
    format.html { redirect_to @walk, notice: "Walk was succesfully created."  }
    format.json { render json: { status: :ok, message: "Success!", id: @walk.id }}
  else
    format.html {render :new, status: :unprocessable_entity}
    format.json { render json: {status: :unprocessable_entity} }
  end
 end
end

def walk_params
  params.require(:walk).permit(:start_time, :end_time, :start_lat, :start_lng, :end_lat, :end_lng, :distance, :pace, :distance, path: [])
end
end
