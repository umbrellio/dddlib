# frozen_string_literal: true

require "sequel"

require "dddlib/data_access/commands/abstract"

class DDDLib::DataAccess::Commands::Find < DDDLib::DataAccess::Commands::Abstract
  option :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repositories::Abstract)
  option? :scope, SmartCore::Types::Protocol::InstanceOf(Sequel::Dataset)
  option? :where, SmartCore::Types::Protocol::InstanceOf(Hash, Array)
  option? :exclude, SmartCore::Types::Protocol::InstanceOf(Hash, Array)

  def call
    model = query.first or fail!(:not_found)
    entity = repo.load_entity(model)
    success!(entity)
  end

  private

  def query
    [where_clause, exclude_clause].reduce(search_scope) do |query, clause|
      apply_clause(query, clause)
    end
  end

  def where_clause
    to_clause(:where, where)
  end

  def exclude_clause
    to_clause(:exclude, exclude)
  end

  # :nocov:
  def search_scope
    attribute_provided?(:scope) ? scope : repo.model_class
  end
  # :nocov:

  def apply_clause(query, clause)
    clause ? query.public_send(*clause) : query
  end

  def to_clause(name, payload)
    [name, payload].flatten if attribute_provided?(name)
  end
end
