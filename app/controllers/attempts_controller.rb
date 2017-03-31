class AttemptsController < ApplicationController

  helper 'surveys'

  before_filter :load_survey, only: [:new, :create]

  def index
    @surveys = Survey::Survey.active
  end

  def show
    @attempt = Survey::Attempt.find_by(id: params[:id])
    @total_score = @attempt.score * (-1)

    @grade = @total_score.to_f/@attempt.survey.questions.count

    if (@grade >= 3.9) 
      @gradeLetter = "A+"
   elsif (@grade >= 3.4) 
    @gradeLetter = "A"
   elsif (@grade>= 3.0) 
    @gradeLetter = "A-"
   elsif (@grade >= 3.9) 
    @gradeLetter = "B+"
   elsif (@grade>= 3.4) 
    @gradeLetter = "B"
  elsif (@grade >= 3.0) 
    @gradeLetter = "B-"
  elsif (@grade >= 2.9) 
    @gradeLetter = "C+"
   elsif (@grade >= 2.4) 
    @gradeLetter = "C"
   elsif (@grade >= 2.0) 
    @gradeLetter = "C-"
   elsif (@grade>= 1.9) 
    @gradeLetter = "D+"
   elsif (@grade >= 1.4) 
    @gradeLetter = "D"
   elsif (@grade >= 1.0) 
    @gradeLetter = "D-"
   else
    @gradeLetter = "F"
  end
  
    render :access_error if current_user.id != @attempt.participant_id
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

      correct_options_text = @survey.correct_options.present? ? 'Below are the correct answers marked in green' : ''
      redirect_to attempt_path(@attempt.id), notice: "Thank you for answering #{@survey.name}! #{correct_options_text}"
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
