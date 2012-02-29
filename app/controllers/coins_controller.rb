# coding: utf-8

class CoinsController < ApplicationController
  skip_before_filter :ensure_signed_in, :except => [:new_common, :new_commemorative]
  authorize_resource :class => false

  def index
    @latest_coins = Coin.get_latest(5)
  end

  def new_common
    @coin = CommonCoin.new
    new
  end

  def new_commemorative
    @coin = CommemorativeCoin.new
    new
  end

  def create
    @countries = Country.all_ordered_by_name

    coin_hash = params[:coin]
    collected = coin_hash.delete(:collected).to_i == 1
    collected_by = coin_hash.delete(:collected_by)

    @coin = params[:coin_type].constantize.new(coin_hash)
    @coin.collect(collected ? Time.now : nil, collected_by)

    @coin.nominal_value = "2.00" if @coin.is_a? CommemorativeCoin

    if @coin.save then
      country_path = show_country_coins_path(@coin.country.code)
      redirect_to country_path, notice: 'Coin was successfully created.'
    else
      render :new
    end
  end

  def show_country
    @country = Country.find_by_code(params[:country])
    if @country.nil? then
      redirect_to coins_path
    end
    @common_coins = CommonCoin.find_all_by_country_id(@country, order: 'nominal_value asc')
    @commemorative_coins = CommemorativeCoin.find_all_by_country_id(@country, order: 'commemorative_year asc')
  end

  def show_nominal
    @nominal_value = params[:nominal]
    @coins = CommonCoin.joins(:country).find_all_by_nominal_value(@nominal_value, order: '"countries"."name" asc')
  end

  def show_year
    @year = params[:year].to_i
    @coins = CommemorativeCoin.joins(:country).find_all_by_commemorative_year(@year, order: '"countries"."name" asc')
  end

  def edit
    @coin = Coin.find(params[:id])
    @countries = Country.all_ordered_by_name
  end

  def update
    @coin = Coin.find(params[:id])
    @countries = Country.all_ordered_by_name

    coin_hash = params[:coin]
    collected = coin_hash.delete(:collected).to_i == 1
    collected_by = coin_hash.delete(:collected_by)

    @coin.collect(collected ? Time.now : nil, collected_by)

    if @coin.update_attributes(coin_hash) then
      country_path = show_country_coins_path(@coin.country.code)
      redirect_to country_path, notice: 'Coin was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @coin = Coin.find(params[:id])
    @coin.destroy
    redirect_to coins_path
  end

  private
  def new
    @countries = Country.all_ordered_by_name
    render :new
  end
end