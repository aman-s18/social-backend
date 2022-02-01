class Api::ApiV1Controller < ApplicationController

  def check_access_token(user_id, token)
    User.find_by(id: user_id, access_token: token)
  end
  
  def json_success(message, data)
    resp_data = { status: 'success' }
    resp_data[:message] = message
    resp_data[:data] = data
    render json: resp_data, status: 200
  end

  def json_error(message, data)
    resp_data = { status: 'error' }
    resp_data[:message] = message
    resp_data[:data] = data
    render json: resp_data, status: 422
  end
  
end