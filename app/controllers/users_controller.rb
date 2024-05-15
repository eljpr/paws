class UsersController < ApplicationController
  def index
    @users = User.all
    @vets = User.where(is_vet: true)
    @owners = User.where(is_vet: false)
  end

  def show
    @user = User.find(params[:id])
    @dogs = @user.dogs
  end
end
