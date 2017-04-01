class UsersController < ApplicationController
  def create
    session[:user_id] = User.create(user_params).id
    redirect_to new_attempt_path(survey_id: 1)
  end

  def change_name
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to new_attempt_path(survey_id: 1)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email,:company,:job_title,:phone,:send_notification)
  end
end