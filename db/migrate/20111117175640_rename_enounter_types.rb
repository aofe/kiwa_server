class RenameEnounterTypes < ActiveRecord::Migration
  def up
    execute("UPDATE encounters SET type = 'SourceEncounter' WHERE type = 'MAAEncounter'")
    execute("UPDATE encounters SET type = 'AOFEEncounter' WHERE type = 'AOEEncounter'")
  end

  def down
    execute("UPDATE encounters SET type = 'MAAEncounter' WHERE type = 'SourceEncounter'")
    execute("UPDATE encounters SET type = 'AOEEncounter' WHERE type = 'AOFEEncounter'")
  end
end
