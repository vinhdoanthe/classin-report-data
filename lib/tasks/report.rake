namespace :report do
  desc 'Handling respond data from classin'
  task :handling_classin_data, [:hours] => :environment do |t, args|
    count_hours = args[:hours].to_i
    time_range = (Time.now - count_hours.hours)..Time.now
    process_datas = ProcessedData.where(created_at: time_range, cmd: 'End').to_a

    process_datas.each do |process_data|
      data = ProcessedDataService.new.lesson_report_data process_data
      class_id = process_data.class_id
      next if ToppyLessonReport.where(process_data_id: process_data.id).first.present?

      data&.each do |uid, u_data|
        report = ToppyLessonReport.new
        report.class_id = class_id
        report.uid = uid
        report.data = u_data
        report.process_data_id = process_data.id
        report.save
      end
    end
  end
end
