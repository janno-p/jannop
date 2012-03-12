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

  def value(coin)
    (coin.is_a? CommemorativeCoin) ? coin.commemorative_year : nominal_value(coin)
  end

  def path(coin)
    (coin.is_a? CommemorativeCoin) ? show_year_coins_path(coin.commemorative_year) : nominal_path(coin)
  end
  
  def link_to_value(coin)
    link_to value(coin), path(coin)
  end
  
  def link_to_country(coin)
    link_to coin.country.name, show_country_coins_path(coin.country.code)
  end
end
