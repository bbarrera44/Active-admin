class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :active
      t.string :user
      t.integer :tickets_id
      t.integer :posts_id
      t.string :document

      t.timestamps
    end
  end
end
