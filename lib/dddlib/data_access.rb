# frozen_string_literal: true

require_relative "abstract_command"

module DDDLib::DataAccess
  require_relative "data_access/abstract_query"
  require_relative "data_access/abstract_repository"

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
