# frozen_string_literal: true

require "dddlib/data_access/commands/abstract"
require "dddlib/core/entity"

class DDDLib::DataAccess::Commands::Save < DDDLib::DataAccess::Commands::Abstract
  option :repo, SmartCore::Types::Protocol::InstanceOf(DDDLib::DataAccess::Repositories::Abstract)
  option :entity, SmartCore::Types::Protocol::InstanceOf(DDDLib::Core::Entity)
  option :retried_constraints, SmartCore::Types::Value::Array, default: []

  def call
    attrs_to_persist = select_attrs_to_persist

    if attrs_to_persist.any?
      process_updating!
      success!(repo.load_entity(model))
    else
      success!(entity)
    end
  end

  private

  attr_accessor :model

  def process_updating!
    DB.transaction do
      self.model = find_or_initialize_model
      save_model!
    end
  end

  def find_or_initialize_model
    if new_entity?
      repo.model_class.new
    else
      repo.model_class.lock_style("FOR NO KEY UPDATE").first!(id: entity.id.value)
    end
  end

  def save_model!
    Utils::Control.retry_on_unique_violation(checked_constraints: retried_constraints) do
      model.update(select_attrs_to_persist)
    end
  rescue Utils::Control::UniqueConstraintViolation
    # :nocov:
    fail!(:already_exists)
  rescue Sequel::CheckConstraintViolation => error
    contraint_name = Utils::Database.get_violated_constraint_name(error)
    fail!(:check_contraint_violation, { name: contraint_name })
  end
  # :nocov:

  def select_attrs_to_persist
    if new_entity?
      dump_entity
    else
      dump_entity_changed_attrs
    end
  end

  def dump_entity
    repo.dump_entity(entity).tap do |attrs|
      # :nocov:
      attrs.delete(:id) if attrs[:id].nil?
      # :nocov:
    end
  end

  def dump_entity_changed_attrs
    repo.dump_entity_changed_attributes(entity)
  end

  def new_entity?
    entity.id.new_entity?
  end
end
