class SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session
  respond_to :json

  def create
    respond_to do |format|
      format.html { super }
      format.json do
        self.resource = warden.authenticate!(auth_options)
        self.resource.reset_authentication_token
        sign_in(resource_name, resource)
        data = {
          user_token: self.resource.authentication_token,
          user_email: self.resource.email
        }
        render json: data, status: 201
      end
    end
  end

end