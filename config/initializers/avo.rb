require 'action_view/helpers/number_helper'

Avo.configure do |config|
  ## == Routing ==
  config.root_path = '/admin'

  ## == Licensing ==
  config.license = 'community'
  # config.license_key = ENV['AVO_LICENSE_KEY']

  ## == Set the context ==
  config.set_context do
    # Return a context object that gets evaluated in Avo::ApplicationController
  end

  ## == Authentication ==
  # config.current_user_method = :current_user
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end

  ## == Authorization ==
  # config.authorization_methods = {
  #   index: 'index?',
  #   show: 'show?',
  #   edit: 'edit?',
  #   new: 'new?',
  #   update: 'update?',
  #   create: 'create?',
  #   destroy: 'destroy?',
  # }

  ## == Localization ==
  # config.locale = 'en-US'

  ## == Customization ==
  config.app_name = 'Seller Recipe Admin'
  # config.timezone = 'UTC'
  # config.currency = 'USD'
  config.per_page = 25
  config.per_page_steps = [25, 50, 100, 500]
  # config.via_per_page = 8
  # config.default_view_type = :table
  # config.id_links_to_resource = false
  # config.full_width_container = false
  # config.full_width_index_view = false
  # config.cache_resources_on_index_view = true
  # config.search_debounce = 300
  # config.view_component_path = "app/components"
  # config.display_license_request_timeout_error = true


  # Where should the user be redirected when he hits the `/avo` url
  # config.home_path = nil

  ## == Breadcrumbs ==
  # config.display_breadcrumbs = true
  # config.set_initial_breadcrumbs do
  #   add_breadcrumb "Home", '/avo'
  # end
end

class Avo::BaseResource
  include ::ActionView::Helpers::NumberHelper

  class << self
    attr_accessor :sidebar_priority
    attr_accessor :sidebar_label
  end

  def sidebar_priority
    self.class.sidebar_priority
  end

  def sidebar_label
    self.class.sidebar_label || plural_name.humanize
  end


  class << self
    # fieldset :issue_date, as: [:date, :text], name: '만기일' do |model, resource, view|
    #   model.maturity_date.strftime('%F')
    # end
    #
    # field :maturity_date, as: :date, name: '만기일', hide_on: [:index, :show]
    # field :maturity_date, as: :text, name: '만기일', only_on: [:index, :show] do |model, resource, view|
    #   model.maturity_date.strftime('%F')
    # end
    #
    def field2(field_name, as: [], **args, &block)
      as = [as].flatten
      field field_name, as: as[0], **args.merge(hide_on: [:index, :show])
      field field_name, as: as[-1], **args.merge(only_on: [:index, :show]), &block
    end

    # @!method - :number_to_currency, :number_to_percentage
    def formatted_number_field(field_name, method: nil, **args)
      field field_name, as: :number, **args, hide_on: [:index, :show]
      field field_name, as: :text, **args, only_on: [:index, :show] do |model, resource, view|
        if method
          resource.send(method, model.send(field_name) * (args[:multiple] || 1), **args)
        else
          resource.number_to_currency model.send(field_name), **args
        end
      end
    end
  end
end
