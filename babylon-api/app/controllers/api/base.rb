module API
  # Base class for API
  class Base < Grape::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    prefix 'api'
    format :json

    rescue_from :all, backtrace: true
    # error_formatter :json, API::ErrorFormatter

    before do
      error!('401 Unauthorized', 401) unless authenticated
    end

    helpers do
      def warden
        env['warden']
      end

      # rubocop:disable Metrics/AbcSize
      def authenticated
        return false unless headers['Authorization'].present?
        token = (/"(.*?)"/.match headers['Authorization'].split(',').first)[1]
        email = (/"(.*?)"/.match headers['Authorization'].split(',').last)[1]
        return true if warden.authenticated?
        token && @user = User.where(authentication_token: token, email: email)
      end
      # rubocop:enable Metrics/AbcSize

      def current_user
        warden.user || @user
      end
    end

    mount API::V1::Base
  end
end
