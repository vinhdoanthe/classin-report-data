class ProcessData::ProcessInmesimgDataService < ApplicationService
  require "zlib"

  # Cmd: InMesImg
  attr_accessor :raw_data

  def initialize(raw_data = {})
    @raw_data = raw_data
  end

  def call
    img_str = @raw_data['Content']
    img_type = {
      '1' => 'bmp',
      '2' => 'jpg',
      '3' => 'gif'
    }

    p_data = {
      :class_id => @raw_data['ClassID'],
      :course_id => @raw_data['CourseID'],
      :data => '',
      :sid => @raw_data['SID'],
      :cmd => @raw_data['Cmd'],
      :close_time => @raw_data['CloseTime'],
      :start_time => @raw_data['StartTime'],
      :msg_id => @raw_data['_id'],
      :action_time => @raw_data['ActionTime'],
      :source_id => @raw_data['SourceUID']
    }

    data = ProcessedData.create(p_data)

    if data.errors.any?
      return false
    else
      return false
      # type = img_type[@raw_data['EmoteType'].to_s]
      # base64_str = convert_base64_to_image img_str, type, data.id
      # base64_str.insert(0, "data:image/#{ type };base64,")

      # if data.image.attach(data: base64_str)
      #   return data.id
      # else
      #   return false
      # end
    end
  end

  def convert_base64_to_image img_str, type, id
    data = Base64.decode64(img_str)
    uncompresse_data = Zlib::Inflate.inflate(data)
    Base64.encode64 uncompresse_data
  end

end
