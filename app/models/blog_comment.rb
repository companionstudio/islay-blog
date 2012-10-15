class BlogComment < ActiveRecord::Base
  include Islay::Searchable
  search_terms :against => {:name => 'A'}

  include Humanizer
  require_human_on :create

  belongs_to :entry, :class_name => 'BlogEntry'

  attr_accessible(
    :name, :email, :body, :blog_entry_id, :humanizer_answer,
    :humanizer_question_id
  )

  validations_from_schema

  # Validate email format
  validates :email, :format   => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'Please check your email address is correct'}

  def self.summary
    select(%{
      blog_comments.*,
      (SELECT title FROM blog_entries WHERE id = blog_entry_id) AS blog_entry_title
    })
  end
end
