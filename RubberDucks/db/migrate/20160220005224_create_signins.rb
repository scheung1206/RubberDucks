class CreateSignins < ActiveRecord::Migration
  def change
    create_table :signins do |t|
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
