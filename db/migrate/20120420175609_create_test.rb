class CreateTest < ActiveRecord::Migration
  def up
    create_table :products do |t|
      t.string :name
    end
  end

  def down
    drop_table :products
  end
end
