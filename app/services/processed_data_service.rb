class ProcessedDataService

  def process_data raw_data_record
    raw_data_record_json = JSON.parse(raw_data_record)
    # parse data
    p_data = {
      :class_id => raw_data_record_json['ClassID'],
      :course_id => raw_data_record_json['CourseID'],
      :data => raw_data_record_json,
      :sid => raw_data_record_json['SID'],
      :cmd => raw_data_record_json['Cmd'],
      :close_time => raw_data_record_json['CloseTime'],
      :start_time => raw_data_record_json['StartTime'],
      :msg_id => raw_data_record_json['_id'],
      :action_time => raw_data_record_json['ActionTime'],
      :source_id => raw_data_record_json['SourceUID']
    }

    # save data to Database
    data = ProcessedData.create!(p_data) 
    if data.errors.any?
      return false
    else
      return data.id
    end

  end

end
