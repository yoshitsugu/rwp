# frozen_string_literal: true

module Rwp
  class Parser
    def parse(input)
      ModuleNode.new(input)
    end
  end
end
