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
  
  def link_to_value(coin)
    if coin.is_a? CommemorativeCoin then
      link_to coin.commemorative_year, show_year_coins_path(coin.commemorative_year)
    elsif coin.is_a? CommonCoin then
      link_to nominal_value(coin), nominal_path(coin)
    else
      raise "Unexpected coin type!"
    end
  end
  
  def link_to_country(coin)
    link_to coin.country.name, show_country_coins_path(coin.country.code)
  end
end
