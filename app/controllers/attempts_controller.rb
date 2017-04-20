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
      redirect_to view_report_path
    end
  end

  def view_report
    @all_attempts = Survey::Attempt.where(participant_id: current_user.id)
    if @all_attempts.empty?
      redirect_to new_attempt_path(survey_id: 1)
    else
      @total_score = @all_attempts.sum(:score)
      # @numericGrade = (@total_score * (-1)).to_f/ 45
      # @numericGrade = (@total_score * (-1)).to_f/ 45
      # @gradeLetter = (@total_score).to_s + "/45 = " + (@numericGrade).to_s + ": "
    if (@numericGrade >= 4.7)
        @gradeLetter = "A+"
     elsif (@numericGrade >= 4.4 && @numericGrade <= 4.6)
        @gradeLetter = "A"
     elsif (@numericGrade >= 4.1 && @numericGrade <= 4.3)
       @gradeLetter = "A-"
     elsif (@numericGrade >= 3.8 && @numericGrade <= 4.0)
       @gradeLetter  = "B+"
     elsif (@numericGrade>= 3.5 && @numericGrade <= 3.7)
       @gradeLetter = "B"
    elsif (@numericGrade >= 3.2 && @numericGrade <= 3.4)
       @gradeLetter = "B-"
    elsif (@numericGrade >= 2.9 && @numericGrade <= 3.1)
        @gradeLetter = "C+"
     elsif (@numericGrade >= 2.6 && @numericGrade <= 2.8)
       @gradeLetter = "C"
     elsif (@numericGrade >= 2.3 && @numericGrade <= 2.5)
       @gradeLetter = "C-"
     elsif (@numericGrade >= 2.0 && @numericGrade <= 2.2)
       @gradeLetter = "D+"
     elsif (@numericGrade >= 1.7 && @numericGrade <= 1.9)
       @gradeLetter = "D"
     elsif (@numericGrade >= 1.4 && @numericGrade <= 1.6)
       @gradeLetter = "D-"
     elsif (@numericGrade <= 1.3)
       @gradeLetter = "F"
    end
      @participant = current_user
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
