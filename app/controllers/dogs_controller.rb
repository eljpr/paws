class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  def index
    @dogs = current_user.dogs
  end

  def new
    @dog = Dog.new
  end

  def create
    @user = current_user
    @dog = Dog.new(dog_params)
    # @dog.walk = @walk
    @dog.user = @user
    @dog.save
    if @dog.save
      redirect_to dog_path(@dog)
    else
      render :new, status: :unprosseable_entity
    end
  end

  def show
    @pending = @dog.vet_dogs.where(status: "pending")
    @accepted = @dog.vet_dogs.where(status: "accepted")
  end

  def edit; end

  def update
    @dog.update(dog_params)
    redirect_to dog_path(@dog)
  end

  def destroy
    @dog.destroy
    redirect_to dogs_path
  end

  private

  def dog_params
    params.require(:dog).permit(:name, :medication, :condition, :breed, :date_of_birth, :weight, :photo)
  end

  def set_dog
    @dog = Dog.find(params[:id])
  end
end
