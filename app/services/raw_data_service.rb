class RawDataService

  def save_raw_data json_data
    if RawData.create(data: json_data)
      result = {
        "error_info": {
          "errno": 1,
          "error": "程序正常执行"
        }
      }
    end

    result
  end

  def get_raw_data
    RawData.all.select(:id, :data)
  end

end
