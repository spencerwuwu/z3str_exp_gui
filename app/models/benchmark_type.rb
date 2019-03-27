class BenchmarkType < ApplicationRecord
  has_many :benchmark_name
  has_many :days_to_run
end
