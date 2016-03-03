class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.date :date
      t.time :startTime
      t.time :endTime

      t.timestamps null: false
    end
  end
end
