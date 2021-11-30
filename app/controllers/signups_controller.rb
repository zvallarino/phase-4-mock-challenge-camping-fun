class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :error_handle
rescue_from ActiveRecord::RecordInvalid, with: :invalid_handle

  def index 
    signups = Signup.all
    render json: signups
  end 

  def show
    signup = find_signup
    render json: signup
  end
  
  def create
    signup = Signup.create!(signup_params)
    render json: signup.activity, status: :created
  end 

  def update
    signup = find_signup
    signup.update(signup_params)
    render json: signup
  end 

  def destroy
    signup = find_signup
    signup.destroy
    head :no_content
  end 

  private

  def find_signup
    Signup.find(params[:id])
  end 

  def signup_params
    params.permit(:time, :activity_id, :camper_id) 
  end

  def error_handle
    render json: {error:"not found yo"}, status: :not_found
  end

  def invalid_handle(dog)
    render json: {errors: dog.record.errors.full_messages}, status: :unprocessable_entity
  end


end
