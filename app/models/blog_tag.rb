class BlogTag < Tag
  has_many :taggings, :class_name => 'BlogTagging'
  has_many :entries,  :class_name => 'BlogEntry', :through => :taggings

  # Creates a scope which includes a count of associated blog entires and only
  # shows the tags that have published entries against them.
  #
  # @return ActiveRecord::Relation
  def self.public_listing
    select("blog_tags.id, blog_tags.name, COUNT(blog_entries) AS entries_count")
      .joins(:entries).group("blog_tags.id, blog_tags.name, blog_entries.published")
      .having("blog_entries.published = true")
      .order('blog_tags.name')
  end
end
