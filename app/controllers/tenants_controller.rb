class TenantsController < ApplicationController

  def index
    render json: Tenant.all
  end

  def show
    tenant = find_tenant
    if tenant
      render json: tenant
    else
      render json: {error: "Tenant not found"}, status: :not_found
    end
  end

  def update
    tenant = find_tenant
    if tenant
      tenant.update(tenant_params)
      render json: tenant
    else
      render json: {error: "Tenant not found"}, status: :not_found
    end
  rescue ActiveRecord::RecordInvalid => invalid
    render json: {errors: invalid.record.errors.full_messages}, status: :unprecessable_entity
  end

  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant
  rescue ActiveRecord::RecordInvalid => invalid
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end

  def destroy
    tenant = find_tenant
    if tenant
      tenant.delete
      head :no_content
    else
      render json: {error: "Tenant no found"}, status: :not_found
    end
  end

  private

  def find_tenant
    Tenant.find_by(id: params[:id])
  end

  def tenant_params
    params.permit(:name, :age)
  end

end
