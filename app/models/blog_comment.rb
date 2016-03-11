class BlogComment < ActiveRecord::Base
  include Humanizer
  require_human_on :create

  include PgSearch
  multisearchable :against => [:name, :email]

  belongs_to :entry, :class_name => 'BlogEntry'

  attr_accessible(
    :name, :email, :body, :blog_entry_id, :humanizer_answer,
    :humanizer_question_id
  )

  # Validate email format
  validates :email, :format   => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'Please check your email address is correct'}

  def self.summary
    select(%{
      blog_comments.*,
      (SELECT title FROM blog_entries WHERE id = blog_entry_id) AS blog_entry_title
    })
  end
end
