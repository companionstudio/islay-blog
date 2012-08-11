class CreateBlogTaggings < ActiveRecord::Migration
  def change
    create_table :blog_taggings do |t|
      t.references :blog_entry, :null => false, :on_delete => :cascade
      t.references :blog_tag,   :null => false, :on_delete => :cascade
    end
  end
end
