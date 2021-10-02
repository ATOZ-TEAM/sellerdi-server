module Api
  module Users
    class SessionsController < BaseController

      # api_users_login_path
      # POST   /api/users/login(.:format)
      def create
        render json: User.first
      end

      # api_users_logout_path
      # DELETE /api/users/logout(.:format)
      def destroy
      end

    end
  end
end
