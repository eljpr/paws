class UsersController < ApplicationController
  def index
    @users = User.all
    @vets = User.where(is_vet: true)
    @owners = User.where(is_vet: false)
    @patients = current_user.patients
    # we get dogs from our association through vet_dogs
  end

  def show
    @user = User.find(params[:id])
    @vet_dog = VetDog.new
    @pending = @user.vet_dogs.where(status: "pending")
    @accepted = @user.vet_dogs.where(status: "accepted")
  end
end
