class FixColumnName < ActiveRecord::Migration
   def change
    rename_column :events, :Date, :date
  end
end
