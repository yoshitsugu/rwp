# frozen_string_literal: true

module Rwp
  class ModuleNode < Node
    # @dynamic magic, version
    attr_reader :magic, :version

    def initialize(buffer)
      super(buffer)
      @magic = buffer.read_bytes(4)
      @version = buffer.read_bytes(4)
    end
  end
end
