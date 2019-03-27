class DaysToRun < ApplicationRecord
  belongs_to :benchmark_type
  belongs_to :tool
end
