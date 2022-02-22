# frozen_string_literal: true

module Rwp
  class LocalGetInstrNode
    # @dynamic opcode, local_idx
    attr_reader :opcode, :local_idx

    def initialize(opcode)
      @opcode = opcode
    end

    def load(buffer)
      @local_idx = buffer.read_u32
    end
  end
end
