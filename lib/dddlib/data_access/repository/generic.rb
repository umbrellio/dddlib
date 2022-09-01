# frozen_string_literal: true

require "dddlib/data_access/queries/find"
require "dddlib/data_access/queries/save"
require "dddlib/data_access/queries/lock"

class DDDLib::DataAccess::Repository::Generic < DDDLib::DataAccess::Repository::Abstract
  register_query :find, DDDLib::DataAccess::Queries::Find
  register_query :save, DDDLib::DataAccess::Queries::Save
  register_query :lock, DDDLib::DataAccess::Queries::Lock

  def self.generate_guid
    Utils::Random.uuid
  end
end
