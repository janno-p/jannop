require 'test_helper'

class CoinTest < ActiveSupport::TestCase
  test "should not save without required attributes" do
    coin = CommonCoin.new
    assert !coin.save
    assert_equal 2, coin.errors.count
    assert_equal 1, coin.errors[:nominal_value].count
    assert_equal "is not included in the list", coin.errors[:nominal_value][0]
    assert_equal 1, coin.errors[:country].count
    assert_equal "can't be blank", coin.errors[:country][0]
  end

  test "image larger than 2 megabytes" do
    coin = CommonCoin.new(nominal_value: 2.00,
                          country: Country.new,
                          image_file_size: 3.megabytes)
    assert !coin.save
    assert_equal 1, coin.errors.count
    assert_equal 1, coin.errors[:image_file_size].count
    assert_equal "file size must be between 0 and 2097152 bytes", coin.errors[:image_file_size][0]
  end
end
