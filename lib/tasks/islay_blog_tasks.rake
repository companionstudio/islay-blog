namespace :islay_blog do
  namespace :db do
    desc "Rebuilds the search term index for each record in the DB."
    task :rebuild_search_index => :environment do
      PgSearch::Multisearch.rebuild(BlogEntry)
      PgSearch::Multisearch.rebuild(BlogComment)
    end

    desc "Loads in seed data for bootstrapping a fresh Islay app."
    task :seed => :environment do

    end
  end
end