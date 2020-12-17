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
    data = ProcessedData.create(p_data)

    if data.errors.any?
      return false
    else
      return data.id
    end

  end

  def lesson_report_data process_data
    return if process_data.cmd != 'End'
    data = process_data.data['Data']
    class_start = process_data.data['StartTime']
    class_end = process_data.data['CloseTime']
    attendState = ''
    class_data = {}

    #Stage time
    data['stageEnd'].each do |k, v|
      class_data[k] = { 'onStageTime' => v['UpTotal'], 'sessionStartDatetime' => class_start, 'sessionEndDatetime' => class_end, 'classDuration' => ( class_end - class_start), 'attend' => true}
    end

    #authorize time
    data['authorizeEnd'].each do |k, v|
      if class_data[k].present?
        class_data[k].merge! ({ 'authorizeTime' => v['Total'] })
      else
        class_data[k] = { 'authorizeTime' => v['Total'] }
      end
    end

    #inout event
    data['inoutEnd'].each do |k, v|
      events = []
      v["Details"].each do |e|
        if e['Type'] == 'In'
          attendState = 'late'
          if class_start > e['Time']
            attendState = 'ontime'
          end
        end

        events << { 'eventType' => e['Type'], 'eventTime' => e['Time'] }
      end

      if class_data[k].present?
        class_data[k].merge! ({ 'inOutEvent' => events, 'attendState' => attendState })
      else
        class_data[k] = { 'inOutEvent' => events }
      end
    end

    #speaking time
    data["muteEnd"]["Persons"].each do |k, v|
      if class_data[k].present?
        class_data[k].merge! ({ 'speakingTime' => v['Total'] })
      end
    end

    #equip status
    equip_data = ProcessedData.where(cmd: 'Check', class_id: process_data.class_id).to_a

    equip_data.each do |equip|
      equip_status = {}
      e_data = equip.data["Data"]
      atts = ['MicrophoneArbitrary', 'HeadphoneArbitrary', 'CameraArbitrary']

      atts.each do |att|
        equip_status[att] = if e_data[att] == 1
                   'good'
                 else
                   'bad'
                 end
      end

      if class_data[equip.data['UID'].to_s].present?
        class_data[equip.data['UID'].to_s].merge! ({ 'equipmentStatus' => equip_status })
      else
        class_data[equip.data['UID'].to_s] = { 'equipmentStatus' => equip_status }
      end
    end

    #image
    image_data = ProcessedData.where(class_id: process_data.class_id, cmd: 'EdbImg').all.to_a
    images = []

    image_data.each do |img|
      images << img.data['Url']
    end

    class_data.each do |uid, u_data|
      class_data[uid].merge! ({ 'image' => images })
    end

    class_data
  end

end
