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
      type = img_type[@raw_data['EmoteType'].to_s]
      convert_base64_to_image img_str, type, data.id

      if data.image.attach(io: File.open(Rails.root.join("app", "raw#{ data.id.to_s }.#{ type }")), filename: "raw#{ data.id.to_s }.#{ type }")
        File.open("app/raw#{ data.id.to_s }.#{ type }", 'r') do |f|
          File.delete(f)
        end

        return data.id
      else
        return false
      end
    end
  end

  def convert_base64_to_image img_str, type, id
    data = Base64.decode64(img_str)
    data = Zlib::Inflate.inflate(data)

    File.open("app/raw#{ id.to_s }.#{ type }", 'wb') { |f| f.write(data) }
  end

end
