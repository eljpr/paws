class MarkersController < ApplicationController
  def create
    @marker = Marker.new(marker_params)
    if @marker.save
      render json: { id: @marker.id }, status: :created
    else
      render json: @markers.errors, status: :unprosseable_entity
    end
  end

  private
  def marker_params
    params.require(:marker).permit(:lng, :lat)
  end
end
