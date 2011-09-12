class RemoveZeroPersonIdFromEvent < ActiveRecord::Migration
  def self.up
    Event.where(:person_id => 0).update_all(:person_id => nil)
  end

  def self.down
  end
end
