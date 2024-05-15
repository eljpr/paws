class UsersController < ApplicationController
  def index
    @users = User.all
    @vets = User.where(is_vet: true)
    @owners = User.where(is_vet: false)
    # @owner = User.find(params[:id])
    @dog = Dog.find_by(params[:id])
    @owner = @dog.user
  end

  def show
    @user = User.find(params[:id])
  end
end
