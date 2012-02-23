# coding: utf-8

class CoinsController < ApplicationController
  skip_before_filter :ensure_signed_in, :except => [:new_common, :new_commemorative]
  authorize_resource :class => false

  def index
    @latest_coins = Coin.get_latest(5)
    respond_to do |format|
      format.html
      format.json { render json: @nominals }
    end
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

    respond_to do |format|
      if @coin.save then
        format.html { redirect_to(coins_path, notice: 'Coin was successfully created.') }
        format.json { render json: @coin, status: :created, location: @coin }
      end
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

  private
  def new
    @countries = Country.all_ordered_by_name
    respond_to do |format|
      format.html { render :new }
      format.json { render json: @coin }
    end
  end
end