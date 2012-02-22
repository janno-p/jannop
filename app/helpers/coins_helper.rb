module CoinsHelper
  def nominal_value(value)
    value = value.nominal_value if value.is_a? Coin
    number_to_currency(value, unit: '&euro;')
  end
  
  def country_path(coin)
    show_country_coins_path(coin.country.code)
  end
end
