module CoinsHelper
  def nominal_value(value)
    value = value.nominal_value if value.is_a? Coin
    number_to_currency(value, unit: '&euro;')
  end
  
  def country_path(coin)
    show_country_coins_path(coin.country.code)
  end

  def nominal_path(coin)
  	show_nominal_coins_path(coin.nominal_value)
  end

  def coin_url(coin)
    coin.new_record? ? coins_path : coin_path(coin)
  end
end
