class Tool < ApplicationRecord
  has_many :test_results
  has_many :days_to_run
end
