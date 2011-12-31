class SiteController < ApplicationController
  skip_before_filter :ensure_signed_in
  
  def index
  end

end
