module Types
    class RegisterProviderCredentialsInput < BaseInputObject
        graphql_name 'REGISTER_PROVIDER_CREDENTIALS'
        
        argument :name,String,required:true
        argument :email,String,required:true
        argument :password,String,required:true
        argument :password_confirmation,String,required:true
    end
end