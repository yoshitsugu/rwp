# frozen_string_literal: true

require_relative 'i32_const_instr_node'
require_relative 'local_get_instr_node'
require_relative 'local_set_instr_node'

module Rwp
  class InstrNode
    def self.create(opcode)
      case opcode
      when Rwp::OP::I32_CONST
        Rwp::I32ConstInstrNode.new(opcode)
      when Rwp::OP::LOCAL_GET
        Rwp::LocalGetInstrNode.new(opcode)
      when Rwp::OP::LOCAL_SET
        Rwp::LocalSetInstrNode.new(opcode)
      end
    end
  end
end
