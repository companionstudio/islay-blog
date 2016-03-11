class BlogEntry < ActiveRecord::Base
  include Islay::Publishable
  include Islay::Taggable
  include Islay::MetaData

  extend FriendlyId
  friendly_id :title, :use => :slugged

  include PgSearch
  multisearchable :against => [:title, :body, :metadata]

  belongs_to  :author,    :class_name => 'User'
  has_many    :comments, -> {order('created_at DESC')},  :class_name => 'BlogComment'
  has_many    :taggings,  :class_name => 'BlogTagging', :foreign_key => 'blog_entry_id'
  has_many    :tags,      :class_name => 'BlogTag', :through => :taggings

  has_many    :blog_assets
  has_many    :assets,    -> {order('position ASC')},  :through => :blog_assets
  has_many    :images,    -> {order('position ASC')},  :through => :blog_assets, :source => :asset, :class_name => 'ImageAsset'
  has_many    :audio,     -> {order('position ASC')},  :through => :blog_assets, :source => :asset, :class_name => 'AudioAsset'
  has_many    :videos,    -> {order('position ASC')},  :through => :blog_assets, :source => :asset, :class_name => 'VideoAsset'
  has_many    :documents, -> {order('position ASC')},  :through => :blog_assets, :source => :asset, :class_name => 'DocumentAsset'

  track_user_edits
  validates :tag_summary, :presence => true
  attr_accessible :title, :body, :published, :author_id, :asset_ids

  # Creates a scope which summarises entries for display in a public listing
  # i.e. truncated body, comment count etc.
  #
  # @return ActiveRecord::Relation
  def self.public_summary
    select(%{
      blog_entries.id, blog_entries.slug, blog_entries.published, blog_entries.published_at,
      blog_entries.title, blog_entries.updated_at, blog_entries.body,
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
      blog_entries.id, blog_entries.slug, blog_entries.published, blog_entries.title, blog_entries.created_at, blog_entries.updated_at,
      (SELECT name FROM users WHERE id = author_id) AS author_name,
      (SELECT name FROM users WHERE id = updater_id) AS updater_name,
      (SELECT COUNT(id) FROM blog_comments WHERE blog_entry_id = blog_entries.id) AS comments_count,
      (
        SELECT ARRAY_TO_STRING(ARRAY_AGG(bts.name), ', ')
        FROM blog_taggings
        JOIN blog_tags AS bts ON bts.id = blog_tag_id AND blog_entry_id = blog_entries.id
        GROUP BY blog_entry_id
      ) AS tags_summary
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

  def has_tag?(tag)
    !tags.select{|t|t.name.downcase == tag.downcase}.empty?
  end

  check_for_extensions
end
