class Response < ActiveRecord::Base
  attr_accessible :user_id, :answer_id
  validates :user_id, :answer_id, :presence => true
  validate :respondent_has_not_already_answered_question

  belongs_to :answer_choice,
             :class_name => "AnswerChoice",
             :foreign_key => :answer_id

  belongs_to :respondent,
             :class_name => "User",
             :foreign_key => :user_id

  def respondent_has_not_already_answered_question
    if existing_responses(self.user_id, self.answer_id).length > 0
      errors[:respondent] << "Can only respond once to question"
    end
  end


  private
  def existing_responses(user_id, answer_id)
    sql = <<-SQL
      SELECT
        r.id
      FROM
        responses r JOIN answer_choices a ON r.answer_id = a.id
      WHERE
        r.user_id = ? AND a.question_id =
        (SELECT
          q.id
         FROM
          answer_choices a JOIN questions q ON a.question_id = q.id
         WHERE
          a.id = ?)

    SQL

    Response.find_by_sql([sql, user_id, answer_id])

  end
end