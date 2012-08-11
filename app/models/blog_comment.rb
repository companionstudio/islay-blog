class BlogComment < ActiveRecord::Base
  belongs_to :entry, :class_name => 'BlogEntry'

  attr_accessible :name, :email, :body

  # Creates a scope that will only return comments that have been flagged as
  # as approved.
  #
  # @return ActiveRecord::Relation
  def self.approved
    where(:approved => true)
  end
end
