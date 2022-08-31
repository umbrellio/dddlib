# frozen_string_literal: true

class DDDLib::AbstractValue < DDDLib::AbstractStruct
  def self.build(*params, **attributes)
    new(*params, **attributes.symbolize_keys)
  end

  def ==(other)
    instance_of?(other.class) && attributes == other.attributes
  end

  def eql?(other)
    return false unless instance_of?(other.class)
    attributes.eql?(other.attributes)
  end

  alias to_h attributes
end
