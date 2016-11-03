class IslayBlog::Admin::BlogController < IslayBlog::Admin::ApplicationController
  header 'Blog'
  nav_scope :blog

  def index
    @blog_entries = BlogEntry.order('updated_at DESC').limit(10)
    @blog_tags    = BlogTag.order('name')
    @comments     = BlogComment.summary.order('updated_at DESC').limit(10)
  end
end
