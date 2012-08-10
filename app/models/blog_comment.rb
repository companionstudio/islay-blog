class BlogComment < ActiveRecord::Base
  belongs_to :entry, :class_name => 'BlogEntry'

  attr_accessible :name, :email, :body
end
