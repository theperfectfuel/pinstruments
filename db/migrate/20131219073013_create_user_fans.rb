class CreateUserFans < ActiveRecord::Migration
  def change
    create_table :user_fans do |t|
    	t.integer :user_id
    	t.integer :fan_id
      t.timestamps
    end

    add_index :user_fans, [:user_id, :fan_id]

  end
end
