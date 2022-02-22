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

  def test_it_can_parse_const_wasm
    filename = File.join(File.dirname(__FILE__), 'data/const.wasm')
    File.open(filename) do |file|
      buffer = Rwp::Buffer.new(file)
      parsed = Rwp::Parser.new.parse(buffer)
      assert_equal 3, parsed.sections.length
      type_section = parsed.sections.first
      assert_equal Rwp::TypeSectionNode, type_section.class
      func_type = type_section.func_types.first
      assert_equal 0, func_type.param_type.val_types.length
      assert_equal 1, func_type.result_type.val_types.length
      assert_equal 127, func_type.result_type.val_types.first
      func_section = parsed.sections[1]
      assert_equal 1, func_section.type_idxs.length
      assert_equal 0, func_section.type_idxs.first
      code_section = parsed.sections.last
      assert_equal 1, code_section.codes.length
      code = code_section.codes.first
      assert_equal 0, code.func.localses.length
      assert_equal 1, code.func.expr.instrs.length
      assert_equal Rwp::I32ConstInstrNode, code.func.expr.instrs.first.class
      assert_equal 65, code.func.expr.instrs.first.opcode
      assert_equal 42, code.func.expr.instrs.first.num
      assert_equal 11, code.func.expr.end_op
    end
  end

  def test_it_can_parse_local_wasm
    filename = File.join(File.dirname(__FILE__), 'data/local.wasm')
    File.open(filename) do |file|
      buffer = Rwp::Buffer.new(file)
      parsed = Rwp::Parser.new.parse(buffer)
      code_section = parsed.sections.last
      assert_equal 1, code_section.codes.length
      code = code_section.codes.first
      assert_equal 1, code.func.localses.length
      assert_equal 1, code.func.localses.first.num
      assert_equal 127, code.func.localses.first.val_type
      assert_equal 33, code.func.expr.instrs[1].opcode
      assert_equal 32, code.func.expr.instrs[2].opcode
    end
  end
end
