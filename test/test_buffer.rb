# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/rwp'

class TestBuffer < Minitest::Test
  def test_read_u32
    buffer = Rwp::Buffer.new(StringIO.new("\x90\xbb\x17"))
    assert_equal 384_400, buffer.read_u32
  end

  def test_read_i32
    buffer = Rwp::Buffer.new(StringIO.new("\xb8\x7e"))
    assert_equal(-200, buffer.read_i32)
    buffer = Rwp::Buffer.new(StringIO.new("\xb8\x7e"))
    assert_equal(-200, buffer.read_s32)
  end
end
