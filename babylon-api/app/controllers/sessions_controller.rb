# Provide Devise support for sessions and authentication
class SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session
  respond_to :json

  # Authenticate, then reset the user's authentication token and sign in
  # rubocop:disable Metrics/AbcSize
  def create
    respond_to do |format|
      format.html { super }
      format.json do
        self.resource = warden.authenticate!(auth_options)
        resource.reset_authentication_token
        sign_in(resource_name, resource)
        data = {
          user_token: resource.authentication_token,
          user_email: resource.email
        }
        render json: data, status: 201
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
