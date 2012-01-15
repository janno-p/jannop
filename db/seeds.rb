require 'active_record/fixtures'

dirname = File.join(Rails.root, 'test', 'fixtures')

ActiveRecord::Fixtures.create_fixtures(dirname, :countries)
