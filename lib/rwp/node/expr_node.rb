# frozen_string_literal: true

require_relative 'instr_node'

module Rwp
  module OP
    I32_CONST = 0x41
    LOCAL_GET = 0x20
    LOCAL_SET = 0x21
    OP_END = 0x0b
  end

  class ExprNode < SectionNode
    # @dynamic instrs, end_op
    attr_reader :instrs, :end_op

    def initialize
      super
      @instrs = []
    end

    def load(buffer)
      until buffer.eof?
        if (opcode = buffer.read_byte) == Rwp::OP::OP_END
          @end_op = _ = opcode
          break
        end
        raise 'Invalid opcode: nil' if opcode.nil?

        # @type var opcd: Rwp::OP::opcode
        opcd = _ = opcode
        instr = Rwp::InstrNode.create(opcd)
        raise "Invalid opcode: 0x#{opcd.to_s(16)}" unless instr

        instr.load(buffer)
        @instrs << instr
      end
    end
  end
end
