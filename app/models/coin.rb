class Coin < ActiveRecord::Base
  NOMINAL_VALUES = [2.00, 1.00, 0.50, 0.20, 0.10, 0.05, 0.02, 0.01]

  has_attached_file :image,
    url: '/coins/:id_:style_:basename.:extension',
    path: "#{Rails.root}/public/coins/:id_:style_:basename.:extension",
    styles: {
      normal: '150x150>',
      collected: {
        geometry: '150x150>',
        watermark_path: "#{Rails.root}/public/images/watermark.png",
        position: 'Center',
      },
    },
    default_style: :normal,
    processors: [:watermark]

  belongs_to :country

  validates_attachment_size :image, less_than: 2.megabytes
  validates :nominal_value, inclusion: { in: NOMINAL_VALUES }
  validates :type, presence: true
  validates :country, presence: true

  private_class_method :new, :allocate

  def image_url
    self.image_url self.collected? ? :collected : :normal
  end

  def collected?
    not self.collected_at.nil?
  end

  def collect(collected_at, collected_by)
    if collected_at.nil? then
      self.collected_at = nil
      self.collected_by = nil
    else
      self.collected_at = collected_at if self.collected_at.nil?
      self.collected_by = collected_by
    end
  end

  def self.get_latest(n)
    Coin.limit(n).where(collected_at: 'is not null').order('collected_at desc').to_a
  end
end
