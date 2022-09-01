# frozen_string_literal: true

require "sequel"

require "dddlib"

module DDDLib::DataAccess
  def self.Model(db, table) # rubocop:disable Naming/MethodName
    table =
      if table.is_a?(Symbol)
        table
      else
        Sequel[table.keys.first][table.values.first]
      end

    Sequel::Model(db[table])
  end
end
