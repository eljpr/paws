class DogsController < ApplicationController
  def index
    @dogs = current_user.dogs
  end
  def new
    @dogs = Dog.new
  end
  def create
    @user = current_user
    @dog = Dog.new(dog_params)
    @dog.walk = @walk
    @dog.user = @user
    @dog.save
    if @dog.save
      redirect_to dog_path(@dog)
    else
      render :new, status: :unprosseable_entity
    end
  end
  private

  def dog_params
    params.require(:dogs).permit(:name, :medication, :condition, :breed, :date_of_birth, :weight)
  end
end
