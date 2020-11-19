class ProcessData::ProcessInmesimgDataService < ApplicationService
  # Cmd: InMesImg
  attr_accessor :raw_data

  def initialize(raw_data = {})
    @raw_data = raw_data
  end

  def call
    
  end
end
