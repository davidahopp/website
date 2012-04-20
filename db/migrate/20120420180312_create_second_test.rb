class CreateSecondTest < ActiveRecord::Migration
  def up
    create_table :second do |t|
      t.string :name
    end
  end

  def down
    drop_table :second
  end
end
