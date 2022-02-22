# frozen_string_literal: true

module Rwp
  class I32ConstInstrNode
    # @dynamic opcode, num
    attr_reader :opcode, :num

    def initialize(opcode)
      @opcode = opcode
    end

    def load(buffer)
      @num = buffer.read_i32
    end
  end
end
