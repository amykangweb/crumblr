class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.references :post
      t.references :user

      t.timestamps
    end
  end
end
