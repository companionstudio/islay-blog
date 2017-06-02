class IslayBlog::Admin::BlogTagsController < IslayBlog::Admin::ApplicationController
  header 'Blog - Tags'
  nav_scope :blog

  def index
    @blog_tags = BlogTag.summary.order('name')
  end

  def show
    @blog_tag = BlogTag.find(params[:id])
    @blog_entries = @blog_tag.entries.summary.page(params[:page]).order("published_at DESC")
  end
end
