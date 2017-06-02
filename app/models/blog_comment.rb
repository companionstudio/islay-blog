class BlogComment < ActiveRecord::Base
  include Humanizer
  require_human_on :create

  include PgSearch
  multisearchable :against => [:name, :email]

  belongs_to :entry, :class_name => 'BlogEntry'

  # Validate email format
  validates :email, :format   => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => 'Please check your email address is correct'}
  validations_from_schema
  
  def self.summary
    select(%{
      blog_comments.*,
      (SELECT title FROM blog_entries WHERE id = blog_entry_id) AS blog_entry_title
    })
  end

  def self.recent
    where('created_at > ?', 30.days.ago)
  end
end
