class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :price, precision: 8, scale: 2, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date

      t.timestamps
    end
  end
end