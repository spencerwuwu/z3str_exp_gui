class BenchmarkType < ApplicationRecord
  has_many :benchmark_names
  has_many :days_to_runs
  belongs_to  :display_type
end
