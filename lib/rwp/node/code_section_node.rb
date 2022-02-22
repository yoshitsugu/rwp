# frozen_string_literal: true

require_relative 'code_node'

module Rwp
  class CodeSectionNode < SectionNode
    # @dynamic codes
    attr_reader :codes

    def initialize
      super
      @codes = []
    end

    def load(buffer)
      @codes = buffer.read_vec do |buf|
        code = CodeNode.new
        code.load(buf)
        code
      end
    end
  end
end
