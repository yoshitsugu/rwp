# frozen_string_literal: true

module Rwp
  class SectionNode
    def self.create(section_id)
      case section_id
      when 1
        TypeSectionNode.new
      when 3
        FunctionSectionNode.new
      when 10
        CodeSectionNode.new
      else
        raise "Invalid section id: #{section_id}"
      end
    end

    def load(_buffer)
      raise 'implement me'
    end
  end

  require_relative 'type_section_node'
  require_relative 'function_section_node'
  require_relative 'code_section_node'
end
