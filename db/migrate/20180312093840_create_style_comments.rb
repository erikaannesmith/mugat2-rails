class CreateStyleComments < ActiveRecord::Migration[5.1]
  def change
    create_table :style_comments do |t|
      t.date :date
      t.text :body
      t.references :style, foreign_key: true
    end
  end
end
