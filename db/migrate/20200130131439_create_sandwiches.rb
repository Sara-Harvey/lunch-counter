class CreateSandwiches < ActiveRecord::Migration
  def change
  	 create_table :sandwiches do |t|
       t.string :title
       t.integer :calories
       t.text :description
	   t.integer :restaurant_id
    end
  end
end