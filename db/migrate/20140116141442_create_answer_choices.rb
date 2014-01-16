class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.text :choice
      t.integer :question_id

      t.timestamps
    end
  end
end
