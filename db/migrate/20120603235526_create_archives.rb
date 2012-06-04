class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
    	t.integer :institution_id
    	t.string :id_num
    	t.string :archive_type
    	t.string :sub_type
    	t.string :author
    	t.date :start_date
    	t.date :end_date
    	t.text :title_long
    	t.string :title_short

      t.timestamps
    end
  end
end
