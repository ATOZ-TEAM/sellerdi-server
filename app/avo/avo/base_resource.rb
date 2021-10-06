require 'action_view/helpers/number_helper'

class Avo::BaseResource
  include ::ActionView::Helpers::NumberHelper
  include ::ApplicationHelper

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
