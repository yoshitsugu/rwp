# frozen_string_literal: true

module Rwp
  class ModuleNode < Node
    # @dynamic magic, version
    attr_reader :magic, :version

    def initialize(input)
      super(input)
      @magic = input.read(4)&.bytes || []
      @version = input.read(4)&.bytes || []
    end
  end
end
