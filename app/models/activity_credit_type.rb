class ActivityCreditType < ActiveRecord::Base
  validates_presence_of :name

  has_many :activities
end