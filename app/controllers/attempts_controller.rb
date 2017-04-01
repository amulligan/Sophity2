class AttemptsController < ApplicationController

  helper 'surveys'

  before_filter :load_survey, only: [:new, :create]

  def index
    @surveys = Survey::Survey.active
  end

  def show
    @attempt = Survey::Attempt.find_by(id: params[:id])
    if @attempt.survey.id !=6
      redirect_to new_attempt_path(survey_id: @attempt.survey.id+1)
    else
      #collect all survey attempts
      @all_attempts = Survey::Attempt.where(participant_id: 1)
      @total_score = @all_attempts.sum(:score)
     @numericGrade = (@total_score * (-1)).to_f/ 45
    if (@numericGrade >= 3.9) 
        @gradeLetter = "A+"
     elsif (@numericGrade >= 3.4) 
        @gradeLetter = "A"
     elsif (@numericGrade>= 3.0) 
       @gradeLetter = "A-"
     elsif (@numericGrade >= 3.9) 
       @gradeLetter  = "B+"
     elsif (@numericGrade>= 3.4) 
       @gradeLetter = "B"
    elsif (@numericGrade >= 3.0) 
       @gradeLetter = "B-"
    elsif (@numericGrade >= 2.9) 
        @gradeLetter = "C+"
     elsif (@numericGrade >= 2.4) 
       @gradeLetter = "C"
     elsif (@numericGrade >= 2.0) 
       @gradeLetter = "C-"
     elsif (@numericGrade>= 1.9) 
       @gradeLetter = "D+"
     elsif (@numericGrade >= 1.4) 
       @gradeLetter = "D"
     elsif (@numericGrade>= 1.0) 
       @gradeLetter = "D-"
     else
       @gradeLetter = "F"
    end
   respond_to do |format|
    format.html # show.html.erb
    format.pdf do
        pdf = SurveyPdf.new(@all_attempts,@numericGrade)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
    render :access_error if current_user.id != @attempt.participant_id
  end
  end

  def new
    @participant = current_user
    
    unless @survey.nil?
      @attempt = @survey.attempts.new
      @attempt.answers.build
    end
  end

  def create
    @attempt = @survey.attempts.new(params_whitelist)
    @attempt.participant = current_user
    @attempt.participant_id = current_user.id

    if @attempt.valid? && @attempt.save
      redirect_to attempt_path(@attempt.id)
    else
      build_flash(@attempt)   
      @participant = current_user
      render :new
    end
  end

  def delete_user_attempts
    Survey::Attempt.where(participant_id: params[:user_id], survey_id: params[:survey_id]).destroy_all
    redirect_to new_attempt_path(survey_id: params[:survey_id])
  end

  private

  def load_survey
    @survey = Survey::Survey.find_by(id: params[:survey_id])
  end

  def params_whitelist
    if params[:survey_attempt]
      params[:survey_attempt][:answers_attributes] = params[:survey_attempt][:answers_attributes].map { |attrs| { question_id: attrs.first, option_id: attrs.last } }
      params.require(:survey_attempt).permit(Survey::Attempt::AccessibleAttributes)
    end
  end

  def current_user
    view_context.current_user
  end
end
