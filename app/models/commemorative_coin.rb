class CommemorativeCoin < Coin
  validates :commemorative_year, presence: true

  public_class_method :new, :allocate

  def self.release_years
    current_year = Time.now.year
    (2004..current_year).to_a.reverse
  end
end