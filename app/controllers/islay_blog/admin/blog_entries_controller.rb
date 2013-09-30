class IslayBlog::Admin::BlogEntriesController < IslayBlog::Admin::ApplicationController
  header 'Blog - Entries'
  resourceful :blog_entry
  nav_scope :blog

  def index
    @blog_entries = BlogEntry.summary.filter(params[:filter]).page(params[:page]).sorted(params[:sort])
  end

  private

  def dependencies
    @users = User.order('name')
    @assets = Asset.order('name')
  end
end
