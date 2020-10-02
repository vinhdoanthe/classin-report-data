class Settings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.string :config_key, null: false, unique: true
      t.string :config_value

      t.timestamps
    end
  end
end
