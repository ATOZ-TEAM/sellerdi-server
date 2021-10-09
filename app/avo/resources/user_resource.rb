class UserResource < Avo::BaseResource
  self.sidebar_priority = 2
  self.sidebar_label = '회원 계정'

  self.devise_password_optional = true
  self.title = :name
  self.includes = []
  self.default_view_type = :table

  # self.search_query = ->(params:) do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id, link_to_resource: true
  # add fields here
  field :name, as: :text, link_to_resource: true
  field :email, as: :text, link_to_resource: true
  field :password, as: :password, placeholder: 'secret'
  field :sign_in_count, as: :number do |model, resource, view|
    model.sign_in_count
  end

  field :bank_accounts, as: :has_many
  field :shops, as: :has_many
end
