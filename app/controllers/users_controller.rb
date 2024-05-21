class UsersController < ApplicationController
  def index
    @users = User.all
    @vets = User.where(is_vet: true)
    @owners = User.where(is_vet: false)
    @patients = current_user.patients.joins(:vet_dogs).where(vet_dogs: { status: "accepted" })
    # we get dogs from our association through vet_dogs
  end

  def show
    @user = User.find(params[:id])
    @vet_dog = VetDog.new
    @no_vet = current_user.dogs.left_joins(:vet_dogs).where(vet_dogs: { id: nil })
    @pending = current_user.vet_dogs.where(status: "pending")
    @accepted = current_user.vet_dogs.where(status: "accepted")
  end
end
