class BlogEntry < ActiveRecord::Base
  include Islay::Publishable

  belongs_to  :author,    :class_name => 'User'
  has_many    :comments,  :class_name => 'BlogComment', :order => 'create_at DESC'

  track_user_edits
  validations_from_schema
  attr_accessible :title, :body, :published, :author_id

  # Creates a scope with extra calculated fields for comment count, author name
  # etc.
  #
  # @return ActiveRecord::Relation
  def self.summary
    select(%{
      id, published, title, updated_at,
      (SELECT name FROM users WHERE id = author_id) AS author_name,
      (SELECT name FROM users WHERE id = updater_id) AS updater_name,
      (SELECT COUNT(id) FROM blog_comments WHERE blog_entry_id = blog_entries.id) AS comments_count
    })
  end

  # Creates a scope which filters the results based on the argument.
  #
  # @param String f
  #
  # @return ActiveRecord::Relation
  def self.filter(f)
    case f
    when 'published'    then where(:published => true)
    when 'unpublished'  then where(:published => false)
    else scoped
    end
  end

  # Creates a scope which orders the results based on the argument.
  #
  # @param String s
  #
  # @return ActiveRecord::Relation
  def self.sorted(s)
    if s
      order(s)
    else
      order('published_at DESC')
    end
  end
end
