class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :type
      t.string :title
      t.string :author
      t.string :description
      t.string :attachment

      t.timestamps null: false
    end
  end
end
