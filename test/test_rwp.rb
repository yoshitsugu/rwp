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

  def test_it_can_parse_type_section
    buffer = Rwp::Buffer.new(StringIO.new("\x00\x61\x73\x6d\x01\x00\x00\x00\x01\x05\x01\x60\x00\x01\x7f"))
    parsed = Rwp::Parser.new.parse(buffer)
    type_section = parsed.sections.first
    assert_equal Rwp::TypeSectionNode, type_section.class
    func_type = type_section.func_types.first
    assert_equal 0, func_type.param_type.val_types.length
    assert_equal 1, func_type.result_type.val_types.length
    assert_equal 127, func_type.result_type.val_types.first
  end
end
