class CreateTaxRates < ActiveRecord::Migration[7.1]
  def change
    create_table :tax_rates do |t|
      t.string :province
      t.decimal :rate
      t.date :effective_date
      t.date :end_date

      t.timestamps
    end
  end
end
