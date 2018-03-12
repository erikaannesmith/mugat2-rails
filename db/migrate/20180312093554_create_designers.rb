class CreateDesigners < ActiveRecord::Migration[5.1]
  def change
    create_table :designers do |t|
      t.string :company
      t.string :contact
      t.string :phone
      t.string :email
      t.references :user, foreign_key: true
    end
  end
end
