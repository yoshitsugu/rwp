# frozen_string_literal: true

require_relative 'func_node'

module Rwp
  class CodeNode < SectionNode
    # @dynamic size, func
    attr_reader :size, :func

    def load(buffer)
      @size = buffer.read_u32
      raise 'Cannot load CodeNode' if @size.nil?

      func_buffer = buffer.read_buffer(@size || 0)
      @func = FuncNode.new
      @func.load(func_buffer)
    end
  end
end
