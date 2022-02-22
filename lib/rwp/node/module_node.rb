# frozen_string_literal: true

module Rwp
  class ModuleNode
    # @dynamic magic, version, sections
    attr_reader :magic, :version, :sections

    def initialize(buffer)
      @magic = buffer.read_bytes(4)
      @version = buffer.read_bytes(4)

      @sections = []
      @sections << load_section(buffer) until buffer.eof?
    end

    def load_section(buffer)
      section_id = buffer.read_byte
      raise 'section_id is nil' if section_id.nil?

      section_size = buffer.read_u32
      section_buffer = buffer.read_buffer(section_size)

      section = SectionNode.create(section_id)
      section.load(section_buffer)
      section
    end
  end
end
