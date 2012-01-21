class Country < ActiveRecord::Base
  self.per_page = 15

  def self.all_ordered_by_name
    Country.all(order: 'name ASC')
  end
end
