class LeasesController < ApplicationController

  def create
    lease = Lease.create!(rent: params[:rent])
    render json: lease
    rescue ActiveRecord::RecordInvalid => invalid
      render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

  def destroy
    lease = Lease.find(id: params[:id])
    if lease
      lease.delete
      head :no_content
    else
      render json: {error: "Lease could no be found"}
  end
end
