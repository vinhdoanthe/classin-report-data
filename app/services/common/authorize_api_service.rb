class Common::AuthorizeApiService < ApplicationService

  attr_accessor :system_code
  attr_accessor :system_secret

  def initialize(system_code = '', system_secret = '')
    @system_code = system_code
    @system_secret = system_secret
  end

  def call
    if system_code == Rails.application.credentials[:system_code] && system_secret == Rails.application.credentials[:system_secret]
      return true
    else
      return false
    end
  end 
end
