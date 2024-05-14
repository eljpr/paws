class WalksController < ApplicationController
  def index
    @walks = Walk.all
    @markers = @walks.geocoded.map do |walk|
      {
        lat: walk.latitude,
        lng: walk.longitude
      }
    end
    if params[:query].present?
      sql_subquery = <<~SQL
        bikes.location @@ :query
    SQL
    @walks = @walks.where(sql_subquery, query: params[:query])
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
  @walk = Walk.new(walk_params)
  @walk.user = current_user
  if @walk.save
    redirect_to walk_path(@walk)
  else
    render :new, status: :unprosseable_entity
  end
end

def walk_params
  params.require(:walk).permit(:start_time, :end_time, :start_lat, :start_lng, :end_lat, :end_lng, :distance, :pace, :distance)
end




#reference of the table dont mind this

# create_table "walks", force: :cascade do |t|
#   t.time "start_time"
#   t.time "end_time"
#   t.float "pace"
#   t.decimal "start_lat"
#   t.decimal "start_lng"
#   t.decimal "end_lat"
#   t.decimal "end_lng"
#   t.float "distance"
#   t.bigint "dog_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["dog_id"], name: "index_walks_on_dog_id"
# end
