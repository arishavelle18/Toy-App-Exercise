module Mutations
  class CreateUser < BaseMutation

    # argument
    #  it looks like a strong parameter
    class AuthProviderSignupData <  Types::BaseInputObject
      argument :credentials,Types::RegisterProviderCredentialsInput,required:false
    end

    # connect to  AuthProviderSignupData it should also required
    argument :auth_provider, AuthProviderSignupData,required:false

    # field
    field :user,Types::UserType,null:true
    field :errors,[String],null:false
   
    # create resolver
    def resolve(name:nil,auth_provider:nil)
      user = User.new(
        name: name,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password),
        password_confirmation: auth_provider&.[](:password_confirmation)
      )
      
      if user.save
        {user:user,errors:[]}
      else
        {errors:user.errors.full_messages}
      end

    end
  end
end
