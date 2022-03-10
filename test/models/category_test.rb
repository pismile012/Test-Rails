require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @category = Category.new(name: "sports")
  end

  test "category shoul be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category = Category.new(name: "")
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category = Category.new(name: "sports")
    @category.save
    @category2 = Category.new(name: "sports")
    assert_not @category2.valid?
  end

  test "name should not be too long" do
    @category = Category.new(name: "a" * 26)
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category = Category.new(name: "aa")
    assert_not @category.valid?
  end
  
end