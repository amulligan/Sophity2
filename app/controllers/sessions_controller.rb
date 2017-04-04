class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      log_in user     
      redirect_to view_report_path(participant_id: current_user.id)
    else     
      @user = User.new(email: params[:session][:email].downcase)
      @user.save
      log_in @user    
      redirect_to view_report_path(participant_id: current_user.id)
    end  
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
