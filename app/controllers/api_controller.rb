class ApiController < ActionController::API
  before_action :authorize_api

  private

  def authorize_api
    unless Common::AuthorizeApiService.call(system_code = params[:system_code], system_secret = params[:system_secret])
      render json: {
        err_code: 400,
        err_msg: 'Unauthoried request'
      }
      return
    end
  end
end
