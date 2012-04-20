class CreateThirdTest < ActiveRecord::Migration
  def up
    create_table :third do |t|
      t.string :name
    end
  end

  def down
    drop_table :third
  end
end
