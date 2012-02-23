# coding: utf-8

class CoinsController < ApplicationController
  skip_before_filter :ensure_signed_in, :except => [:new_common, :new_commemorative]

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
    
    #if can? :confirm_coin, @coin
      @coin.collect(collected ? Time.now : nil, collected_by)
    #end

    respond_to do |format|
      if @coin.save then
        format.html { redirect_to(coins_path, notice: 'Coin was successfully created.') }
        format.json { render json: @coin, status: :created, location: @coin }
      end
    end
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