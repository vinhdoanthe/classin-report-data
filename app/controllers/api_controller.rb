class ApiController < ActionController::API
  
  before_action :set_raven_context
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

  def set_raven_context
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
