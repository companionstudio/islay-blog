class BlogEntryLogDecorator < LogDecorator
  def url
    h.admin_blog_entry_path(model.id)
  end
end
