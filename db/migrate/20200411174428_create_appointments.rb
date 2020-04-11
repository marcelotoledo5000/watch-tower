class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :visitor, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.integer :kind, null: false, default: 0
      t.datetime :event_time, null: false

      t.timestamps
    end
  end
end
