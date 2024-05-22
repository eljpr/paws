class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  def index
    @logs = Log.where(dog_id: set_dog).order(created_at: :desc)
  end

  def new
    @log = Log.new
    @dog = set_dog
  end

  def create
    @log = Log.new(log_params)
    @log.dog = set_dog
    @builded_log = build_log(params["log"], @log)

    if @builded_log.save!
      redirect_to dog_logs_path(set_dog), notice: 'Log created successfully.'
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
    @builded_log = build_log(params["log"], @log)

    if @log.update(@builded_log.attributes)
      redirect_to dog_log_path(set_dog), notice: 'Log updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @log.destroy
    redirect_to dog_logs_path, status: :see_other
  end

  private

  def build_log(values, log)
    log.medication = values["medication"].drop(1)
    log.food = values["food"].drop(1)
    log.special_treat = values["special_treat"].drop(1)
    log.grooming = values["grooming"].drop(1)
    log.stool = values["stool"].drop(1)
    log.vaccination = values["vaccination"].drop(1)
    log.mood = values["mood"].drop(1)
    log.energy = values["energy"].drop(1)
    log.training = values["training"].drop(1)
    return log
  end

  def log_params
    params.require(:log).permit(medication:[], food:[], special_treat:[], grooming:[], stool:[], vaccination:[], mood:[], energy:[], training:[])
  end

  def set_log
    @log = Log.find(params[:id])
  end

  def set_dog
    @dog = Dog.find(params[:dog_id])
  end
end
