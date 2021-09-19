module DefaultColumn
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    # Example:
    #   class Foo < ApplicationRecord   # After
    #     make_default_value_of_column :requested_at, -> { Time.zone.now }
    #   end
    #
    #   class Foo < ApplicationRecord   # Before
    #     before_validation :mark_requested_at
    #
    #     def mark_requested_at(force = false)
    #       self.requested_at = Time.zone.now if force || self.requested_at.nil?
    #     end
    #   end
    def make_default_value_of_column(column_name, default_value = nil, on: :before_validation, repeat: false, &block)
      active_record_hook_name = on
      setter_method_name = "mark_#{column_name}".to_sym

      public_send(active_record_hook_name, setter_method_name)
      define_method setter_method_name do |force = repeat|
        if force || public_send(column_name).nil?
          default_value ||= block
          value = default_value.is_a?(Proc) ? instance_exec(&default_value) : default_value
          public_send("#{column_name}=", value)
        end
      end
    end
  end
end
