class BankAccountResource < Avo::BaseResource
  self.sidebar_priority = 3
  self.sidebar_label = '회원이 보유한 은행계좌'

  self.title = :title
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  # field :id, as: :id
  # add fields here

  field :user, as: :belongs_to
  field :bank_name, as: :text, name: '은행명'
  field :account_num, as: :text, name: '계좌번호'
  field :holder_name, as: :text, name: '소유자명'
end
