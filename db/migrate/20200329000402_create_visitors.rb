class CreateVisitors < ActiveRecord::Migration[6.0]
  def change
    create_table :visitors do |t|
      t.string :cpf, null: false, limit: 11
      t.string :name, null: false
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
    add_index :visitors, :cpf, unique: true
  end
end
