class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      log_in user     
      Survey::Attempt.where(participant_id: current_user.id).destroy_all
     
    else     
      @user = User.new(email: params[:session][:email].downcase)
      @user.save
      log_in @user    
    
    end  
    redirect_to new_attempt_path(participant_id: current_user.id, survey_id:1)
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
