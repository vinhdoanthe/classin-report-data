namespace :report do
  desc 'Handling respond data from classin'
  task :handling_classin_data, [:hours] => :environment do |t, args|
    count_hours = args[:hours].to_i
    time_range = (Time.now - count_hours.hours)..Time.now
    process_datas = ProcessedData.where(created_at: time_range, cmd: 'End').to_a

    process_datas.each do |process_data|
      next if ToppyLessonReport.where(process_data_id: process_data.id).first.present?
      data = ProcessedDataService.new.lesson_report_data process_data
      class_id = process_data.class_id

      data&.each do |uid, u_data|
        report = ToppyLessonReport.new
        report.class_id = class_id
        report.uid = uid
        report.report_type = 'personal'
        report.data = u_data
        report.process_data_id = process_data.id
        report.save
      end
      
      personal_data = ToppyLessonReport.where(process_data_id: process_data.id, report_type: 'personal').first
      next if personal_data.blank?

      data_att = ['sessionStartDatetime', 'sessionEndDatetime', 'classDuration', 'image']

      class_data = {}
      personal_data.data.each{ |k, v| class_data.merge!({ k => v }) if data_att.include? k }

      class_report = ToppyLessonReport.new
      class_report.class_id = personal_data.class_id
      class_report.uid = -1
      class_report.report_type = 'class'
      class_report.process_data_id = personal_data.process_data_id
      class_report.data = class_data
      class_report.save
    end
  end
end
