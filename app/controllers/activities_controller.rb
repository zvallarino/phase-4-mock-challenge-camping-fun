class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :error_handle

  def index 
    activities = Activity.all
    render json: activities
  end 

  def show
    activity = find_activity
    render json: activity
  end
  
  def create
    activity = Activity.create(activity_params)
    render json: activity
  end 

  def update
    activity = find_activity
    activity.update(activity_params)
    render json: activity
  end 

  def destroy
    activity = find_activity
    activity.destroy
    head :no_content
  end 

  private

  def find_activity
    Activity.find(params[:id])
  end 

  def activity_params
    params.permit(:name, :difficulty) 
  end

  def error_handle
    render json: {error:"Activity not found"}, status: :not_found
  end

end
