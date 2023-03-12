class RegistersController < ApplicationController
  def new
    @user = User.new
  end
end
