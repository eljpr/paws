class PrescriptionsController < ApplicationController
  before_action :set_dog, only: %i[index new create show edit update]
  before_action :set_prescription, only: %i[show edit update destroy]
  def index
    @prescriptions = Prescription.where(dog_id: set_dog).order(created_at: :desc)
  end

  def new
    @prescription = Prescription.new
    @dog = Dog.find(params[:dog_id])
  end

  def create
    @prescription = Prescription.new(prescription_params)
    @dog = Dog.find(params[:dog_id])
    @user = current_user
    @prescription.dog = @dog
    @prescription.user = @user
    @prescription.save
    if @prescription.save
      redirect_to dog_prescription_path(@dog, @prescription)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    @dog = Dog.find(params[:dog_id])
    @prescription.update(prescription_params)
    redirect_to dog_prescription_path(@dog, @prescription)
  end

  def complete
    @prescription = Prescription.find(params[:id])
    @prescription.update(completed: true)
    redirect_to dog_prescription_path(@prescription.dog, @prescription)
  end

  def destroy
    # @prescription.dog = @dog
    if @prescription.destroy
      redirect_to dog_prescriptions_path(@prescription.dog), status: :see_other
    end
  end

  private

  def prescription_params
    params.require(:prescription).permit(:medication_name, :completed, :start_date, :end_date, :description, :dosage, :time_of_day, :number_of_times_per_day, :dog_id, :user_id)
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end

  def set_dog
    @dog = Dog.find(params[:dog_id])
  end
end
