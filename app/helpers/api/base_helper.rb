module Api::BaseHelper
  def json_builder_timestamp(builder, record, include_url: false)
    builder.created_at record.created_at
    builder.updated_at record.updated_at
    builder.url include_url if include_url
  end
end
