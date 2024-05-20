
  class VetDogsController < ApplicationController
    def create
      @vet_dog = VetDog.new(vet_dog_params)
      @user = User.find(params[:user_id])
      @vet_dog.user = @user
      if @vet_dog.save!
        redirect_to dog_path(@vet_dog.dog)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def accept
      @vet_dog = VetDog.find(params[:id]).update(status: "accepted")
      redirect_to users_path(current_user)
    end

    def destroy
      @vet_dog = VetDog.find(params[:id])
      @vet_dog.destroy
      redirect_to users_path(current_user)
    end

    private

    def vet_dog_params
      params.require(:vet_dog).permit(:dog_id)
    end
  end
