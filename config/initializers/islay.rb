Islay::Engine.extensions.register do |e|
  e.namespace :islay_blog

  e.admin_styles true
  e.admin_scripts false

  e.add_item_entry('Blog Entry', :blog_entry, 'newspaper-o')

  e.nav_section(:blog) do |s|
    s.root('Blog', :blog, 'newspaper-o')
    s.sub_nav('Overview', :blog, :root => true)
    s.sub_nav('Entries', :blog_entries)
    s.sub_nav('Tags', :blog_tags)
  end
end
