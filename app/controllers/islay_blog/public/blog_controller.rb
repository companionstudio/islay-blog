class IslayBlog::Public::BlogController < IslayBlog::Public::ApplicationController
  def index
    @blog_entries = BlogEntry.public_summary.active.page(params[:page]).per(5)
    @blog_tags = BlogTag.public_listing
  end

  def entry
    @blog_entry = BlogEntry.public_summary.active.find(params[:id])
    @comment    = BlogComment.new
  end

  def comment
    @blog_entry = BlogEntry.public_summary.active.find(params[:id])
    @comment    = BlogComment.new(:blog_entry_id => @blog_entry.id)
    if @comment.update_attributes(params[:blog_comment])
      redirect_to path(@blog_entry)
    else
      render :entry
    end
  end

  def tag
    @blog_tag = BlogTag.find(params[:id])
  end
end
