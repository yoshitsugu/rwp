# frozen_string_literal: true

require 'forwardable'

module Rwp
  class Buffer
    extend Forwardable

    # @dynamic bytesize
    attr_reader :bytesize

    # @dynamic eof?
    delegate({ [:eof?] => :@buffer })

    def initialize(buffer)
      @buffer = buffer
      @bytesize = buffer.read&.bytesize || 0
      buffer.rewind
    end

    def read_bytes(n)
      @buffer.read(n)&.bytes || []
    end

    def read_byte
      read_bytes(1).first
    end

    def read_buffer(size = @bytesize - @buffer.pos)
      Buffer.new(StringIO.new(@buffer.read(size) || ''))
    end

    def read_u32
      result = 0
      shift = 0
      loop do
        byte = read_byte
        raise 'Cannot read as u32' if byte.nil?

        result |= (byte & 0b01111111) << shift
        shift += 7
        return result if (0b10000000 & byte).zero?
      end
    end

    def read_s32
      result = 0
      shift = 0
      loop do
        byte = read_byte
        raise 'Cannot read as s32' if byte.nil?

        result |= (byte & 0b01111111) << shift
        shift += 7
        next unless (0b10000000 & byte).zero?
        return (result | (~0 << shift)) if shift < 32 && !(byte & 0b01000000).zero?

        return result
      end
    end

    # @dynamic read_i32
    alias read_i32 read_s32

    def read_vec
      max = read_u32
      max.times.map { yield(self) }
    end
  end
end
