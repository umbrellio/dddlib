# frozen_string_literal: true

class DDDLib::DataAccess::Commands::Lock < DDDLib::DataAccess::Commands::Abstract
  option :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repository::Abstract)
  option :entity, SmartCore::Types::Protocol::InstanceOf(DDDLib::Core::Entity)

  def call
    fail!(:new_entity) if entity.id.new_entity?

    DB.transaction do
      model = repo.model_class.lock_style("FOR NO KEY UPDATE").first!(id: entity.id.value)
      repo.load_entity(model, entity_to_reload: entity)
      yield
    end

    success!
  end
end
