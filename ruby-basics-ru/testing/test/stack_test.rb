# frozen_string_literal: true

require_relative 'test_helper'
require 'minitest/power_assert'

require_relative '../lib/stack'

class StackTest < Minitest::Test
  attr_accessor :stack

  def setup
    items = (1...20).map { || Random.rand(2000) }
    @stack = Stack.new(items)
  end

  def teardown
    @stack.clear!
  end

  def test_pop!
    before = @stack.to_a
    random_item = Random.rand(2000)
    @stack.push!(random_item)
    popped_item = @stack.pop!
    assert { @stack.to_a == before }
    assert { popped_item == random_item }
  end

  def test_push!
    before = @stack.to_a
    popped_item = @stack.pop!
    @stack.push!(popped_item)
    assert { @stack.to_a == before }
  end

  def test_empty?
    s = Stack.new
    assert { s.empty? }
    s.push!(11)
    assert { !s.empty? }
    assert { !@stack.empty? }
    @stack.clear!
    assert { @stack.empty? }
  end

  def test_clear!
    s = Stack.new
    assert { s.to_a == s.clear!.to_a }
    @stack.clear!
    assert { @stack.to_a == [] }
  end
end

test_methods = StackTest.new('stack').methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
