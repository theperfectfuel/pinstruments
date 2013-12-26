class ChangeNameColumnToProfileName < ActiveRecord::Migration
  def change
  	rename_column :users, :name, :profile_name
  end
end
