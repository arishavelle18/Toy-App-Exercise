module Types
  class QueryType < Types::BaseObject
    field :all_users,[UserType],null:false
    field :existing,Boolean,null:false
    field :log_out,Boolean,null:true do
      description "Logout the current user and destroy the session"
    end

    def all_users
      User.all
    end

    def existing
      !context[:session][:token].nil?
    end

    def log_out
      return unless context[:session][:token]
      context[:session][:token] = nil

      # Return true to indicate that the session was deleted
      context[:session][:token].nil?
    end

  end
end
