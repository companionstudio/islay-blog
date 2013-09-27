Islay::Engine.extensions.register do |e|
  e.namespace :islay_blog

  e.admin_styles true
  e.admin_scripts false

  e.nav_entry('Blog', :blog)

  e.add_item_entry('Blog Entry', :blog_entry, 'file-text')
end
