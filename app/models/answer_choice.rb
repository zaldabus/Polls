class AnswerChoice < ActiveRecord::Base
  attr_accessible :choice, :question_id
  validates :choice, :question_id, :presence => true

  belongs_to :question,
             :class_name => "Question",
             :foreign_key => :question_id

  has_many :responses,
           :class_name => "Response",
           :foreign_key => :answer_id
end
