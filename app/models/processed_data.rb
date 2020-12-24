class ProcessedData < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  self.table_name = 'processed_data'

  has_one_base64_attached :image
end
