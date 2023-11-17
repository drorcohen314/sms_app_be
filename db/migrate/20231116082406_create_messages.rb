class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.string :recipient
      t.text :content
      t.boolean :sent

      t.timestamps
    end
  end
end
