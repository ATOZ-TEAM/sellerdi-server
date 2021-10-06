class MarketResource < Avo::BaseResource
  self.sidebar_priority = 1
  self.sidebar_label = '마켓플레이스'

  self.title = :title
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id, link_to_resource: true
  # add fields here

  field :title, as: :text, link_to_resource: true, sortable: true
  field :name, as: :text, required: true, hide_on: [:index]
  field :country_code, as: :text, required: true, hide_on: [:index]

  field :currency, as: :text, required: true

  field :shops, as: :has_many
end
