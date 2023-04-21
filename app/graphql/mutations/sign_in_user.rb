module Mutations
  class SignInUser < BaseMutation
    null true

    argument :credentials,Types::AuthProviderCredentialsInput,required:false

    # field
    field :token,String,null:true
    field :user,Types::UserType,null:true
    field :errors,String,null:false

    def resolve(credentials:nil)
      
      # check if the credentials is empty or not
      # return unless credentials

      # get the email
      user = User.find_by(email: credentials[:email])

      #check if the user is authenticate
      if user && user.authenticate(credentials[:password])
      # generate token
        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("user-id:#{user.id}")
        context[:session][:token] = token
        {user:user,token:token,errors:nil}
      else
        {errors:"Incorrect Email or Password"}
      end
      
    end
  end
end
