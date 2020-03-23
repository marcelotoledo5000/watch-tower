class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :cnpj, null: false, limit: 14, unique: true
      t.string :name, null: false

      t.timestamps
      t.index :cnpj, unique: true
    end
  end
end
