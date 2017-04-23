class Survey::Option < ActiveRecord::Base

  self.table_name = "survey_options"

  acceptable_attributes :text, :correct, :weight, :concern

  #relations
  belongs_to :question

  # validations
  validates :text, :presence => true, :allow_blank => false

  # scopes
  scope :correct,   -> { where(:correct => true)  }
  scope :incorrect, -> { where(:correct => false) }
  scope :is_concern, -> { where(:concern => true) }

  # callbacks
  before_create :default_option_weight

  def to_s
    return self.text
  end

  def correct?
    return (self.correct == true)
  end

  def concern?
    return (self.concern == true)
  end

  private

  def default_option_weight
    self.weight = 1 if correct? && self.weight == 0
  end

  def text_to_print
    "<p>" "#{text}" "</p>".html_safe
  end
end
