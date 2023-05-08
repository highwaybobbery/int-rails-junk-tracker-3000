class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy ]

  # GET /vehicles or /vehicles.json
  def index
    @vehicles = Vehicle.all
  end

  # GET /vehicles/1 or /vehicles/1.json
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles or /vehicles.json
  def create
    @vehicle = VehicleBuilder.new(vehicle_params: vehicle_create_params).create

    respond_to do |format|
      if @vehicle.valid?
        format.html { redirect_to root_path, notice: "Vehicle was successfully created." }
        format.json { render :show, status: :created, location: root_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1 or /vehicles/1.json
  def update
    VehicleBuilder.new(vehicle_params: vehicle_update_params).update(@vehicle)

    respond_to do |format|
      if @vehicle.valid?
        format.html { redirect_to root_path, notice: "Vehicle was successfully updated." }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1 or /vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: "Vehicle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def vehicle_create_params
      params.require(:vehicle).permit(
        :nickname, :type, :mileage,
        door_attributes: [:type],
        engine_attributes: [:status],
      )
    end

    def vehicle_update_params
      params.require(:vehicle).permit(
        :id, :nickname, :type, :mileage,
        door_attributes: [:id, :type],
        engine_attributes: [:id, :status],
      )
    end
end
