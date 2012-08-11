class BlogTagging < ActiveRecord::Base
  belongs_to :entry,  :class_name => "BlogEntry", :foreign_key => 'blog_entry_id'
  belongs_to :tag,    :class_name => "BlogTag",   :foreign_key => 'blog_tag_id'

  attr_accessible :tag
end
