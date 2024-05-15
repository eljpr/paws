class UsersController < ApplicationController
  def index
    @users = User.all
    @vets = User.where(is_vet: true)
    @owners = User.where(is_vet: false)
    @patients = current_user.patients
    # we get dogs from our association through vet_dogs
  end

  def show
    @owner = User.find(params[:id])
  end
end
