# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :login, null: false, unique: true
      t.string :name, null: false
      t.integer :role, null: false, default: 0
      t.references :store, foreign_key: true

      t.timestamps
    end
    add_index :users, :login, unique: true
  end
end
