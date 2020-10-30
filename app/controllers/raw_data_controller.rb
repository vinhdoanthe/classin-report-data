class RawDataController < ApiController
  before_action :authorize_eeo_system, only: [:receive_data]
  skip_before_action :authorize_api, only: [:receive_data]

  def receive_data

    json_data = classin_params

    result = RawDataService.new.save_raw_data(json_data)

    render json: result 
  end

  def get_data
    result = RawDataService.new.get_raw_data params
    render json: result 
  end

  private

  def authorize_eeo_system
    unless Common::AuthorizeEeoService.call(schoolSID=params[:SID], timeStamp=params[:TimeStamp], safeKey=params[:SafeKey])
      render json: {
        :err_code => 400,
        :err_msg => 'Unauthorized Request'
      } 
      return
    end
  end

  def classin_params
    params.to_json
  end
end
