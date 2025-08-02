class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: true, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :event_type, null: false
      t.string :organization, null: false
      t.date :preferred_date, null: false
      t.text :notes

      t.timestamps
    end
  end
end