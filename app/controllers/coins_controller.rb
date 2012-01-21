# coding: utf-8

class CoinsController < ApplicationController
  skip_before_filter :ensure_signed_in, :except => []

  def index
    @latest_coins = Coin.limit(5).where('collected_at IS NOT NULL').order('collected_at DESC').to_a
    respond_to do |format|
      format.html
      format.json { render json: @nominals }
    end
  end
end