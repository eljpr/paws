class LogsController < ApplicationController
  def index
    @logs = Log.all
  end

  def new
    @log = Log.new
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
    @log = Log.find(params[:id])
  end

  def edit
    @log = Log.find(params[:id])
  end

  def update
    @log = Log.find(params[:id])
    if @log.update(log_params)
      redirect_to dog_log_path(@log), notice: 'Log updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @log = Log.find(params[:id])
    @log.destroy
    redirect_to dog_logs_path, status: :see_other
  end

  private

  def log_params
    params.require(:logs).permit(:medication, :food, :special_treat, :grooming, :stool, :vaccination, :mood, :energy, :training)
  end

  def set_dog
    @dog = Dog.find_by(params[:id])
  end

end
