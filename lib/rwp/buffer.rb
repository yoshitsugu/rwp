# frozen_string_literal: true

module Rwp
  class Buffer
    def initialize(buffer)
      @buffer = buffer
    end

    def read_bytes(n)
      @buffer.read(n)&.bytes || []
    end

    def read_byte
      read_bytes(1).first
    end
  end
end
