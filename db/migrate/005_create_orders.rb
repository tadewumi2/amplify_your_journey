class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status, default: 'pending'
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end