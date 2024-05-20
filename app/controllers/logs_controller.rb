class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  def index
    @logs = Log.all
  end

  def new
    @log = Log.new
    @dog = set_dog
  end

  def create
    @log = Log.new(log_params)
    @log.dog = @dog

    if @log.save
      redirect_to dog_log_path(@log)
    else
      render :new, status: :unprosseable_entity
    end
  end

  def show
    set_dog
  end

  def edit
    set_dog
  end

  def update
    if @log.update(log_params)
      redirect_to dog_log_path(@log), notice: 'Log updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @log.destroy
    redirect_to dog_logs_path, status: :see_other
  end

  private

  def log_params
    params.require(:logs).permit(:medication, :food, :special_treat, :grooming, :stool, :vaccination, :mood, :energy, :training)
  end

  def set_log
    @log = Log.find(params[:id])
  end

  def set_dog
    @dog = Dog.find(params[:dog_id])
  end
end
