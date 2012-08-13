class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.integer :blog_entry_id, :null => false, :on_delete => :cascade
      t.string  :name,          :null => false, :limit => 200
      t.string  :email,         :null => false, :limit => 200
      t.string  :body,          :null => false, :limit => 2000
      t.boolean :approved,      :null => false, :default => false

      t.timestamps
    end

    add_column(:blog_comments, :terms, :tsvector)
  end
end
