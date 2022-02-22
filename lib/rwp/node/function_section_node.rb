# frozen_string_literal: true

module Rwp
  class FunctionSectionNode < SectionNode
    # @dynamic type_idxs
    attr_reader :type_idxs

    def initialize
      super
      @type_idxs = []
    end

    def load(buffer)
      @type_idxs = buffer.read_vec(&:read_u32)
    end
  end
end
