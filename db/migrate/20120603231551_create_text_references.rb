class CreateTextReferences < ActiveRecord::Migration
  def change
    create_table :reference_text do |t|
	  t.string :source_type
	  t.string :author_name
	  t.string :author_initial
	  t.text :title
	  t.date :source_date
	  t.string :city
	  t.string :publisher
	  t.string :book_editor
	  t.string :book_title
	  t.string :journal_title
	  t.string :volume
	  t.string :number
	  t.string :pages
	  t.string :first_edition
	  t.string :other_edition
	  t.string :institution
	  t.string :department
	  t.string :qualification
	  t.text :notes

      t.timestamps
    end
  end
end
