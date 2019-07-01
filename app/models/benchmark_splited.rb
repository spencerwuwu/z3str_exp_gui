class BenchmarkSplited < ApplicationRecord
  has_many :benchmark_names
  belongs_to :display_type
end
