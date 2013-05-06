class CreateNumberingItems < ActiveRecord::Migration
  def change
    create_table :numbering_items do |t|
      t.integer :numbering_prefix_id
      t.integer :number
      t.string :subject
      t.text :description
    end
  end
end
