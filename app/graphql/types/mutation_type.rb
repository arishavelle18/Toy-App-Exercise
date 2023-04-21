module Types
  class MutationType < Types::BaseObject
    field :sign_in_user, mutation: Mutations::SignInUser
    field :create_user, mutation: Mutations::CreateUser
  end
end
