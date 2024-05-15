class VetDogsController < ApplicationController
  def create
    @vet_dog = VetDog.new(vet_dog_params)
    @user = current_user
    @dog = Dog.find(params[:dog_id])
    if @vet_dog.save
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def vet_dog_params
    params.require(:vet_dog).permit(:user_id, :dog_id)
  end
end
