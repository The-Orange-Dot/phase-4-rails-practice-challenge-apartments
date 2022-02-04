class ApartmentsController < ApplicationController

  def index
    render json: Apartment.all, only: [:number]
  end

  def show
    apartment = find_apartment
    if apartment
      render json: apartment, only: [:number], include: [:leases => {only: :rent}]
    else
      render json: {errors: "Apartment could not be found"}, status: :not_found
    end
  end

  def destroy
    apartment = find_apartment
    if apartment
      apartment.delete
      head :no_content
    else
      render json: {errors: "Apartment could not be found"}, status: :not_found
    end
  end

  def update
    apartment = find_apartment
    if apartment
      apartment.update(apartment_params)
      render json: apartment
    else
      render json: {errors: "Apartment could not be found"}, status: :not_found
    end
  rescue ActiveRecord::RecordInvalid => invalid
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity 
  end
  
  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity 
  end

  private

  def find_apartment
    Apartment.find_by(id: params[:id])
  end

  def apartment_params
    params.permit(:number)
  end

end
