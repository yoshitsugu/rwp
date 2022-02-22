# frozen_string_literal: true

module Rwp
  class LocalsNode < SectionNode
    # @dynamic num, val_type
    attr_reader :num, :val_type

    def load(buffer)
      @num = buffer.read_u32
      @val_type = _ = buffer.read_byte
    end
  end
end
