class BlogTag < Tag
  has_many :taggings, :class_name => 'BlogTagging'
  has_many :entries,  :class_name => 'BlogEntry', :through => :taggings

  extend FriendlyId
  friendly_id :name, :use => [:slugged, :finders]

  # Creates a scope with calulcated fields for summarising the tags e.g. with
  # count of entries etc.
  def self.summary
    select("blog_tags.id, blog_tags.slug, blog_tags.name, COUNT(blog_entries.id) AS entries_count")
      .joins(:entries)
      .group("blog_tags.id, blog_tags.name")
  end

  # Creates a scope which includes a count of associated blog entires and only
  # shows the tags that have published entries against them.
  #
  # @return ActiveRecord::Relation
  def self.public_listing
    select("blog_tags.id, blog_tags.slug, blog_tags.name, COUNT(blog_entries) AS entries_count, MAX(blog_entries.updated_at) AS updated_at")
      .joins(:entries)
      .group("blog_tags.id, blog_tags.name, blog_entries.published")
      .having("blog_entries.published = true")
      .order('blog_tags.name')
  end
end
