class CreateSiteContents < ActiveRecord::Migration[7.1]
  def change
    create_table :site_contents do |t|
      t.string :page_name
      t.string :title
      t.text :content
      t.text :data

      t.timestamps
    end
  end
end
