class IslayBlog::Admin::BlogController < IslayBlog::Admin::ApplicationController
  header 'Blog'
  nav 'nav'

  def index
    @blog_entries = BlogEntry.summary.order('updated_at DESC').limit(8)
    @blog_tags    = BlogTag.order('name')
    @comments     = BlogComment.summary.order('updated_at DESC').limit(10)
  end
end
