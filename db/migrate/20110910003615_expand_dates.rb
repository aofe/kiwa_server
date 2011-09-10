class ExpandDates < ActiveRecord::Migration
  
  def self.expand_date_columns(table, original_date_column, expanded_date_column_prefix = nil)
    year_column = expanded_date_column_prefix ? "#{expanded_date_column_prefix}_year" : 'year'
    month_column = expanded_date_column_prefix ? "#{expanded_date_column_prefix}_month" : 'month'
    day_column = expanded_date_column_prefix ? "#{expanded_date_column_prefix}_day" : 'day'

    add_column table, year_column, :integer
    add_column table, month_column, :integer
    add_column table, day_column, :integer
    
    execute("UPDATE #{table}
             SET #{year_column} = (select YEAR(#{original_date_column})),
                 #{month_column} = (select MONTH(#{original_date_column})),
                 #{day_column} = (select DAY(#{original_date_column}))")
    
    remove_column table, original_date_column
  end
  
  def self.up
    expand_date_columns(:voyages, :start_date, :start)
    expand_date_columns(:voyages, :end_date, :end)
    expand_date_columns(:people, :birth_date, :birth)
    expand_date_columns(:people, :death_date, :death)
    expand_date_columns(:events, :date)
  end

  def self.down
    raise "No going back now!"
  end
end
