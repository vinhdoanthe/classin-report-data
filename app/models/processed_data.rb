class ProcessedData < ApplicationRecord
  self.table_name = 'processed_data'

  has_one_attached :image
end
