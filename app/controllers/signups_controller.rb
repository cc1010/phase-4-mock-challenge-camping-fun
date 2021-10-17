class SignupsController < ApplicationController
   rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

   def create
      signup = Signup.new(signup_params)
      if signup.save
         render json: signup.activity, status: :created
      else
         render json:{"errors": ["validation errors"]}, status: :unprocessable_entity
      end
   end

   private

   def signup_params
      params.permit(:time, :camper_id, :activity_id)
   end
   def render_not_found_response
      render json: { "error": "Signup not found" }, status: :not_found
   end
end
