class BlogCommentLogDecorator < LogDecorator
  def url
    h.admin_blog_entry_url(model.parent_id)
  end
end
