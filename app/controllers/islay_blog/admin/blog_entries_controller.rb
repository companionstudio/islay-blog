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

  def permitted_params
    binding.pry
    params.permit(:blog_entry => [
      :title, :body, :tag_summary, :author_name, :notes, :season, :feature, :published, :author_id, :asset_ids
    ])
  end
end
