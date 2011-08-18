class CreateInstitutions < ActiveRecord::Migration
  def self.up
    create_table :institutions do |t|
      t.string :long_name
      t.string :short_name
      t.string :address
      t.string :city
      t.string :country
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :institutions
  end
end
