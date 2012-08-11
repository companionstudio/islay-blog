class IslayBlog::Admin::BlogController < IslayBlog::Admin::ApplicationController
  header 'Blog'
  nav 'nav'

  def index
    # Pending entries
    # Comments
    # Tag cloud

    @blog_tags = BlogTag.order('name')
  end
end
