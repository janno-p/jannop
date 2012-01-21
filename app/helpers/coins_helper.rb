module CoinsHelper
  def nominal_value(coin)
    nominal_value(coin.nominal_value)
  end

  def nominal_value(value)
    number_to_currency(value, unit: '&euro;')
  end

  def show_nominal_coins_path(value)
    show_nominal_coins_path(number_with_precision(value, precision: 2, separator: '.'))
  end
end