# frozen_string_literal: true

require 'test_helper'
require_relative '../lib/rwp'

class TestRwp < Minitest::Test
  def test_it_can_parse_module_wasm
    filename = File.join(File.dirname(__FILE__), 'data/module.wasm')
    File.open(filename) do |file|
      buffer = Rwp::Buffer.new(file)
      parsed = Rwp::Parser.new.parse(buffer)
      assert_equal [0x00, 0x61, 0x73, 0x6d], parsed.magic
      assert_equal [0x01, 0x00, 0x00, 0x00], parsed.version
    end
  end
end
