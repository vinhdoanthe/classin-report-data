class CreateToppyLessonReportTable < ActiveRecord::Migration[6.0]
  def change
    create_table :toppy_lesson_reports do |t|
      t.integer :class_id, null: false, index: true
      t.integer :uid, null: false, index: true
      t.integer :process_data_id
      t.json :data

      t.timestamps
    end
  end
end
