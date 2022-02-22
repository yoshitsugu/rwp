# frozen_string_literal: true

module Rwp
  class ResultTypeNode
    # @dynamic val_types
    attr_reader :val_types

    def initialize
      @val_types = []
    end

    def load(buffer)
      @val_types = buffer.read_vec do |buf|
        # @type var byte: Rwp::TypeSectionNode::val_type
        byte = _ = buf.read_byte
        raise 'Cannot load ResultTypeNode' if byte.nil?

        byte
      end
    end
  end
end
