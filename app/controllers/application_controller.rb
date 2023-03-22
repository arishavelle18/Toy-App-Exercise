class ApplicationController < ActionController::Base
    before_action :set_current_user
    
    include LoginsHelper

end
