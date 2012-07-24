class SplitDates < ActiveRecord::Migration
  def up
    add_column :reference_text, :source_year, :integer
    add_column :reference_text, :source_month, :integer
    add_column :reference_text, :source_day, :integer

    add_column :reference_digital, :source_year, :integer
    add_column :reference_digital, :source_month, :integer
    add_column :reference_digital, :source_day, :integer

    add_column :archives, :start_year, :integer
    add_column :archives, :start_month, :integer
    add_column :archives, :start_day, :integer
    add_column :archives, :end_year, :integer
    add_column :archives, :end_month, :integer
    add_column :archives, :end_day, :integer

    remove_column :reference_text, :source_date
    remove_column :reference_digital, :source_date
    remove_column :archives, :start_date
    remove_column :archives, :end_date
  end

  def down
    raise 'No going back now!'
  end
end