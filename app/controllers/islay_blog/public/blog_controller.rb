class IslayBlog::Public::BlogController < IslayBlog::Public::ApplicationController
  def index
    @blog_entries = BlogEntry.public_summary.active.page(params[:page]).per(5)
  end

  def entry
    @blog_entry = BlogEntry.public_summary.active.find(params[:id])
  end

  def comment

  end

  def tags

  end
end
