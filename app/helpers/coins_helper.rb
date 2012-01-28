module CoinsHelper
  def nominal_value(value)
    value = value.nominal_value if value.is_a? Coin
    number_to_currency(value, unit: '&euro;')
  end
end
