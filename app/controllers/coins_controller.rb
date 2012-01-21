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

  private
  def new
    @countries = Country.all_ordered_by_name
    respond_to do |format|
      format.html { render :new }
      format.json { render json: @coin }
    end
  end
end