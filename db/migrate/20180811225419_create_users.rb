class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
        #rails automatically creates id primary key column, to turn off use :id => false in create table statement after tablename,
        t.column "first_name", :string, :limit => 25  #table.column "column_name", dataType, options
        t.string "last_name", :limit => 50  #same as above but short hand
        t.string "email", :default => '', :null => false
        t.string "password", :limit => 40
        t.timestamps  #rails atuomatically creates columns for created_at & updated_at
    end
  end

  def down
      drop_table :users
  end
end
