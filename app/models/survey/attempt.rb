class Survey::Attempt < ActiveRecord::Base

  self.table_name = "survey_attempts"

  acceptable_attributes :winner, :survey, :survey_id,
    :participant,
    :participant_id,
    :answers_attributes => ::Survey::Answer::AccessibleAttributes

  # relations
  belongs_to :survey
  belongs_to :participant, :polymorphic => true
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers,
    :reject_if => ->(q) { q[:question_id].blank? || q[:option_id].blank? }

  # validations
  validates :participant_id, :participant_type, :presence => true
  validate :check_number_of_attempts_by_survey

  #scopes
  scope :wins,   -> { where(:winner => true) }
  scope :looses, -> { where(:winner => false) }
  scope :scores, -> { order("score DESC") }
  scope :for_survey, ->(survey) { where(:survey_id => survey.id) }
  scope :exclude_survey,  ->(survey) { where("NOT survey_id = #{survey.id}") }
  scope :for_participant, ->(participant) {
    where(:participant_id => participant.try(:id), :participant_type => participant.class.base_class)
  }

  # callbacks
  before_create :collect_scores

  before_save :find_grade, :top_concerns

  def correct_answers
    return self.answers.where(:correct => true)
  end

  def incorrect_answers
    return self.answers.where(:correct => false)
  end

  def self.high_score
    return scores.first.score
  end

 def top_concerns
     top_concerns_list = Survey::Question.find_by_sql(["select sq.text FROM  survey_questions sq  join survey_answers sa on sa.question_id = sq.id 
            join survey_surveys s on sq.survey_id = s.id
             join survey_attempts sat on sa.attempt_id = sat.id
             where sa.option_id <=3 and sat.participant_id = ? and s.id= ?", self.participant_id, self.survey.id]).map(&:text)

     if self.grade.include? 'A'
       if top_concerns_list.empty?
        return ["N/A"]
       else 
        return [top_concerns_list.first]
       end 
    elsif self.grade.include? 'B'      
      return top_concerns_list.first(2)
    else
      return top_concerns_list.first(3)
    end
end

  private

  def check_number_of_attempts_by_survey
    attempts = self.class.for_survey(survey).for_participant(participant)
    upper_bound = self.survey.attempts_number

    if attempts.size >= upper_bound && upper_bound != 0
      errors.add(:survey_id, "Number of attempts exceeded")
    end
  end

  def collect_scores
    self.score = self.answers.map(&:value).reduce(:+) || 0
  end

  def find_grade
    numericScore = (self.answers.map(&:value).reduce(:+) || 0) * (-1)
    numericGrade = numericScore.to_f/self.survey.questions.count
    self.numericGrade = numericGrade
     if (numericGrade >= 4.7) 
        self.grade = "A+"
     elsif (numericGrade >= 4.4)
        self.grade = "A"
     elsif (numericGrade >= 4.1)
       self.grade = "A-"
     elsif (numericGrade >= 3.8)
       self.grade  = "B+"
     elsif (numericGrade>= 3.5)
       self.grade = "B"
    elsif (numericGrade >= 3.2)
       self.grade = "B-"
    elsif (numericGrade >= 2.9)
        self.grade = "C+"
     elsif (numericGrade >= 2.6)
       self.grade = "C"
     elsif (numericGrade >= 2.3)
       self.grade = "C-"
     elsif (numericGrade >= 2.0)
       self.grade = "D+"
     elsif (numericGrade >= 1.7)
       self.grade = "D"
     elsif (numericGrade >= 1.4)
       self.grade = "D-"
     else
       self.grade = "F"
    end
  end

 

 end 
  
