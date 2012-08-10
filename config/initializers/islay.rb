Islay::Engine.extensions.register do |e|
  e.namespace :islay_blog

  e.admin_styles false
  e.admin_scripts false

  e.nav_entry('Blog', :blog)
end
