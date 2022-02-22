# frozen_string_literal: true

require_relative 'result_type_node'
require_relative 'func_type_node'

module Rwp
  class TypeSectionNode < SectionNode
    # @dynamic func_types
    attr_reader :func_types

    def initialize
      super
      @func_types = []
    end

    def load(buffer)
      @func_types = buffer.read_vec do
        func_type = FuncTypeNode.new
        func_type.load(buffer)
        func_type
      end
    end
  end
end
