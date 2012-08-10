Islay::Engine.extensions.register do |e|
  e.namespace :islay_blog

  e.admin_styles true
  e.admin_scripts false

  e.nav_entry('Blog', :blog)
end
