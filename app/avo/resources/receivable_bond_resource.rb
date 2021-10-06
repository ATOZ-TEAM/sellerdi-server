class ReceivableBondResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id, name: '채권 ID', link_to_resource: true
  # add fields here

  formatted_number_field :par_value, name: '액면가', unit: '원', format: '%n %u'
  formatted_number_field :coupon_rate, name: '할인율', method: :number_to_percentage, multiple: 100, precision: 1

  field2 :issue_date, as: [:date, :text], name: '발행일'  do |model, resource, view|
    model.issue_date.strftime('%F')
  end

  field2 :maturity_date, as: [:date, :text], name: '만기일' do |model, resource, view|
    model.maturity_date.strftime('%F')
  end

  field :created_at, as: :text, name: '생성시각', only_on: [:index, :show]
end
