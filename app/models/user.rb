class User < ActiveRecord::Base
  validates :email, length: { maximum: 30 }, presence: true
  has_surveys
end