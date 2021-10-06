class ReceivableTransactionResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  # field :id, as: :id
  # add fields here
  field :start, as: :text, name: '원본금액', only_on: [:index, :show] do |model, resource, view|
    "(#{model.start_currency}) #{resource.number_to_currency model.start_amount, format: '%n'}"
  end
  field :final, as: :text, name: '수령금액', only_on: [:index, :show] do |model, resource, view|
    "(#{model.final_currency}) #{resource.number_to_currency model.final_amount, format: '%n'}"
  end
  field :start_currency, as: :text, name: '원본통화', hide_on: [:index, :show]
  field :final_currency, as: :text, name: '수령통화', hide_on: [:index, :show]
  field2 :currency_ratio, as: :number, name: '적용환율' do |model, resource, view|
    "<b>#{model.currency_ratio}</b> (1 #{model.start_currency} = #{model.currency_ratio} #{model.final_currency})".html_safe
  end
  field :created_at, as: :date_time, name: '실행시각'
end
