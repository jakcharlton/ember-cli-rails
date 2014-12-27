module API
  module V1
    # Contacts API endpoint
    class Contacts < Grape::API
      include API::V1::Defaults

      before do
        # authenticate_with_http_token do |token, options|
        #     user_email = options[:user_email].presence
        #     user       = user_email && User.find_by_email(user_email)

        #     if user && Devise.secure_compare(user.authentication_token, token)
        #       sign_in user, store: false
        #     end
        # end
      end

      resource :contacts do
        desc 'Return all contacts'
        get '', root: :contacts do
          Contact.all
        end

        desc 'Return a contact'
        params do
          requires :id, type: String, desc: 'ID of the contact'
        end
        get ':id', root: 'contact' do
          Contact.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
