# frozen_string_literal: true

class DDDLib::AbstractWebAction < DDDLib::AbstractCommand # TODO: move somewhere?
  Response = Struct.new(:status, :content_type, :data, :headers, keyword_init: true)

  # param :request, Types::InstanceOf(Utils::RequestWrapper)
  param :request # TODO: handle types

  def self.define_input_schema(&)
    schema = Class.new(SmartCore::Schema) { schema(&) }

    const_set(:InputSchema, schema)
  end

  private

  def render_success!(data:, status: 200, content_type: :json)
    success!(Response.new(status:, content_type:, data:))
  end

  def render_error!(data:, status: 422, content_type: :json)
    success!(Response.new(status:, content_type:, data:))
  end

  def render_redirect!(url)
    headers = { "Location" => url }
    success!(Response.new(status: 302, content_type: :plain, data: "", headers:))
  end
end
