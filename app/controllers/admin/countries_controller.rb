module Admin
  class CountriesController < ApplicationController
    def index
      @countries = Country.page(params[:page]).order(:name)
      respond_to do |format|
        format.html
        format.json { render json: @countries }
      end
    end
  end
end