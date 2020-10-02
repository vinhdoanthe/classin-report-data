class ClassRelatedData < ActiveRecord::Migration[6.0]
  def change
    create_table :processed_data do |t|
      t.integer :class_id, null: false, index: true
      t.integer :course_id, null: false, index: true
      t.json :data
      t.timestamps
    end

    create_table :raw_data do |t|
      t.json :data
      t.timestamps
    end
  end
end
