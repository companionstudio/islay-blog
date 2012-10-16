class IslayBlog::Admin::BlogCommentsController < Islay::Admin::ApplicationController
  header 'Blog - Comments'
  nav 'islay_blog/admin/blog/nav'
  resourceful :blog_comment

  private

  def redirect_for(record)
    path(:blog_entry, :id => record.blog_entry_id)
  end

  def destroy_redirect_for(record)
    path(:blog_entry, :id => record.blog_entry_id)
  end
end
