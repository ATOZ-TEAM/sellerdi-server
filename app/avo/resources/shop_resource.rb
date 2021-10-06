class ShopResource < Avo::BaseResource
  self.sidebar_priority = 4
  self.sidebar_label = '회원이 보유한 샵'

  self.title = :simple_name
  self.includes = [:orders, :receivable_documents]
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id, link_to_resource: true
  # add fields here
  field :user, as: :belongs_to, name: '소유자'
  field :market, as: :belongs_to, name: '대상 마켓플레이스'
  field :account, as: :text, name: '관리계정 ID', link_to_resource: true
  field :password, as: :password, name: '관리계정 PW'

  field :order_count, as: :number, name: '주문 수' do |model, resource, view|
    model.orders.count
  end
  field :orders, as: :has_many

  field :receivable_document_count, as: :number, name: '선정산 횟수' do |model, resource, view|
    model.receivable_documents.count
  end
  field :receivable_documents, as: :has_many
end
