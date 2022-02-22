# frozen_string_literal: true

require_relative 'locals_node'
require_relative 'expr_node'

module Rwp
  class FuncNode < SectionNode
    # @dynamic localses, expr
    attr_reader :localses, :expr

    def initialize
      super
      @localses = []
    end

    def load(buffer)
      @localses = buffer.read_vec do |buf|
        locals = Rwp::LocalsNode.new
        locals.load(buf)
        locals
      end

      # @type var e: Rwp::ExprNode
      e = Rwp::ExprNode.new
      e.load(buffer)
      @expr = e
    end
  end
end
