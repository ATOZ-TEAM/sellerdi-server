class OrderResource < Avo::BaseResource
  self.title = :order_id
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  # add fields here
  field :first_item_img, as: :external_image, name: '', link_to_resource: true, only_on: :index

  field :shop, as: :belongs_to
  field :order_id, as: :text, name: '주문번호', sortable: true, link_to_resource: true
  field :first_item_img, as: :external_image, name: '대표상품이미지', hide_on: :index

  # index
  field :amount, as: :text, only_on: :index, name: '주문금액' do |model, resource, view|
    model.transaction_data.currency_format
  end
  # show
  field :payment, as: :key_value do |model, resource, view|
    model.transaction_data.as_json
  end

  # index, show
  field :date, as: :text, name: '주문일', sortable: true do |model, resource, view|
    model.date.strftime('%F')
  end
  # new, edit
  field :date, as: :date, hide_on: [:index, :show], first_day_of_week: 1, format: '%Y-%m-%d'
end
