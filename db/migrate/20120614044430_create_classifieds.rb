class CreateClassifieds < ActiveRecord::Migration
  def up
    create_table :classifieds do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.boolean :publish
      t.datetime :expires_at

      t.timestamps
    end
  end

  def down
    drop_table :classifieds
  end
end
