# frozen_string_literal: true

module DDDLib
  require_relative "dddlib/version"

  module Core
    module EntityAttributes; end
  end

  module DataAccess
    module Commands; end
    module Queries; end
    module Repository; end # TODO: pluralize
    module Serialization; end
  end

  module Utils; end
  module Web; end
end
