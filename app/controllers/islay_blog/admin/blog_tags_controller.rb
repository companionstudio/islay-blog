class IslayBlog::Admin::BlogTagsController < IslayBlog::Admin::ApplicationController
  header 'Blog - Tags'
  nav 'islay_blog/admin/blog/nav'

  def index
    @blog_tags = BlogTag.summary.order('name')
  end

  def show
    @blog_tag = BlogTag.find(params[:id])
    @blog_entries = @blog_tag.entries.summary.page(params[:page]).order("published_at")
  end
end
