class RawDataService

  def save_raw_data json_data
    data = JSON.parse(json_data)
    result = ''

    if data['Cmd'] == 'InMesImg'
      process = ProcessData::ProcessInmesimgDataService.call(data)

      if process
        data['Content'] = ''
        data['raw_datum']['Content'] = ''

      end

      if RawData.create(data: data.to_json)
        result = {
          "error_info": {
            "errno": 1,
            "error": "程序正常执行"
          }
        }
      end
    else
      process = ProcessedDataService.new.process_data(json_data)

      if RawData.create(data: json_data)
        result = {
          "error_info": {
            "errno": 1,
            "error": "程序正常执行"
          }
        }
      end
    end

    result
  end

  def get_raw_data params
    RawData.page(params[:page]).per(5).select(:id, :data)
  end

end
