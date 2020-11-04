class UpdateProcessedDataTable < ActiveRecord::Migration[6.0]
  def change
    add_column :processed_data, :sid, :integer, limit: 8
    add_column :processed_data, :cmd, :string
    add_column :processed_data, :close_time, :timestamp
    add_column :processed_data, :start_time, :timestamp
    add_column :processed_data, :msg_id, :string
    add_column :processed_data, :action_time, :timestamp
    add_column :processed_data, :source_id, :integer, limit: 8
  end
end
