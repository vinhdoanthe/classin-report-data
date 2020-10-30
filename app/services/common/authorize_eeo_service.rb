class Common::AuthorizeEeoService < ApplicationService
  require 'digest'

  attr_accessor :schoolSID
  attr_accessor :timeStamp
  attr_accessor :safeKey

  def initialize(schoolSID='', timeStamp='', safeKey='')
    @schoolSID = schoolSID
    @timeStamp = timeStamp
    @safeKey = safeKey
  end

  # return false if authorized, return false if unauthorized
  def call()
    p schoolSID
    # compare schoolSID
    if schoolSID == Settings.schoolSID
      # caculate own safeKey
      rightSafeKey = Digest::MD5.hexdigest("#{Settings.schoolSecret}#{timeStamp}")
      #
      p rightSafeKey
      # compare with safeKey
      if rightSafeKey == safeKey
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
