class LessonReport < ApplicationService
  require 'json'

  attr :classin_class_id
  attr :classin_uid

  def initialize(classin_class_id, classin_uid)
    @classin_class_id = classin_class_id
    @classin_uid = classin_uid
  end

  def call
    lesson_report = ToppyLessonReport.where(class_id: classin_class_id, uid: classin_uid).first
    if lesson_report.nil?
      {}
    else
      report_data = lesson_report[:data]

      {
        'onStageTime': report_data['onStageTime'],
        'sessionStartDatetime': report_data['sessionStartDatetime'],
        'sessionEndDatetime': report_data['sessionEndDatetime'],
        'classDuration': report_data['classDuration'],
        'attend': report_data['attend'],
        'authorizeTime': report_data['authorizeTime'],
        'inOutEvent': report_data['inOutEvent'],
        'attendState': report_data['attendState'],
        'speakingTime': report_data['speakingTime'],
        'equipmentStatus': report_data['equipmentStatus'],
        'image': report_data['image'],
      }
    end
  end
end