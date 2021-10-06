class ReceivableDocumentResource < Avo::BaseResource
  self.sidebar_priority = 5
  self.sidebar_label = '전체 선정산 목록'
  self.title = :id
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :text, name: :id, link_to_resource: true, sortable: true do |model, resource, view|
    "선정산##{model.id}"
  end
  # add fields here

  field :shop, as: :belongs_to
  # field :order_amount_sum, as: :number, name: '주문합계액' do |model, resource, view|
  #   resource.number_to_currency model.order_amount_sum, unit: '원', format: '%n %u'
  # end

  field :bond, as: :has_one, name: '채권', hide_on: :index
  field :issue_date, as: :text, name: '지급일', only_on: :index do |model, resource, view|
    model.bond.issue_date.strftime('%F')
  end
  field :maturity_date, as: :text, name: '회수일', only_on: :index do |model, resource, view|
    model.bond.maturity_date.strftime('%F')
  end
  field :par_value, as: :text, name: '지급액', only_on: :index do |model, resource, view|
    resource.number_to_currency model.bond.par_value, unit: '원', format: '%n %u'
  end
  field :coupon_rate, as: :text, name: '할인율', only_on: [:index, :show] do |model, resource, view|
    resource.number_to_percentage model.bond.coupon_rate * 100, precision: 1
  end
  field :order_count, as: :number, name: '대상 주문 수', only_on: [:index, :show]

  field :captured_transaction, as: :has_one, name: '거래 기록', hide_on: :index

  field :released_at, as: :date_time, name: '처리일시', hide_on: :index
  field :bank_account, as: :belongs_to, as_label: '은행 계좌'
  field :received_bank_account, as: :key_value, name: '수취 은행 계좌 기록', only_on: :show

  field :orders, as: :has_many, through: :order_of_receivable_documents
end
