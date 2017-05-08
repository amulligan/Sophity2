class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
      user = User.find_by(email: params[:email].downcase)
      if user
        log_in user
      else
        @user = User.new(email: params[:email].downcase)
        @user.save
        log_in user
       end
  end

def change_name
    @user = User.find_by(email: user_params[:email].downcase)
    @user.report_requested = false
    if @user
      @user.update_attributes(user_params)
      log_in @user
    else
      @user = User.new(email: user_params[:email].downcase)
      @user.save
      log_in @user
     end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.report_requested = true
    params[:report_requested] = true
    if current_user.send_notification
        attachment = generate_pdf
        UserNotifier.send_signup_email(@current_user, attachment).deliver_now
        UserNotifier.send_admin_report(@current_user, attachment).deliver_now
    end
    if @user.update_attributes(user_params)
       redirect_to view_report_path(participant_id: @user.id)
    else
      render 'edit'
    end
  end

  def download_pdf
    attachment = generate_pdf
    filename = "SophityHealthCheckReport– #{@current_user.company}.pdf"
    respond_to do |format|
    format.html # show.html.erb
    format.pdf do
        send_data(generate_pdf, :filename => filename, :type => "application/pdf")
      end
    end

  end


  private
   def user_params
    params.require(:user).permit(:name, :email,:company,:job_title,:phone,:send_notification, :report_requested)
   end

# Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

   def generate_pdf
    @all_attempts = Survey::Attempt.where(participant_id: current_user.id)
    @proficient = Survey::Attempt.where(participant_id: current_user.id, numericGrade: [3 .. 5])
    @improve = Survey::Attempt.where(participant_id: current_user.id, numericGrade: [2.3 ... 3])
    @deltas = Survey::Attempt.where(participant_id: current_user.id, numericGrade: [1 ... 2.3])
    @total_score = @all_attempts.sum(:score)
    @numericGrade = ((@total_score * (-1)).to_f/ 45).round(1)
    if (@numericGrade >= 4.7)
        @gradeLetter = "A+"
     elsif (@numericGrade >= 4.4)
        @gradeLetter = "A"
     elsif (@numericGrade >= 4.1)
       @gradeLetter = "A-"
     elsif (@numericGrade >= 3.8)
       @gradeLetter  = "B+"
     elsif (@numericGrade>= 3.5)
       @gradeLetter = "B"
    elsif (@numericGrade >= 3.2)
       @gradeLetter = "B-"
    elsif (@numericGrade >= 2.9)
        @gradeLetter = "C+"
     elsif (@numericGrade >= 2.6)
       @gradeLetter = "C"
     elsif (@numericGrade >= 2.3)
       @gradeLetter = "C-"
     elsif (@numericGrade >= 2.0)
       @gradeLetter = "D+"
     elsif (@numericGrade >= 1.7)
       @gradeLetter = "D"
     elsif (@numericGrade >= 1.4)
       @gradeLetter = "D-"
     else
       @gradeLetter = "F"
    end

    SurveyPdf.new(current_user,@all_attempts,@proficient, @improve, @deltas,@numericGrade) do |attachment|
    end.render




  end

end
