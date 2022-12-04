# frozen_string_literal: true
require 'graphql/schema/base_64_bp'

module GraphQL
  class Schema
    module UniqueWithinType
      class << self
        attr_accessor :default_id_separator
      end
      self.default_id_separator = "-"

      module_function

      # @param type_name [String]
      # @param object_value [Any]
      # @return [String] a unique, opaque ID generated as a function of the two inputs
      def encode(type_name, object_value, separator: self.default_id_separator)
        object_value_str = object_value.to_s

        if type_name.include?(separator)
          raise "encode(#{type_name}, #{object_value_str}) contains reserved characters `#{separator}` in the type name"
        end

        Base64.strict_encode64([type_name, object_value_str].join(separator))
      end

      # @param node_id [String] A unique ID generated by {.encode}
      # @return [Array<(String, String)>] The type name & value passed to {.encode}
      def decode(node_id, separator: self.default_id_separator)
        GraphQL::Schema::Base64Encoder.decode(node_id).split(separator, 2)
      end
    end
  end
end
