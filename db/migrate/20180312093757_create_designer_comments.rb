class CreateDesignerComments < ActiveRecord::Migration[5.1]
  def change
    create_table :designer_comments do |t|
      t.date :date
      t.text :body
      t.references :designer, foreign_key: true
    end
  end
end
