# frozen_string_literal: true

require_relative 'i32_const_instr_node'

module Rwp
  class InstrNode
    def self.create(opcode)
      case opcode
      when Rwp::OP::I32_CONST
        Rwp::I32ConstInstrNode.new(opcode)
      end
    end
  end
end
