class CreateBlogTaggings < ActiveRecord::Migration
  def change
    create_table :blog_taggings do |t|
      t.integer :blog_entry_id, :null => false, :on_delete => :cascade
      t.integer :blog_tag_id,   :null => false, :on_delete => :cascade
    end
  end
end
