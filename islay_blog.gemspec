$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "islay_blog/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "islay_blog"
  s.version     = IslayBlog::VERSION
  s.authors     = ["Luke Sutton", "Ben Hull"]
  s.email       = ["lukeandben@spookandpuff.com"]
  s.homepage    = "http://spookandpuff.com"
  s.summary     = "An extension to the Islay framework"
  s.description = "An extension to the Islay framework"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'islay',         '~> 1.0.4'
  s.add_dependency 'rdiscount',     '~> 1.6.8'
  s.add_dependency 'htmlentities',  '~> 4.3.1'
  s.add_dependency 'friendly_id',   '~> 4.0.8'
  s.add_dependency 'humanizer',     '~> 2.4.4'
end
