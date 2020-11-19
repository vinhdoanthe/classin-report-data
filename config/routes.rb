Rails.application.routes.draw do
  get 'getdata', to: 'raw_data#get_data'
  post 'receivedata', to: 'raw_data#receive_data' 
  get 'lesson_report', to: 'api#lesson_report'
end
