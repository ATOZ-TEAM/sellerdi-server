module Api
  class BaseController < ActionController::API
    before_action :access_control_allow_origin

    def access_control_allow_origin
      response.set_header 'Access-Control-Allow-Origin', '*'
    end
  end
end
