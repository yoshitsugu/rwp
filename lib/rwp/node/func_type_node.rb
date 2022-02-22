# frozen_string_literal: true

module Rwp
  class FuncTypeNode
    # @dynamic param_type, result_type
    attr_reader :param_type, :result_type

    TAG = 0x60

    def load(buffer)
      raise 'Invalid func type' if buffer.read_byte != TAG

      @param_type = ResultTypeNode.new
      @param_type.load(buffer)
      @result_type = ResultTypeNode.new
      @result_type.load(buffer)
    end
  end
end
