class Poll < ActiveRecord::Base
  attr_accessible :author_id, :title
  validates :author_id, :title, :presence => true

  belongs_to :author,
             :class_name => "User",
             :primary_key => :id,
             :foreign_key => :author_id

  has_many :questions,
           :class_name => "Question",
           :foreign_key => :poll_id

end
