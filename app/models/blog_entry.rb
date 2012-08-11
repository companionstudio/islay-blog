class BlogEntry < ActiveRecord::Base
  include Islay::Publishable
  include Islay::Taggable

  belongs_to  :author,    :class_name => 'User'
  has_many    :comments,  :class_name => 'BlogComment',   :order => 'created_at DESC'
  has_many    :taggings,  :class_name => 'BlogTagging', :foreign_key => 'blog_entry_id'
  has_many    :tags,      :class_name => 'BlogTag', :through => :taggings

  track_user_edits
  validations_from_schema
  attr_accessible :title, :body, :published, :author_id

  # Creates a scope which summarises entries for display in a public listing
  # i.e. truncated body, comment count etc.
  #
  # @return ActiveRecord::Relation
  def self.public_summary
    select(%{
      id, published, published_at, title, updated_at, body,
      (SELECT name FROM users WHERE id = author_id) AS author_name,
      (SELECT COUNT(id) FROM blog_comments WHERE blog_entry_id = blog_entries.id) AS comments_count
    })
  end

  # Creates a scope which will only return entries that are available for
  # viewing publically.
  #
  # @return ActiveRecord::Relation
  #
  # @todo Expand this to account for future publication dates.
  def self.active
    where("published = true")
  end

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