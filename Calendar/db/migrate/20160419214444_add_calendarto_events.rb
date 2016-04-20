class AddCalendartoEvents < ActiveRecord::Migration
  def change
    add_reference :events, :calendar, index:true
    add_foreign_key :events, :calendar
  end
end
