class Question < ActiveRecord::Base
  attr_accessible :question, :poll_id
  validates :question, :poll_id, :presence => true

  belongs_to :poll,
             :class_name => "Poll",
             :foreign_key => :poll_id

  has_many :answer_choices,
           :class_name => "AnswerChoice",
           :foreign_key => :question_id

   def results
     results_hash = Hash.new(0)

     answer_choices = self.answer_choices.includes(:responses)
     answer_choices.each { |answer_choice| results_hash [answer_choice.choice]= answer_choice.responses.count}

     results_hash
   end
end
