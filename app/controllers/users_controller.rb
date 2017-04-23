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

      #UserNotifier.send_signup_email(@user).deliver
      #redirect_to view_report_path(participant_id: current_user.id)
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
    #redirect_to view_report_path(participant_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.report_requested = true
    params[:report_requested] = true

    if @user.update_attributes(user_params)
       redirect_to view_report_path(participant_id: @user.id)
    else
      render 'edit'
    end
  end

  def download_pdf
    @all_attempts = Survey::Attempt.where(participant_id: current_user.id)
    @proficient = Survey::Attempt.where(participant_id: current_user.id, numericGrade: [3 .. 5])
    @improve = Survey::Attempt.where(participant_id: current_user.id, numericGrade: [2.3 .. 2.9])
    @deltas = Survey::Attempt.where(participant_id: current_user.id, numericGrade: [1 .. 2])
    #@topConcerns = Survey::Question.find_by_sql ["select sq.text  FROM  survey_questions sq  join survey_answers sa on sa.question_id = sq.id  join survey_surveys s on sq.survey_id = s.id join survey_attempts sat on sa.attempt_id = sat.id where sa.option_id <=3 and sat.participant_id = 1;", {:participant_id=> current_user.id}];
    @total_score = @all_attempts.sum(:score)
    @numericGrade = (@total_score * (-1)).to_f/ 45
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
    if current_user.send_notification
        #UserNotifier.send_signup_email(@current_user).deliver
    end
    filename = 'SophityReport.pdf'
    respond_to do |format|
    format.html # show.html.erb
    format.pdf do
        pdf = SurveyPdf.new(current_user,@all_attempts,@proficient, @improve, @deltas,@numericGrade)
        send_data pdf.render, filename: filename, type: 'application/pdf'
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

   

end
