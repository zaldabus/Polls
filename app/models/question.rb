class Question < ActiveRecord::Base
  attr_accessible :question, :poll_id

  belongs_to :poll,
             :class_name => "Poll",
             :foreign_key => :poll_id

  has_many :answer_choices,
           :class_name => "AnswerChoice",
           :foreign_key => :question_id
end
