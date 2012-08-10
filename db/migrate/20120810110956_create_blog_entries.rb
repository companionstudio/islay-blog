class CreateBlogEntries < ActiveRecord::Migration
  def change
    create_table :blog_entries do |t|
      t.integer :author_id,   :null => false, :references => :users, :on_delete => :cascade
      t.string  :title,       :null => false, :limit => 200
      t.string  :body,        :null => false, :limit => 8000

      t.publishing
      t.user_tracking
      t.timestamps
    end
  end
end
