class AddTypeToToppyLessonReport < ActiveRecord::Migration[6.0]
  def change
    add_column :toppy_lesson_reports, :report_type, :string
  end
end
