Islay::Engine.searches do |config|
  config.search(:blog_comment) do |c|
    {c.name => 'A'}
  end

  config.search(:blog_entry, :name => 'title') do |e|
    {e.title => 'A', e.body => 'B'}
  end
end

