class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :other_name
      t.datetime :birth_date
      t.datetime :death_date
      t.text :background
      t.text :education
      t.text :character
      t.text :career
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
