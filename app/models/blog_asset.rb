class BlogAsset < ActiveRecord::Base
  belongs_to :entry, :class_name => 'BlogEntry', :foreign_key => 'blog_entry_id'
  belongs_to :asset
end
