class CreateStyles < ActiveRecord::Migration[5.1]
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.references :designer, foreign_key: true
    end
  end
end
