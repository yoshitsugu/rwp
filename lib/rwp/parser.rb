# frozen_string_literal: true

module Rwp
  class Parser
    def parse(buffer)
      ModuleNode.new(buffer)
    end
  end
end
