class BlogTag < Tag
  has_many :taggings, :class_name => 'BlogTagging'
  has_many :entries,  :class_name => 'BlogEntry', :through => :taggings
end
