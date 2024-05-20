class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: %i[show edit update destroy]
  def index
    @prescriptions = Prescription.all
    @dog = Dog.find(params[:dog_id])
  end

  def new
    @prescription = Prescription.new
    @dog = Dog.find(params[:dog_id])
  end

  def create
    @prescription = Prescription.new(prescription_params)
    if @prescription.save
      redirect_to @prescription
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @prescription.update(prescription_params)
      redirect_to @prescription
    else
      render :edit
    end
  end

  def destroy
    @prescription.destroy
    redirect_to prescriptions_path, status: :see_other
  end

  private

  def prescription_params
    params.require(:prescription).permit(:medication_name, :completed, :start_date, :end_date, :description, :dosage, :time_of_day, :number_of_times_per_day, :dog_id, :user_id)
  end

  def set_prescription
    @prescription = Prescription.find(params[:id])
  end
end
