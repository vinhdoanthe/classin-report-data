Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'

  get 'getdata', to: 'raw_data#get_data'
  post 'receivedata', to: 'raw_data#receive_data' 
end
