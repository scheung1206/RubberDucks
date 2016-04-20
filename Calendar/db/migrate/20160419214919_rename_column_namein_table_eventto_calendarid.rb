class RenameColumnNameinTableEventtoCalendarid < ActiveRecord::Migration
  def change
    rename_column :events, :calendars_id, :calendar_id
  end
end
