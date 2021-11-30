class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error_handle
rescue_from ActiveRecord::RecordInvalid, with: :invalid_handle


  def index 
    campers = Camper.all
    render json: campers
  end 

  def show
    camper = find_camper
    render json: camper, serializer: CamperActivitiesSerializer
  end

  def create
    camper = Camper.create!(camper_params)
    render json: camper, status: :created
  end 

  def update
    camper = find_camper
    camper.update(camper_params)
    render json: camper
  end 

  def destroy
    camper = find_camper
    camper.destroy
    head :no_content
  end 

  private

  def find_camper
    Camper.find(params[:id])
  end 

  def camper_params
    params.permit(:name, :age) 
  end

  def error_handle
    render json: {error:"Camper not found"}, status: :not_found
  end
  
  def invalid_handle(dog)
    render json: {errors: dog.record.errors.full_messages}, status: :unprocessable_entity
  end

end
