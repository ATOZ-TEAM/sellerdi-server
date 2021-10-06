class ExchangeInfoResource < Avo::BaseResource
  self.sidebar_priority = 0
  self.sidebar_label = '환율'

  self.title = :name
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id, hide_on: :index
  field :name, as: :text, link_to_resource: true
  field :currency, as: :text
  field :symbol, as: :text, only_on: [:show]
  field :price, as: :number
  field :description, as: :text, only_on: :index, link_to_resource: true do |model, resource, view|
    model.kr || model.en || model.jp
  end
  field :kr, as: :text, only_on: [:show]
  field :en, as: :text, only_on: [:show]
  field :jp, as: :text, only_on: [:show]
  # add fields here
end
