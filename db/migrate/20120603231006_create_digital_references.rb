class CreateDigitalReferences < ActiveRecord::Migration
  def change
    create_table :reference_digital do |t|
	  t.string :format
	  t.integer :institution_id
	  t.string :host_name
	  t.string :author_name
	  t.text :title
	  t.date :source_date
	  t.boolean :online_status
	  t.string :url
	  t.text :copyright
	  t.text :research_notes

      t.timestamps
    end
  end
end
